:- module(goal_replacement,
    [ goal_replacement/2 ]).

:- use_module(transformer(types)).

% MODE: goal_replacement(+Cls, -Cls1)
% TYPE: goal_replacement(list(clause), list(clause))
% SEMANTICS: Cls1 is the list of clauses obtained by applying goal replacement.

goal_replacement(Cls,GCls) :-
  vs(goal_replacement(Theory,engine(Engine))),
  !,
  goal_replacement(Theory,Engine,Cls,GCls).
goal_replacement(Cls,Cls) :-
  map_log(finest,(write('Skipped'),nl,nl)).


% GOAL-REPLACEMENT SUBSIDIARY STRATEGY

% MODE: goal_replacement(+Theory,+Engine,+Cls, -Cls1)
% TYPE: goal_replacement(term,term,list(clause), list(clause))
% SEMANTICS: Cls1 is the list of clauses obtained by applying goal replacement
% by

goal_replacement(_Theory,_Engine,[],[]) :-
  !.
goal_replacement(Theory,native,[UCl|UCls],RCls2) :-
  vs(theory(Theory,_,(_,Laws),_)),
  !,
  repeat_apply_laws([UCl],Laws,GBds),
  append(GBds,RCls1,RCls2),
  goal_replacement(Theory,native,UCls,RCls1).
% ---
goal_replacement(Theory,chr,[UCl|UCls],RCls2) :-
  !,
  repeat_apply_chr(UCl,Cls),
  append(Cls,RCls1,RCls2),
  goal_replacement(Theory,chr,UCls,RCls1).
% ---
goal_replacement(uf,funct,[UCl|UCls],UClsOut) :-
  ( functionality(UCl, UCl1) ->
    UClsOut = [UCl1|UClsOut1]
  ;
    UClsOut = UClsOut1
  ),
  goal_replacement(uf,funct,UCls,UClsOut1).
% ---
goal_replacement(uf,totfunct,[UCl|UCls],UClsOut) :-
  totality(UCl, UCl1),
  ( functionality(UCl1, UCl2) ->
    UClsOut = [UCl2|UClsOut1]
  ;
    UClsOut = UClsOut1
  ),
  goal_replacement(uf,totfunct,UCls,UClsOut1).
% ---
goal_replacement(bp,bsat,[UCl|UCls],UClsOut) :-
  ( boolean_sat(UCl) ->
    UClsOut = [UCl|UClsOut1]
  ;
    UClsOut = UClsOut1
  ),
  goal_replacement(bp,bsat,UCls,UClsOut1).
% ---
goal_replacement(uf,scc,[UCl|UCls],[SCl|SCls]) :-
  clause_components(UCl,H1,C1,L1),
  map_term_variables((H1,L1),Vars),
  constr_solve(C1,Vars,C2),
  clause_components(SCl,H1,C2,L1),
  goal_replacement(uf,scc,UCls,SCls).
% ---
goal_replacement(uf,cgr,[],[]).
goal_replacement(uf,cgr,[ClI|ClsI],[ClO|ClsO]) :-
  cata_goal_replacement(ClI,ClO), % may fail due to functionality
  !,
  goal_replacement(uf,cgr,ClsI,ClsO).
goal_replacement(uf,cgr,[_ClI|ClsI],ClsO) :-
  goal_replacement(uf,cgr,ClsI,ClsO).
