:- module(unfold_utils, [ unfold_clsel/2 ]).

:- use_module(library(lists),[ append/3 ]).

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
%    unftype == undold ; invoke

%===============================================================================
% UNFOLD AUXILIARY PREDICATES
%-------------------------------------------------------------------------------
% MODE: repeat_unfold(+Uselection,+Cls1,+Prog, -Cls2)
% TYPE: repeat_unfold(uselection,list(clause),list(def),list(clause))
% SEMANTICS: Cls2 is a list of clauses obtained by repeatedly applying
% the unfolding rule according to the selection rule Uselection
% starting from the list Cls1 of clauses and using program Prog.

% repeat_unfold([],[]) :-
%   !.
% repeat_unfold([ClSel|Cls_in],Cls_out) :-
%   unfolding_selection(ClSel,ClSel1),
%   unfold_clsel(ClSel1,CSels),
%   !,
%   append(CSels,Cls_in,Cls_in1),
%   repeat_unfold(Cls_in1,Cls_out).
% repeat_unfold([Cl|Cls_in],Cls_out) :-
%   csel2_to_clause(Cl,Cl1),
%   Cls_out=[Cl1|Cls_out1],
%   repeat_unfold(Cls_in,Cls_out1).

% MODE: unfold_clsel(+ClSel -ClSel)
% TYPE: unfold_clsel(uselection,clause,list(def),clause_sel,list(clause))
% SEMANTICS: Cls is a list of clauses obtained by unfolding once
% clause Cl using program Prog according to the selection rule Uselection.
% ClSel is the clause selection computed by unfolding_selection .

unfold_clsel(ClSel, ClSels) :-
  map_log(finest, (write(' -unfolding clause- '), nl, show_clsel2(ClSel), nl, nl) ),
  unfold_sel_atom(ClSel,ClSels),
  map_log(finest, (write(' -unfolded clauses- '), nl,
    ( ClSels==[] -> ( write('Empty set'), nl ) ; show_clsel2s(ClSels) ), nl) ).


% MODE: unfold_sel_atom(+ClSel,+Prog, -ClSels)
% TYPE: pos_unfold(unftype,clause_sel,list(def), list(clause_sel))
% SEMANTICS: ClSels is a list of clause_sel clauses obtained by
% - unfolding once clause ClSel wrt the selected atom A using program Prog.
unfold_sel_atom(ClSel1,ClSels) :-
  clsel2_components(ClSel1, H,C,G,[unfold(A,URes)|Ls]),
  !,
  map_log(finest,( write(' -unfolding atom- '), nl, copy_term(A,A1),
                   numbervars(A1,0,_), write(A1), nl, nl )),
  labelled_literal(A,Lab,L),
  %%%%
  literal_pred(L,P),
  findall(Cl,cc_inprog:cc(P,Cl),DefP),
  %%%%
  clsel2_components(ClSel2, H,C,G,[unfold(L,URes)|Ls]),
  resolvents(ClSel2,Lab,DefP,ClSels).
% - invoking he selected atom A and collecting the residual goals
unfold_sel_atom(ClSel1,ClSels) :-
  clsel2_components(ClSel1, H,C,G,[invoke(A,URes)|Ls]),
  map_log(finest,( write(' -calling atom- '), nl, copy_term(A,A1),
                   numbervars(A1,0,_), write(A1), nl, nl )),
  labelled_literal(A,Lab,L),
  %%%%
  clsel2_components(ClSel2, H,C,G,[invoke(L,URes)|Ls]),
  findall(ClSel3, pos_call_findall_generator(ClSel2,Lab, ClSel3), ClSels).


% MODE: resolvents(+Cl,+Pos,+Cls, -Res)
% TYPE: resolvents(clause_sel,integer,list(clause), list(clause_sel))
% SEMANTICS: Res is s list of clause_sel clauses obtained by resolving Cl
% with each clause in Cls wrt a selected literal in the body of Cl

resolvents(_Cl,_Pos,[],[]).
resolvents(Cl1,Pos,[Cl2|Cls],Res) :-
  copy_clsel2(Cl1,CpyCl1), clsel2_components(CpyCl1,H1,C1,GL,[S|GR]),
  copy_cl(Cl2,CpyCl2),     clause_components(CpyCl2,H2,C2,G2),
  S = unfold(A1,URes), A1 = H2,
  acyclic_term(A1),
  constr_and(C1,C2,C3), constr_sat(C3),
  post_unfolding_lits(URes,GL,G2,GR,Pos, L,R),
  CSel=(H1,bd(C3,L,R)),
  CSel=CSel1,
  !,
  Res=[CSel1|Res1],
  resolvents(Cl1,Pos,Cls,Res1).
resolvents(Cl1,Pos,[_Cl2|Cls],Res) :-
  resolvents(Cl1,Pos,Cls,Res).


% MODE: post_unfolding_lits(+PSel,+G1,+G2,+Ls, -L,-R)
% Ls is the list of literals not yet considered for unfolding
% ancillary predicate for breadth unfolding strategy (e.g., linearization)
% L = G1 U G2, R = Ls
% G1 U G2 (list of literals considered for unfolding -
% possibly not selected if not unfoldable) will no longer be
% considered for undolfing in subsequent steps
post_unfolding_lits(left,G1,G2,Ls,P, L,R) :-
    labelled_literals(G2,P,PG2),
    append(G1,PG2,L),
    R=Ls.
% ancillary predicate for depth (e.g. specialization) and wqo unfolding strategy
% L=[], R = G1 U G2 U Ls
% add to G1 U G2 (list of literals considered for unfolding -
% possibly not selected if not unfoldable) the literals Ls
% that will be considered for unfolding in a subsequent step.
% Hence, G1 U G2 will be considered again for unfolding
post_unfolding_lits(right,G1,G2,Ls,P, L,R) :-
    labelled_literals(G2,P,PG2),
    append(G1,PG2,G1G2),
    append(G1G2,Ls,R),
    L=[].
% Gs is added to either GLOut or GROut according to the selecting function
% unfoldable_rept/1 defined in the configuration file
:- dynamic user:unfoldable_rept/1.
post_unfolding_lits(filter,GL,[],GR,_P, GL,GR).
%
post_unfolding_lits(filter,GLIn,[G|Gs],GRIn,P, GLOut,GROut) :-
  unfoldable_rept(G),
  !,
  post_unfolding_lits(filter,GLIn,Gs,[G|GRIn],P, GLOut,GROut).
%
post_unfolding_lits(filter,GLIn,[G|Gs],GRIn,P, GLOut,GROut) :-
  append(GLIn,[G],GLIn1),
  post_unfolding_lits(filter,GLIn1,Gs,GRIn,P, GLOut,GROut).


% MODE: pos_call(+CSel, -Cls)
% TYPE: pos_call(clause_sel, list(clause)),
% SEMANTICS: Cls1 is the list of clauses obtained by calling the
% selected atom in CSel
%
pos_call_findall_generator(ClSel1,Pos, ClSel2) :-
  clsel2_components(ClSel1, H,C,G,[invoke(A,URes)|Ls]),
  inprog:A,
  ( called_atom_cns(A,C1)->
    ( 
      constr_and(C,C1,C2), 
      constr_sat(C2) 
    )
  ;
    ( 
      map_log(debugging,(write('called_atom_cns undefined: no contraints have been added '), nl, nl)),
      C2=C 
    )
  ),
  post_unfolding_lits(URes,G,[],Ls,Pos, L,R),
  clsel2_components(ClSel2, H,C2,L,R).
