:- module(gen, [generalization/3]).

% MODE: generalization(+ParDef,+CanDef, -GenDef)
% -- Immediate generalization --
generalization(ParDef,CanDef, NewDef) :-
  vs(delayed_generalization(Skip,_Mode)),
  Skip == 0,
  clause_bd_goal(CanDef, CanGoal),
  !,
  map_log(finest,(write('[Looking for a definition to GENERALIZE]'), nl, nl)),
  % looking for a matching clause
  matching_def(ParDef,CanGoal, SelDef1),
  map_log(finest,(write(' -generalize- '), nl)),
  % projection of the ancestor w.r.t. the variables in the body
  clause_components(SelDef1,H,C1,B),
  term_variables(B,Vars),
  constr_solve(C1,Vars,C2),
  clause_components(SelDef2,H,C2,B),
  % --------------------------------------
  clause_widening(SelDef2,CanDef, GenDef),
  revise_gen_head(SelDef2,GenDef, NewDef),
  show_genres_cls(SelDef2,CanDef, NewDef),
  add_def(NewDef,ParDef).
% -- Delayed generalization --
generalization(ParDef,CanDef, NewDef) :-
  vs(delayed_generalization(Skip,_Mode)),
  map_log(finest,(nl, write(' -delayed generalization-'), nl)),
  clause_bd_goal(CanDef, CanGoal),
  !,
  map_log(finest,(write('[Looking for a definition to GENERALIZE]'), nl, nl)),
  % looking for a matching clause
  matching_def(ParDef,CanGoal, AncDef),
  ( matching_clauses_counter(ParDef,CanGoal,Skip) -> (
    map_log(finest,( write(' (generalization *NOT* delayed)'), nl, nl )),
    clause_widening(AncDef,CanDef, GenDef) )
  ; (
    map_log(finest,( write(' (generalization *delayed*)'), nl, nl )),
    convex_hull_cl(AncDef,CanDef, GenDef)  )
  ),
  revise_gen_head(AncDef,GenDef,NewDef),
  show_genres_cls(AncDef,CanDef,NewDef),
  add_def(NewDef,ParDef).


% SEMANTICS:
matching_def(ParDef,CanGoal, SelDef) :-
  ( AncDef = ParDef ; ancestor_def(ParDef, AncDef) ),
  clause_components(AncDef, H1,C1,G1),
  map_log(debugging,(write(' -testing more_general_goal- '), nl, show_cl(AncDef), nl)),
  more_general_goal(G1,CanGoal, P1),
  clause_components(SelDef, H1,C1,P1).


% SEMANTICS: count the definitions for the delayed generalization (deftree)
matching_clauses_counter(_Def,_Goal,0).
matching_clauses_counter(Def,Goal,N) :-
  ancestor_def(Def,Anc),
  clause_bd_goal(Anc, G1),
  ( more_general_goal(G1,Goal, _P1) -> M is N - 1 ; M = N ),
  matching_clauses_counter(Anc,Goal,M).


% SEMANTICS: replace the head of the generalized definition with a new one
% build from the predicate symbol occurring in the head of the generalized
% definition and the variables belonging to the union of the set of variables
% occurring in the head of the generalized definition and the set of variables
% occurring in the head of ancestor definition
revise_gen_head(Anc,Def1,Def2) :-
  vs(candidate_def_head(linkvar)),
  !,
  copy_term(Anc,Anc1),
  % unify literals of the ancestor
  clause_components(Anc1,Anc1Head,_,Lits),
  % with those of the generalized definition
  clause_components(Def1,Def1Head,C,Lits),
  % Vars = Vars(Anc1Head) U Vars(Def1Head)
  map_term_variables((Anc1Head,Def1Head),Vars),
  Def1Head=..[GDefHeadPred|_],
  % build the new head by using the predicate of the generalized def and Vars
  Def2Head=..[GDefHeadPred|Vars],
  % build the generalized definition with the new head
  clause_components(Def2,Def2Head,C,Lits).
%
revise_gen_head(_Anc,Def,Def).


% MODE: clause_widening(+Cl1,+Cl2, -Gen)
% clause_widening(Cl1,Cl2,Gen) :-
%   copy_cl(Cl1,CpyCl1),
%   copy_cl(Cl2,CpyCl2),
%   clause_components(CpyCl1, _H,C1,G1),
%   clause_components(CpyCl2, H2,C2,G2),
%   G1 = G2,
%   constr_gen(C1,C2,Wd),
%   clause_components(Gen, H2,Wd,G2).
clause_widening(Cl1,Cl2,Gen) :-
  copy_cl(Cl1,CpyCl1),
  copy_cl(Cl2,CpyCl2),
  clause_components(CpyCl1, H1,C1,G1),
  clause_components(CpyCl2, H2,C2,G2),
  G1 = G2,
  constr_gen(C1,C2,Wd),
  H1 =.. [_N|A1], A3=A1, % vars(H3)=vars(H1)
  H2 =.. [N2|_A], N3=N2, % use the (new) name
  H3 =.. [N3|A3],
  clause_components(Gen, H3,Wd,G1).

% MODE: convex_hull_cl(+Cl1,+Cl2, -Gen)
convex_hull_cl(Cl1,Cl2, Cl3) :-
  copy_cl(Cl1,CpyCl1),
  copy_cl(Cl2,CpyCl2),
  clause_components(CpyCl1, _H,C1,G1),
  clause_components(CpyCl2, H2,C2,G2),
  G1 = G2,
  constr_lub(C1,C2,C3),
  clause_components(Cl3, H2,C3,G2).
