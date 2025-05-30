
:- use_module('../../gen.pl').
newdef_from_tbf_def(ClSel2In,CanDef, ClSel2Out,GenDef,[GenDef]) :-
  source_def(ClSel2In, ParDef),
  generalization(ParDef,CanDef, GenDef),
  ClSel2In = ClSel2Out.


:- assert(user:get_transformer_option(inprog_invokable,_N1/_A1:true)),
   assert(user:get_transformer_option(inprog_canonical_conversion,_N2/_A2:false)).

% ------------------------------------------------------------------------------
:- assert(user:vs(query(incorrect/0))).
types:functor_signature(incorrect, 0, [ ], bool).
% ------------------------------------------------------------------------------

% MODE: transf_seq(+N,+Cl,+DefsIn, -FoldedCls,-DefsOut,-NewDefs)
% TYPE: transf_seq(nat,clause,list(def),defs_symtab, list(clause),defs_symtab,defs_symtab)
% SEMANTICS: FoldedCls is the result of applying a transformation sequence to Cl.
transf_seq(N,[Cl|Cls], FoldedCls,ClsToBeProc) :-
  % Unfolding ------------------------------------------------------------------
  map_log(finest,
    ( dashedline, write('[UDF Step 1 - Unfolding]'           ), nl, nl)),
  unfold([Cl],UnfoldedCls),
  % Clause removal -------------------------------------------------------------
  map_log(finest,
    ( dashedline,write('[UDF Step 2 - Remove Useless Clauses]'), nl, nl) ),
  remove_unsat_subsumed(UnfoldedCls,SCls),
  %UnfoldedCls = SCls,
  % Goal Replacement -----------------------------------------------------------
  map_log(finest,
    ( dashedline, write('[UDF Step 2 - Goal Replacement]'    ), nl, nl ) ),
  goal_replacement(SCls,GCls),
  % Definition and Folding -----------------------------------------------------
  map_log(finest,
    ( dashedline, write('[UDF Step 3 - Definition & Folding]'), nl, nl ) ),
  define_fold(GCls,[], FoldedCls,NewDefs),
  append(NewDefs,Cls,ClsToBeProc),
  % ----------------------------------------------------------------------------
  show_iteration_results(N,
    [(unfold,UnfoldedCls),(remove,SCls),(goal_repl,GCls),(define,NewDefs),(fold,FoldedCls)]).

% ------------------------------------------------------------------------------

unfold(ClIn,Cls) :- unf_leftmost_marked(ClIn,Cls).

unf_leftmost_marked([ClIn],Cls) :-
  clause_components(ClIn,    H,C,   [A|R]),
  ( is_callable(_Ctx,A) -> S = invoke(A,right) ; S = unfold(A,right) ),
  clsel2_components(ClSelIn, H,C,[],[S|R]),
  unfold_clsel(ClSelIn,ClSels),
  repeat_unfold(ClSels,Cls).

% MODE: repeat_unfold(+Uselection,+Cls1,+Prog, -Cls2)
% TYPE: repeat_unfold(uselection,list(clause),list(def),list(clause))
% SEMANTICS: Cls2 is a list of clauses obtained by repeatedly applying
% the unfolding rule according to the selection rule Uselection
% starting from the list Cls1 of clauses and using program Prog.
repeat_unfold([],[]) :-
  !.
repeat_unfold([ClSel|Cls_in],Cls_out) :-
  unfolding_selection(ClSel,ClSel1),
  unfold_clsel(ClSel1,CSels),
  !,
  append(CSels,Cls_in,Cls_in1),
  repeat_unfold(Cls_in1,Cls_out).
repeat_unfold([Cl|Cls_in],Cls_out) :-
  csel2_to_clause(Cl,Cl1),
  Cls_out=[Cl1|Cls_out1],
  repeat_unfold(Cls_in,Cls_out1).  

% MODE: unfolding_selection(+ClSel1, -ClSel2)
% TYPE: unfolding_selection(clause,clause_sel)
% SEMANTICS: ClSel2 is obtained from ClSel1 by selecting the first unfoldable
% literal from ClSel1.
% An atom A is marked for unfolding by enclosing it inside a term of the form
% unfold(A,P) or invoke(A,P) to denote the operation (unfold or call)
% to be performed on A, and where to move the result of the unfolding
unfolding_selection(ClSelIn, ClSelOut) :-
  clsel2_components(ClSelIn,  H,C,L,[A|R]),
  is_callable(_Ctx,A),
  !,
  S = invoke(A,right),
  clsel2_components(ClSelOut, H,C,L,[S|R]).
%
unfolding_selection(ClSelIn, ClSelOut) :-
  clsel2_components(ClSelIn,  H,C,L,[A|R]),
  is_unfoldable(_Ctx,A),
  !,
  S = unfold(A,right),
  clsel2_components(ClSelOut, H,C,L,[S|R]).
%
unfolding_selection(ClSelIn, ClSelOut) :-
  clsel2_components(ClSelIn,  H,C,L,[A|R]),
  append(L,[A],M),
  clsel2_components(ClSelIn1, H,C,M,   R),
  unfolding_selection(ClSelIn1, ClSelOut).



% MODE: folding_selection(+Cl, -Cl_sel)
% TYPE: folding_selection(clause, clause_sel)
% SEMANTICS: Cl_sel is a clause obtained by splitting the list G of body literals
% of Cl into two parts: G=G1@[L|G2]
folding_selection(Cl,ClSel) :-
  clause_components(Cl,   H,C,L), L=[_|_],
  folding_selection_(L, NTbf,Tbf),
  clsel2_components(ClSel,H,C,NTbf,Tbf).

%
folding_selection_([], [],[]).
%
folding_selection_([L|Ls], NTbf,[[L]|Tbf]) :-
  foldable(_Fselection,L),
  !,
  folding_selection_(Ls, NTbf,Tbf).
%
folding_selection_([L|Ls], [L|NTbf],Tbf) :-
  folding_selection_(Ls, NTbf,Tbf).


% ------------------------------------------------------------------------------
% MODE: candidate_def(+Csel2, -CD)
candidate_def(ClSel2, CD) :-
  map_log(finest,
    (write('[UDF Step 4.2.1 - Generating the candidate definition]'), nl, nl)),
  % - prologue ---------------------------------------------------------------
  copy_clsel2(ClSel2,CpyClSel2),
  clsel2_bd_2nd_goal(CpyClSel2, [Tbf|_Rhs]), % Tbf = To be folded
  % 1. CNS -------------------------------------------------------------------
  constr_tt(NewC),
  % 2. HEAD ------------------------------------------------------------------
  candidate_def_head(CpyClSel2, NewH),
  % - epilogue ---------------------------------------------------------------
  CD=(NewH,bd(NewC,Tbf)),
  map_log(finest,(write(' -(pre)-candidate- '), nl, show_cl(CD), nl)).

% ------------------------------------------------------------------------------
canonical_cls(Head,Body, CCls) :-
  findall(CCl, (
    split_ineqs(Body, Body1), constr(Body1,Constr, Goal),
    clause_components(CCl, Head,Constr,Goal) ),  CCls ).
