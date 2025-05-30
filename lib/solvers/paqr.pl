:- module(paqr,
    [ constr/3
    , constr/2
    , is_qr_constr/1
    , constr_vars/2
    , constr_copy/2
    , constr_ff/1
    , constr_tt/1
    , constr_and/3
    , constr_sat/1
    , constr_imp/2
    , constr_solve/3
    , constr_gen/3
    , constr_lub/3
    ]).


:- use_module(library(clpb)).

:- discontiguous
    entails/3,
    solve/4.

:- include('theories/rationals').
:- include('theories/arrays').

:- use_module('../../src/types.pl').

% ------------------------------------------------------------------------------
% MODE: constr(+TermLst1, -ConstrLst,-TermLst2)
% MODE: constr(-TermLst1, +ConstrLst,+TermLst2)
% SEMANTICS: ConstrLst is the list of the solver objects encoding terms in
% TermLst1 interpreted in the theories handled by the solver and TermLst2
% is the list of uninterpreted terms occurring in TermLst1.
constr(TermLst,Constr,TermLst1) :-
  nonvar(TermLst), var(Constr),
  constr_(TermLst,RatLst,ReadLst,WriteLst,TermLst1),
  !,
  Constr = [(rat,RatLst),(array,[(read/3,ReadLst),(write/4,WriteLst)]) ].
constr(TermLst,Constr,TermLst1) :-
  var(TermLst), nonvar(Constr),
  Constr = [(rat,RatLst),(array,[(read/3,ReadLst),(write/4,WriteLst)])],
  !,
  append(ReadLst,WriteLst, ArrayLst),
  append(RatLst,ArrayLst, ConstrLst),
  ( TermLst1 == [] -> TermLst = ConstrLst ; append(ConstrLst,TermLst1,TermLst) ).
constr(TermLst,Constr,_TermLst1) :-
  var(TermLst), var(Constr),
  !,
  throw('constr/3: Arguments are not sufficiently instantiated').
% constr/3 utility predicate
constr_([],[],[],[],[]).
constr_([Term|TermLst],[Term|RatLst],ReadLst,WriteLst,TermLst1) :-
  is_qr_constr(Term),
  !,
  constr_(TermLst,RatLst,ReadLst,WriteLst,TermLst1).
constr_([Term|TermLst],RatLst,[Term|ReadLst],WriteLst,TermLst1) :-
  functor(Term,read,3),
  !,
  constr_(TermLst,RatLst,ReadLst,WriteLst,TermLst1).
constr_([Term|TermLst],RatLst,ReadLst,[Term|WriteLst],TermLst1) :-
  functor(Term,write,3),
  !,
  constr_(TermLst,RatLst,ReadLst,WriteLst,TermLst1).
constr_([Term|TermLst],RatLst,ReadLst,WriteLst,[Term|TermLst1]) :-
  constr_(TermLst,RatLst,ReadLst,WriteLst,TermLst1).


is_qr_constr(Term) :-  
	functor(Term,Op,2),
	memberchk(Op,['=','=:=','=<','<','>=','>','=\\=']).

	
% ------------------------------------------------------------------------------
% MODE: constr(+TermLst, -Constr)
% MODE: constr(-TermLst, +Constr)
% SEMANTICS: same as constr(+TermLst, -Constr,[]) and
% constr(-TermLst, +Constr,[])
constr(TermLst,Constr) :-
  constr(TermLst,Constr,[]).

% ------------------------------------------------------------------------------
% MODE: constr_vars(+Constr, -VarsLst)
% SEMANTICS: VarsLst is the list of variables occurring in Constr.
constr_vars(Constr,VarsLst) :-
  term_variables(Constr,VarsLst).

% ------------------------------------------------------------------------------
% MODE: constr_copy(+ConstrIn, -ConstrOut)
% SEMANTICS: ConstrOut is a copy of -ConstrIn
% REVIEW: this is call is performed after a copy_term on the whole clause
constr_copy(C,CpyC) :-
  copy_term(C,CpyC).

% ------------------------------------------------------------------------------
% MODE: constr_tt(?Constr)
% SEMANTICS: Constr represent the constant true
constr_tt([(rat,[]),(array,[(read/3,[]),(write/4,[])])]).

% ------------------------------------------------------------------------------
% MODE: constr_ff(?Constr)
% SEMANTICS: Constr represent the constant false
constr_ff([false]).

% ------------------------------------------------------------------------------
% MODE: constr_and(+ConstrA,+ConstrB, -ConstrC)
% SEMANTICS: ConstrC is the conjunction of ConstrA and ConstrB
constr_and(A,_,C) :- constr_ff(A), !, A = C.
constr_and(_,B,C) :- constr_ff(B), !, B = C.
constr_and(A,B,C) :- constr_tt(A), !, B = C.
constr_and(A,B,C) :- constr_tt(B), !, A = C.
constr_and(A,B,C) :-
  A = [
    (rat,  A_ClpQLst ),
    (array,[(read/3,A_ReadLst),(write/4,A_WriteLst)]) ],
  B = [
    (rat,  B_ClpQLst ),
    (array,[(read/3,B_ReadLst),(write/4,B_WriteLst)]) ],
  C = [
    (rat,  C_ClpQLst ),
    (array,[(read/3,C_ReadLst),(write/4,C_WriteLst)]) ],
  append(A_ClpQLst, B_ClpQLst, C_ClpQLst),
  append(A_ReadLst, B_ReadLst, C_ReadLst),
  append(A_WriteLst,B_WriteLst,C_WriteLst).

% ------------------------------------------------------------------------------
% MODE: constr_sat(+Constr)
% SEMANTICS: Constr is satisfiable
constr_sat(Constr) :-
  constr_ff(Constr), !, fail.
constr_sat(Constr) :-
  constr_tt(Constr), !.
constr_sat(Constr) :-
  constr_copy(Constr,CpyConstr),
  CpyConstr = [
  (rat, ClpQLst ),
  (array,[(read/3,_ReadLst),(write/4,_WriteLst)]) ],
  !,
  satisfiable(rat,ClpQLst).

% ------------------------------------------------------------------------------
% MODE: constr_imp(+ConstrP,+ConstrQ)
% SEMANTICS: ConstrP implies ConstrQ
% _ConstrP -> true
constr_imp(_ConstrP,ConstrQ) :-
  constr_tt(ConstrQ), !.
% false -> _ConstrQ
constr_imp(ConstrP,_ConstrQ) :-
  constr_ff(ConstrP), !. % (*)
% ConstrP -/-> false, with ConstrP =\= false (due to the cut right above *)
constr_imp(_ConstrP,ConstrQ) :-
  constr_ff(ConstrQ), !, fail.
% ConstrP and ConstrQ different from true and false
constr_imp(ConstrP,ConstrQ) :-

  copy_term((ConstrP,ConstrQ),(CpyConstrP,CpyConstrQ)),

  CpyConstrP = [ (rat, P_ClpQLst ),(array,[(read/3,P_R),(write/4,P_W)]) ],
  CpyConstrQ = [ (rat, Q_ClpQLst ),(array,[(read/3,Q_R),(write/4,Q_W)]) ],

  append(P_R,P_W,P_A), append(Q_R,Q_W,Q_A), entails(array,P_A,Q_A),

  entails(rat,P_ClpQLst,Q_ClpQLst).

% ------------------------------------------------------------------------------
% MODE: constr_solve(+ConstrIn,+Vars, -ConstrOut)
% SEMANTICS: ConstrOut is a constraint, whose variables are in Vars,
% that is equivalent to ConstrIn.
% TODO: solve for Arrays
constr_solve(ConstrIn,_Vars, ConstrOut) :-
  ( constr_tt(ConstrIn) ; constr_ff(ConstrIn) ),
  !,
  ConstrIn = ConstrOut.
constr_solve(ConstrIn,Vars, ConstrOut) :-
  ConstrIn = [ (rat,Q),(array,[(read/3,R),(write/4,W)]) ],
  rw_basic_variables(R,W,RWVars), append(RWVars,Vars,Vars1),

  solve(rat,Q,Vars1,SQ),
  ( SQ = [false] ->
    constr_ff(ConstrOut)
  ;
    ConstrOut = [ (rat,SQ),(array,[(read/3,R),(write/4,W)]) ]
  ).

% ------------------------------------------------------------------------------
% MODE: constr_gen(+ConstrA,+ConstrB, -ConstrG)
% SEMANTICS: ConstrG is the generalization of ConstrA w.r.t ConstrB
% ASSUMPTION: the list of read (write) constraints in ConstrA is a variant of _ConstrB
constr_gen(ConstrA,ConstrB, ConstrG) :-
  ConstrA = [ (rat,C1), (array,[(read/3,R1),(write/4,W1)]) ],
  ConstrB = [ (rat,C2), (array,[(read/3,R2),(write/4,W2)]) ],
  R1 = R2,
  W1 = W2,
  primitives(C1,I1),
  plain_cns_widening(I1,C2,C3),
  ConstrG = [ (rat,C3), (array,[(read/3,R2),(write/4,W2)]) ].

% ------------------------------------------------------------------------------
% MODE: constr_lub(+ConstrA,+ConstrB, -ConstrL)
% SEMANTICS: -ConstrL is the least upper bound of ConstrA and ConstrB
:- load_files(hull_clpq,[qcompile(part)]).
constr_lub(ConstrA,ConstrB, ConstrL) :-
  ConstrA = [ (rat,C1), (array,[(read/3,R1),(write/4,W1)]) ],
  ConstrB = [ (rat,C2), (array,[(read/3,R2),(write/4,W2)]) ],
  R1 = R2,
  W1 = W2,
  term_variables((C1,C2),Vars),
  copy_term((Vars,C2),(CpyVars,CpyC2)),
  convex_hull(Vars,C1,CpyVars,CpyC2,ChVars,Ch),
  int_coeff_transf(Ch,C3),
  ChVars = Vars,
  ConstrL = [ (rat,C3), (array,[(read/3,R2),(write/4,W2)]) ].
