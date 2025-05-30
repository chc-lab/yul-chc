
:- include('isolver.pl').

:- dynamic projection_temporary/1.

%%% From F. solvers.pl
%%% solve(Solver,C,IntVars,PC):
%%% PC is the projection of C over the variables in the list IntVars
%%% using solver Solver
%%%  - C,PC are constraints
%%%  - T is a term
%%% IMPORTANT NOTICE: vars(IntVars) must be included in vars(C)

ie_solve(ConsLst, IntVarsInitial, PConsLst) :-
%solve(rat,ConsLst, IntVars, PConsLst) :-
    map_term_variables(ConsLst,ConsVars),
    intersection_vars(IntVarsInitial,ConsVars,IntVars),
    !,
    (ConsLst==[] ->
         PConsLst=[]
    ;
        ( member_chk(false,ConsLst) ->
              PConsLst=[false]
        ;
        (list_to_constraint(rat,ConsLst,C),
            retractall(projection_temporary(_)),
            assert((projection_temporary(IntVars) :- C)),
            (projection_temporary(IntVars1) ->
                get_singletons(IntVars,IntVars1,Eqs,DumpVars,DumpVars1),
                reverse(DumpVars1,RDumpVars1), % REVIEW
                reverse(DumpVars,RDumpVars),   % REVIEW
                dump(RDumpVars1,RDumpVars,D),
                fix_equalities_rat(D,IntVars,DF),
                append(Eqs,DF,PConsLst1),
		sort(PConsLst1,PConsLst) % remove duplicates
            ;
            PConsLst=[false]
        )
        ))
    ).


list_to_constraint(rat,L,C) :-
    ( L=[] -> C={1=1}
    ;
        list_to_rat_constraint(L,C)
    ).

list_to_rat_constraint([X],{X}).
list_to_rat_constraint([X,Y|Xs],{X,CXs}):-
    list_to_rat_constraint([Y|Xs],{CXs}).

get_singletons([],[],[],[],[]).
get_singletons([VC|VCs],[VC1|VC1s],P,DV,DV1) :-
    (ground(VC1) ->
        % build equality
        functor(PC,=,2),
        arg(1,PC,VC),
        arg(2,PC,VC1),
        P=[PC|PCs],
        get_singletons(VCs,VC1s,PCs,DV,DV1)
    ;
        % collect vars to dump on
        DV=[VC|DVs],DV1=[VC1|DV1s],
        get_singletons(VCs,VC1s,P,DVs,DV1s)
    ).


fix_equalities_rat([],_,[]).
fix_equalities_rat([C|Cs],Vars,C1s) :-
	functor(C,'=',2),!,
	(vars_subset(C,Vars) ->
		fix_equality(C,C1),
		C1s=[C1|C2s]
	;
		( (arg(2,C,RHS),var(RHS),arg(1,C,LHS),var(LHS)) ->
			(
			% call and remove equalities involving existential variables introduced by 'dump'
			call(C),
			C1s=C2s
			)
		;
			/*
			(  (trace, term_variables(C,CVars),free_variables(CVars,Vars,[],ExVars),ExVars=[ExVar]) ->
			(free_variables(CVars,ExVars,[],NonExVars),
			solve(rat,[C],[ExVar|NonExVars],[C1]),
			call({C1}),
			C1s=C2s)
			;
			C1s=[C|C2s]
			)
			*/
			C1s=[C|C2s]
		)
	),
    fix_equalities_rat(Cs,Vars,C2s).

fix_equalities_rat([C|Cs],Vars,[C|C1s]) :-
	fix_equalities_rat(Cs,Vars,C1s).

fix_equality(LHS=RHS,LHS=RHS).


satisfiable(rat,C) :-                    %from F.  solve_constraints.pl
  member_chk(false,C),
  !,
  fail.
satisfiable(rat,C) :-
  map_deep_copy_term(C,C1),
  list_to_constraint(rat,C1,C2),
  call(C2).


entails(rat,CL,DL) :-
    !,
    (CL==[] -> DL=[]
    ;
        (DL==[] ->
        true
        ;
        (\+ satisfiable(rat,DL) ->
            CL=[false]
        ;

            (satisfiable(rat,CL) ->
            list_to_constraint(rat,CL,C),
            list_to_constraint(rat,DL,D),
            entails_rat(C,D)
            ;
            true
            )
        )
        )
    ).


% entails_rat(C,D): C entails D
%  - C,D are constraints of the form {c1,...,cn}
%
% Note for CLPQ: (does this apply also to  other domains?)
% copy_term needed to not bind variables to rationals
% this would cause trouble with   numbervars/3

entails_rat(C,D) :-
    (copy_term(C,C1),\+C1 -> true
    ;
    % entailed does not like curly brackets
        (copy_term((C,D),(C2,{D2})),
        C2,entailed(D2) -> true
        ;
        fail)
    ).


% primitives(C1,C2)
% C2 is the result of transforming equalities in C1
% to a conjunction of inequalities
primitives([],[]).
primitives([C|Cs],PC) :-
    ((functor(C,'=:=',2);functor(C,'=',2)) ->
        arg(1,C,LHS), arg(2,C,RHS),
        PC1 =.. ['=<',LHS,RHS], PC2 =.. ['=<',RHS,LHS],
        PC=[PC1,PC2|PCs]
    ;
        PC=[C|PCs]
    ),
    primitives(Cs,PCs).

% normalize_list(+P,-N)
% normalizes a list of primitive constraints
normalize_list([],[]).
normalize_list([P|Ps],[N|Ns]) :-
	normalize_primitive(P,N),
	normalize_list(Ps,Ns).

% normalize_primitive(+P,-N)
% P is a primitive constraint (inequation of the form Exp1 RelOp Exp2,
% where RelOp is one of >,<,>=, =< )
% N is a normalized (primitive) constraint equivalent to P of the form
% Exp RelOp 0, where RelOp is one of <,=<
%normalize_primitive(P,N) :-
%	functor(P,F,2),(F='<';F='=<'),!,
%	arg(1,P,LHS), arg(2,P,RHS),
%	( (LHS==rat(0,1) ; LHS==0) ->   NewLHS =.. ['-',RHS] ;    NewLHS =.. ['-',LHS,RHS]    ),
%	N=.. [F,NewLHS,0].
%normalize_primitive(P,N) :-
%	functor(P,F,2),(F='>';F='>='),
%	arg(2,P,LHS), arg(1,P,RHS),
%	( (LHS==rat(0,1) ; LHS==0 ) ->   NewLHS =.. ['-',RHS] ;    NewLHS =.. ['-',LHS,RHS]    ),
%	inverse_relop(F,F1),
%	N=.. [F1,NewLHS,0].
%normalize_primitive(P,N) :-
%	functor(P,=\=,2),!, N=P.
normalize_primitive(P,N) :-
	functor(P,F,2),
    (F='<';F='=<'),
    !,
	arg(1,P,LHS),
    arg(2,P,RHS),
	( map_rational(LHS,0,1) ->
      NewLHS =.. ['-',RHS]
    ;
      NewLHS =.. ['-',LHS,RHS]
    ),
	N=.. [F,NewLHS,0].
%
normalize_primitive(P,N) :-
	functor(P,F,2),
    (F='>';F='>='),
    !,
	arg(2,P,LHS),
    arg(1,P,RHS),
	( map_rational(LHS,0,1) ->
      NewLHS =.. ['-',RHS]
    ;
      NewLHS =.. ['-',LHS,RHS]
    ),
	inverse_relop(F,F1),
	N=.. [F1,NewLHS,0].
%
normalize_primitive(P,N) :-
	functor(P,=\=,2),
    N=P.


%
inverse_relop('>','<').
inverse_relop('>=','=<').
inverse_relop('<','>').
inverse_relop('=<','>=').


%
inverse_primitive_int(X=<Y, I) :- term_variables(X=<Y,V), solve(rat,[X>=Y+1],V,[I]).
inverse_primitive_int(X>=Y, I) :- inverse_primitive_int(Y=<X,I).
inverse_primitive_int(X<Y,I) :- inverse_primitive_int(X+1=<Y,I).
inverse_primitive_int(X>Y,I) :- inverse_primitive_int(Y+1=<X,I).
inverse_primitive_int(X=\=Y, X=Y).
inverse_primitive_int(X=Y, X=\=Y).
inverse_primitive_int(X=Y, X=\=Y).


inverse_primitives_int([],[]).
inverse_primitives_int([P|Ps],[I|Is]) :-
	inverse_primitive_int(P,I),
	inverse_primitives_int(Ps,Is).


% ------------------------------------------------------------------------------
%%%%%%%%% plain_widening
/*
plain_widening(D1,D2,D3) :-
	copy_term(D1,(_H1,bd(C1,B1))),
	copy_term(D2,(H2,bd(C2,B2))),
	B1=B2,
	primitives(C1,I1),
	plain_cns_widening(I1,C2,C3),
	D3=(H2,bd(C3,B2)).
*/

%
plain_cns_widening(C1,C2,C3) :-
	keep_entailed(C1,C2,E3),
	term_variables(E3,V3),
	solve(rat,E3,V3,C3).


%%% keep_entailed(C1,C2,C3)
%%% C3 is the subset of the constraints in C1 entailed by C2

keep_entailed([],_C2,[]).
%
keep_entailed(C1,C2,E) :-
	C1=[PC1|PC1s],
	(entails(rat,C2,[PC1]) ->
	    E=[PC1|E1],
	    keep_entailed(PC1s,C2,E1)
	;
	    keep_entailed(PC1s,C2,E)
	).

% ------------------------------------------------------------------------------
int_coeff_transf([],[]).
int_coeff_transf([C|Cs],[D|Ds]) :-
	transf_constraint(C,D),
	int_coeff_transf(Cs,Ds).


transf_constraint(C,D) :-
        den_list(C,Dens),
        (Dens=[] ->
          C=D
          ;
          ( lcm(Dens,M), multiply(M,C,D) )
        ).

den_list(C,Dens) :-
	C=..[_,Lhs,Rhs],
	d_list(Lhs,LDens),
	d_list(Rhs,RDens),
	append(LDens,RDens,Dens).


% P is either a variable or an integer
d_list(P,D) :-
  (var(P); integer(P)),
  !,
  D=[].
% P is of the form rat(X,Y) or rdiv(X,Y)
d_list(P,D) :-
  map_rational(P,_,Y), % P is nonvar
  !,
  ({Y=1} -> D=[] ; D=[Y] ).
%
d_list(P,D) :-
  P= -Q,
  !,
  d_list(Q,D).
% P is P1*P2, where P1 is either a constant or a variable, P2 is a variable
d_list(P,D) :-
  P=P1*P2,
  var(P2),
  !,
  d_list(P1,D).
% P is of the form P1 Op P2 with Op in {+,-}
d_list(P,D) :-
  functor(P,Op,2),
  (Op=='+';Op=='-'),
  !,
  arg(1,P,P1),
  arg(2,P,P2),
  d_list(P1,D1),
  d_list(P2,D2),
  append(D1,D2,D).
d_list(P,_) :-
  map_error((write('Unrecognized term in d_list: '), write(P))).


lcm([N],L) :- L=N.
lcm([N1,N2|Ns],L) :-
	N is ((N1*N2)/gcd(N1,N2)),
	lcm([N|Ns],L).


multiply(M,C1,C2) :-
	C1=..[R,Lhs1,Rhs1],
	multiply_aexpr(M,Lhs1,Lhs2),
	multiply_aexpr(M,Rhs1,Rhs2),
        !,
	C2=..[R,Lhs2,Rhs2].


% multiply_aexpr(+Coeff,+AExpr, -CoeffAExpr).
% Assumption: AExpr is an atomic constraint produced by solve
% constant
multiply_aexpr(Coeff,AExpr,CoeffAExpr) :-
  map_constant(AExpr),
  !,
  {CoeffAExpr1=Coeff*AExpr},
  CoeffAExpr=CoeffAExpr1.
% variable
multiply_aexpr(Coeff,AExpr,CoeffAExpr) :-
  var(AExpr),
  !,
  {Coeff1=Coeff},
  ({Coeff1=1} -> CoeffAExpr=AExpr ; CoeffAExpr=Coeff1*AExpr).
% - AExpr
multiply_aexpr(Coeff,AExpr,CoeffAExpr) :-
  AExpr= -(AExpr1),
  !,
  NegCoeff= -(Coeff),
  multiply_aexpr(NegCoeff,AExpr1,CoeffAExpr).
% AExpr1 * AExpr2
multiply_aexpr(Coeff,AExpr,CoeffAExpr) :-
  AExpr=AExpr1*AExpr2,
  !,
  multiply_aexpr(Coeff,AExpr1,CoeffAExpr1),
  ({CoeffAExpr1=1} -> CoeffAExpr=AExpr2 ; CoeffAExpr=CoeffAExpr1*AExpr2).
% AExpr1 Op AExpr2, with Op in {+,-}
multiply_aexpr(Coeff,AExpr,CoeffAExpr) :-
  functor(AExpr,Op,2),
  (Op=='+';Op=='-'),
  !,
  arg(1,AExpr,AExpr1),
  arg(2,AExpr,AExpr2),
  multiply_aexpr(Coeff,AExpr1,CoeffAExpr1),
  multiply_aexpr(Coeff,AExpr2,CoeffAExpr2),
  functor(CoeffAExpr,Op,2),
  arg(1,CoeffAExpr,CoeffAExpr1),
  arg(2,CoeffAExpr,CoeffAExpr2).


% ------------------------------------------------------------------------------

vars_pairs(Vars,VarsPairs,VarsPairs) :-
    (Vars=[]; Vars=[_]),
    !.
vars_pairs([V|Vars],Var_pairs_in,Var_pairs_out) :-
    var_pairs(V,Vars,Var_pairs_in1),
    append(Var_pairs_in,Var_pairs_in1,Var_pairs_in2),
    vars_pairs(Vars,Var_pairs_in2,Var_pairs_out).


var_pairs(_V,[],[]).
var_pairs(V1,[V2|Vars],[(V1,V2)|VarPairsOut]) :-
    var_pairs(V1,Vars,VarPairsOut).

% ------------------------------------------------------------------------------
gen_eq_vp(Cn,VarsPairs,C) :-
   % temporary
   memberchk((rat,R),Cn),
   gen_eq_vp_(R,VarsPairs,R1),
   % temporary
   constr_tt(C1),
   selectchk((rat,_),C1,Rest),
   C=[(rat,R1)|Rest].

%
gen_eq_vp_(_Cn,[],[]).
gen_eq_vp_(Cn,[(V1,V2)|VarsPairs],[Eq|Cs]) :-
    Eq=..['=',V1,V2],
    entails(rat,Cn,[Eq]),
    !,
    gen_eq_vp_(Cn,VarsPairs,Cs).
gen_eq_vp_(Cn,[_|VarsPairs],Cs) :-
    gen_eq_vp_(Cn,VarsPairs,Cs).

%
gen_edq_vp(Cn,VarsPairs,C) :-
   % temporary
   memberchk((rat,R),Cn),
   gen_edq_vp_(R,VarsPairs,R1),
   % temporary
   constr_tt(C1),
   selectchk((rat,_),C1,Rest),
   C=[(rat,R1)|Rest].


gen_edq_vp_(_Cn,[],[]).
gen_edq_vp_(Cn,[(V1,V2)|VarsPairs],[Eq|Cs]) :-
    Eq=..['=',V1,V2],
    entails(rat,Cn,[Eq]),
    !,
    gen_edq_vp_(Cn,VarsPairs,Cs).
gen_edq_vp_(Cn,[(V1,V2)|VarsPairs],[DisEq|Cs]) :-
    DisEq=..['=\\=',V1,V2],
    entails(rat,Cn,[DisEq]),
    !,
    gen_edq_vp_(Cn,VarsPairs,Cs).
gen_edq_vp_(Cn,[_|VarsPairs],Cs) :-
    gen_edq_vp_(Cn,VarsPairs,Cs).

% ------------------------------------------------------------------------------
% {==}
cns_eq(Cn,Vars,C) :-
    selectchk((rat,R),Cn,Rest),
    list_to_singletons(Vars,VarSing),
    eq_cls(R,VarSing,VarSing1), % classes of equalities
    gen_eq(VarSing1,[],Eqs),
    C=[(rat,Eqs)|Rest].

% {==,=\=}
cns_edq(Cn,Vars,C) :-
    selectchk((rat,R),Cn,Rest),
    list_to_singletons(Vars,VarSing),
    eq_cls(R,VarSing,VarSing1),
    gen_eq(VarSing1,[],Eqs),
    gen_dq(R,VarSing1,[],Dqs),
    append(Eqs,Dqs,E),
    C=[(rat,E)|Rest].

% {==,=<,>=}
cns_eq_leq_geq(Cn,Vars,C) :-
    selectchk((rat,R),Cn,Rest),
    list_to_singletons(Vars,VarSing),
    eq_cls(R,VarSing,VarSing1),
    gen_eq(VarSing1,[],Eqs),
    gen_leq_geq(R,VarSing1,[],Dqs),
    append(Eqs,Dqs,E),
    C=[(rat,E)|Rest].


% ------------------------------------------------------------------------------
eq_cls(_Cn,[],[]).
eq_cls(Cn,[E|Es],[E1|Es2]) :-
    eq_cl(Cn,E,Es,E1,Es1),
    eq_cls(Cn,Es1,Es2).


%
eq_cl(_Cn,X,[],X,[]).
eq_cl(Cn,[X|Xs],[[Y|Ys]|R],X1,R1) :-
    entails(rat,Cn,[X=Y]),
    !,
    append(Xs,[Y|Ys],Xs1),
    eq_cl(Cn,[X|Xs1],R,X1,R1).
eq_cl(Cn,X,[Y|R],X1,[Y|R1]) :-
    eq_cl(Cn,X,R,X1,R1).


%
gen_eq([],Eqs,Eqs).
gen_eq([E|R],EqsIn, EqsOut) :-
    gen_eq_(E,Eqs),
    append(EqsIn,Eqs,EqsIn1),
    gen_eq(R,EqsIn1,EqsOut).


%
gen_eq_([_],[]).
gen_eq_([X,Y|R],[X=Y|E]) :-
    gen_eq_([Y|R],E).


% ------------------------------------------------------------------------------
gen_dq(_Cn,[],Dqs,Dqs).
gen_dq(Cn,[[X|_]|R],DqsIn, DqsOut) :-
    gen_dq_(Cn,X,R,Dqs),
    append(DqsIn,Dqs,DqsIn1),
    gen_dq(Cn,R,DqsIn1,DqsOut).


%
gen_dq_(_Cn,_X,[],[]).
gen_dq_(Cn,X,[[Y|_]|R],[DisEq|E]) :-
    DisEq=..['=\\=',X,Y],
    entails(rat,Cn,[DisEq]),
    !,
    gen_dq_(Cn,X,R,E).
gen_dq_(Cn,X,[_|R],E) :-
    gen_dq_(Cn,X,R,E).


% ------------------------------------------------------------------------------
gen_leq_geq(_Cn,[],Dqs,Dqs).
gen_leq_geq(Cn,[[X|_]|R],DqsIn, DqsOut) :-
    gen_leq_geq_(Cn,X,R,Dqs),
    append(DqsIn,Dqs,DqsIn1),
    gen_leq_geq(Cn,R,DqsIn1,DqsOut).


%
gen_leq_geq_(_Cn,_X,[],[]).
gen_leq_geq_(Cn,X,[[Y|_]|R],[LEq|E]) :-
    LEq=..['=<',X,Y],
    entails(rat,Cn,[LEq]),
    !,
    gen_leq_geq_(Cn,X,R,E).
gen_leq_geq_(Cn,X,[[Y|_]|R],[LEq|E]) :-
    LEq=..['>=',X,Y],
    entails(rat,Cn,[LEq]),
    !,
    gen_leq_geq_(Cn,X,R,E).
gen_leq_geq_(Cn,X,[_|R],E) :-
    gen_leq_geq_(Cn,X,R,E).
