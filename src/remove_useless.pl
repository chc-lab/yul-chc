:- module(remove_useless,
    [ remove_unsat_subsumed/2
    , remove_subsumed/2
    , remove_unsat/2
    ]).


remove_unsat_subsumed(UnfoldedCls,SCls) :-
  remove_unsat(UnfoldedCls,UnfoldedCls1),
  remove_subsumed(UnfoldedCls1,SCls).


%===============================================================================
% REMOVE_UNSAT_SUBSUMED SUBSIDIARY STRATEGY
%-------------------------------------------------------------------------------

% MODE: remove_unsat(+Def1,-Def2)
% TYPE: remove_unsat(list(clause),list(clause))
% SEMANTICS: Def2 is obtained by removing from Def1 all clauses
% whose constraint is unsatisfiable

remove_unsat([],[]).
remove_unsat([Cl|ClsIn],ClsOut) :-
  clause_bd_cns(Cl,Cns),
  ( constr_sat(Cns) ->
    ClsOut = [Cl|ClsOut1]
  ;
    ClsOut = ClsOut1
  ),
  !,
  remove_unsat(ClsIn,ClsOut1).

% MODE: remove_subsumed(+Def1,-Def2)
% TYPE: remove_subsumed(list(clause),list(clause))
% SEMANTICS: Def2 is obtained by removing from Def1 all clauses
% subsumed by a constrained fact in Def1.

remove_subsumed([],[]).
remove_subsumed(Cls,Cls) :- %Temporary
  vs(theory(array,_,_,_)),
  !,
  map_log(finest,(write('Skipped'),nl,nl)).
remove_subsumed([Cl1|Cls],Ds) :-
  select(Cl2,Cls,Cls1),
  cfact_subsumes_clause_chk(Cl1,Cl2),
  !,
  remove_subsumed([Cl1|Cls1],Ds).
remove_subsumed([Cl|Cls],[Cl|Ds]) :-
  remove_subsumed(Cls,Ds).


% MODE: cfact_subsumes_clause_chk(+Cl1,+Cl2)
% TYPE: cfact_subsumes_clause_chk(clause,clause)
% SEMANTICS: Cl1 is a constrained fact and Cl1 subsumes Cl2
cfact_subsumes_clause_chk((H,bd(C,[])),(H2,bd(C2,_G2))) :-
  copy_cl((H,bd(C,[])),(H1,bd(C1,[]))),
  subsumes_chk(H1,H2),
  H1=H2,
  constr_imp(C2,C1).
