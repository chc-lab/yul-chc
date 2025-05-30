:- use_module(transformer(unfold_utils)).
:- use_module(transformer(remove_useless)).
:- use_module(transformer(goal_replacement)).
:- use_module(transformer(define_fold_utils)).

% TYPES
%
% Base types: term, predicate, nat, rat, any.
% Type constructors: list/1.
% Type definitions:
%    atom == predicate(term1,...,termN).
%    literal == atom; \+ atom.
%    clause == (atom, bd(list(constraint),list(literal))).
%    clause_tree = list((atom,list(list(clause)))).
%    arity == nat.
%    def == (predicate/arity,list(clause)).
%    bit == 0; 1.


% MODE: verify_specialize(+Prog,+Phi,-Pspec,-Defs)
% TYPE: verify_specialize(list(def),predicate,list(def),clause_tree)
% SEMANTICS:
% Pspec is the output of the application of the specialization strategy
% to Prog starting from the single clause for Phi
% Defs is the tree of definitions introduced during the application of the strategy.
:- dynamic t_loop_prologue:transf_seq_prologue/2.
transform(Pspec) :-
  % initialize reader for vsl specification
  (vs(specfile(_)) -> (
    v_setting(spec(triple)),
    v_setting(do_not_auto_set_global_vars),
    load_vsl_translator                     )
  ;
    true
  ),
  ( vs(clause_reversal) -> clause_reversal ; true ),
  % retrieve queries
  findall(QPred, vs(query(QPred)), Preds), % query
  ( Preds==[] -> map_warning(write('No query has been specified.')); true ),
  findall(Cl, ( member(Pred,Preds), cc_inprog:cc(Pred,Cl) ), Cls),
  %
  labelled_initial_def(Cls,LCls),
  %%
  map_log(finer,(nl, write('---transformation strategy--- '), nl,nl)),
  ( t_loop_prologue:transf_seq_prologue(LCls, LClsIn) ->
    transform_cls(1,LClsIn,[], ClsOut)
  ;
    transform_cls(1,LCls,[], ClsOut)
  ),
  ( ClsOut \== [] ->
    (
      preds_in_cls(ClsOut,[],ClsOutPreds),
      cls_to_defs(ClsOutPreds,ClsOut,Pspec)
    )
  ;
    Pspec = []
  ).

%%%%
cls_from_inprog(ClsOut,ClsOut1) :-
  preds_in_bd_cls(ClsOut,[],PredsBdOut),
  preds_in_hd_cls(ClsOut,[],PredsHdOut),
  cls_from_inprog(PredsBdOut,PredsHdOut,ClsOut,ClsOut1).
%
cls_from_inprog(NewPreds,Preds,ClsIn, ClsOut) :-
  findall(ICl,
    ( member(Pred,NewPreds), \+ memberchk(Pred,Preds), cc_inprog:cc(Pred,ICl) ),
    Cls),
  ( Cls == [] ->
    ClsOut = ClsIn
  ;
    ( append(NewPreds,Preds,Preds1),
      new_preds_in_cls(Cls,Preds1, NewPreds1), % (*)
      append(ClsIn,Cls,ClsIn1),
      cls_from_inprog(NewPreds1,Preds1,ClsIn1, ClsOut) )
  ).
% (*) clauses from the input program may depend on other clauses of the input
% program not occurring in the transformed program
new_preds_in_cls(Cls,OldPreds,NewPreds) :-
  preds_in_bd_cls(Cls,[],Preds),
  findall(NewPred,
    ( member(NewPred,Preds), \+ member(NewPred,OldPreds) ), NewPreds).


% MODE: transform_cls(+N,+Cls1,+Cls2, -Cls3)
% TYPE: transform_cls(nat,list(clause),list(clause), list(clause))
% SEMANTICS: Cls3 consisting of the clauses obtained by transforming
% Cls1, and the clauses in Cls2
% N counts the number of iterations of the tranformation strategy.
:- dynamic t_loop_epilogue:transf_seq_epilogue/2.
transform_cls(N,Cls,_TransfClsAcc1, []) :-
  vs(max_UDF_iterations(Max_UDF_iterations)),
  N > Max_UDF_iterations,
  show_UDF_interruption_message(Cls,Max_UDF_iterations).
transform_cls(N,[],TransfClsIn, TransfClsOut) :-
  % find clauses in the initial program occurring in the transformed program
  cls_from_inprog(TransfClsIn,TransfClsIn1),
  % TODO: add the definition of transf_seq_epilogue to all transformation strategies
  ( t_loop_epilogue:transf_seq_epilogue(TransfClsIn1, TransfClsOut) ->
    true
  ;
    TransfClsIn1=TransfClsOut
  ),
  show_transf_seq_epilogue(N,TransfClsOut).
transform_cls(N,Cls,TransfClsAcc, Cls_out) :-
  show_UDF_iteration_info(N),
  transf_seq(N,Cls, TransfCls,NewDefs),
  N1 is N+1,
  append(TransfClsAcc,TransfCls, TransfClsAcc1),
  transform_cls(N1,NewDefs,TransfClsAcc1, Cls_out).

% ------------------------------------------------------------------------------
clause_reversal :-
  map_log(finest, (nl, write('Reversing ... ')) ),
  findall(Cl, cc_inprog:cc(_,Cl), Cls),
  reverse_cls(Cls,RCls),
  !,
  map_log(finest, ( write('OK'), nl ) ),
  retractall(cc_inprog:cc(_,_)),
  findall(_, ( member(RCl,RCls), hd_pred(RCl,Pred), assertz(cc_inprog:cc(Pred,RCl)) ), _),
  map_log(finest,show_inprog).
clause_reversal.

% MODE: reverse_cls(+Cls, -RCls)
reverse_cls([],[]).
% constrained fact ==> query
reverse_cls([Cl|Cls],[RCl|RCls]) :-
  clause_components(Cl,H,C,[]),   % constrained fact
  !,
  vs(query(P/_)),
  clause_components(RCl,P,C,[H]), % query clause
  reverse_cls(Cls,RCls).
% linear query clause ==> constrained fact
reverse_cls([Cl|Cls],[RCl|RCls]) :-
  clause_components(Cl,H,C,[G]),
  functor(H,P,N), vs(query(P/N)),
  !,
  clause_components(RCl,G,C,[]),
  reverse_cls(Cls,RCls).
% reverse a linear clause
reverse_cls([Cl|Cls],[RCl|RCls]) :-
  clause_components(Cl,H,C,[G]),    
  !,
  clause_components(RCl,G,C,[H]),
  reverse_cls(Cls,RCls).
% nonlinear clause 
reverse_cls([Cl|_],[]) :-
  map_error(
  (write('Can\'t apply clause reversal: nonlinear clause found: '), nl,
    show_cl(Cl))
  ).