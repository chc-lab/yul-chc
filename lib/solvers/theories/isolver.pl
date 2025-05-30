/*
  J.-L. Imbert, Variable Elimination for Disequations in Generalized
  Linear Constraint Systems. The Computer Journal, Vol. 36, No. 5, 1993

  Tests:
  Example 4.1
  solve(rat,[X=<Y,Y=<Z,Y=\=0],[X,Z],S).
  S = [X-Z=<0,(X=\=0;Z=\=0)]
  Example 4.2
  solve(rat,[X=<Y,Y=<Z,Y=\=X+1],[X,Z],S).
  S = [X-Z=<0]
  Example 4.3
  solve(rat,[Y=<X+1,Y=<5-X,X-1=<Y,3-X=<Y,Y=\=2],[X],S).
  S = [X=<3,X>=1,X=\=1,X=\=3]
  Example 4.4
  solve(rat,[X>=0,Y>=0,Z>= -X-Y,Z=<X+Y,Z>=X-1,Z=\=0],[X,Y],S).
  S = [X>=0,Y>=0,X=\= -(Y)]
  Example 5.2
  solve(rat,[X>=0,Z>= -X-Y, Z=<X+Y,Z=\=0],[X,Y],S).
  S = [X>=0,X+Y>=0,X=\= -(Y)]
  solve(rat,[3-X=<Y,Y=\=2],[Y],S).
  S = [Y=\=2]
  solve(rat,[3-X=<Y,Y=\=2],[X,Y],S).
  S = [3-(X+Y)=<0,Y=\=2]
  solve(rat,[Z=\=2,Z=:=Y],[Z],S).
  S = [Z=\=2]
  solve(rat,[Z=\=2,Z=:=Y],[Y],S).
  S = [Y=\=2]
  solve(rat,[X=:=Y,Z=:=W,X=\=Z],[Y,W],S).
  S = [Y=\=W]
  solve(rat,[1-B=<0,-(B-D)=<0,A=\=F,A=B,P=Q-R,Q=D])],[P,F],S).
  S = []
*/


% solve(rat,[3-X=<Y,Y=\=2],[Y],S). no?

% MODE: solve(rat,+C,+V, -PC)
% TYPE: solve(rat,list(constraint),list(term),list(constraint))
% SEMANTICS: C is a Generalized Linear Constraint system consisting of:
% - a sub-system of equations E: a X = b
% - a sub-system of inequations I: a X =< b
% - a sub-system of disequations D: a_1 X_1 =\= b_1 | ... | a_n X_n =\= b_n
% and X is a set of variables.
% PC is a  Generalized Linear Constraint system equivalent to C on V
solve(rat,C,V,PC) :-
  ( satisfiable(rat,C) ->
    % C is consistent
    (
      disequations(C,D,EI),
      % D  is a set of Disequations in C
      % EI is a set of Equations and Inequations
      (D==[] ->
        % no disequations: use standard Fourier-Motzkin
        ie_solve(C,V,PC)
      ;
        (
          map_term_variables(C,V1),    % V1 = vars(C1)
          delete_chk(V,V1,V2),         % vars to be eliminated: V2 = V1-V
          e_solve(EI,D,V2,V, E1,I1,D1),% solve Equations
          id_solve(I1,D1,V,V2, I2,D2), % solve Inequations and Disequations
          disequations(D3,D2,[]),      % from [not(D1),..,not(Dn)] to [C1;..;Cn]
          append(E1,I2,IE1),           % IE2 = projected Eqs U projected Ineqs
          append(IE1,D3,PC)            % PC  = projected IE U projected Diseqs
        )
      )
    )
  ;
    % C is inconsistent
    PC=[false]
  ).


% e_solve(+EIIn,+DIn,+V1,+V2, -EOut,-IOut,-DOut)
%  EIn is a set of Equations
%  V1 is a set of variables to be eliminated
%  V2 is a set of variables w.r.t. project
%  DIn is the set of Inequations and Disequations
%  EOut is the set of equations in EIn, written as V=:=T,
%   where V is a variable not occurring in IDIn
%  DOut is the set of equations and disequation without the variables
%   to be eliminated occurring in the solved form of EIn
e_solve(EIIn,DIn,V1,V2, EOut,IOut,DOut) :-
  append(V1,V2,V3),                % V3 = [V1,V2] = [to delete,to keep]
  ie_solve(EIIn,V3,EIIn1),         % solve EI to get implicit equations
  equations(EIIn1,E1,IOut),        % split EI into Equations and Inequations
  full_dimensional(IOut),          % check if I is full dimensional
  map_term_variables(DIn,V4),
  e_solve_(E1,V1,V4,DIn, E2,DOut),
  ie_solve(E2,V2,EOut).


% e_solve_(+EIn,+V1,+V2,+DIn, -EOut,-DOut)
%  EIn is a set of Equations
%  V1 is the set of variables to be eliminated
%  V2 is the set of variables in DIn
%  DIn is the set of Disequations
%  EOut is the set of solved equations in EIn
%  DOut is the set of equations and disequation without the variables to be
%   eliminate occurring in the solved form of EIn
e_solve_(E,_V1,_V2,D, E,D) :-
  E==[],
  !.
%
e_solve_([E|EIn1],V1,V2,DIn, EOut,DOut) :-
  arg(1,E,V),              % E is of the form V=:=T, where V is a variable
  member_chk(V,V1),        % V belongs to the set of variables to be deleted
  member_chk(V,V2),        % V belongs to the set of variables in DIn
  !,
  arg(2,E,T),              % T is a term
  replace(DIn,V,T,DIn1),   % replace V with T in ID
  e_solve_(EIn1,V1,V2,DIn1, EOut,DOut).
%
e_solve_([E|EIn1],V1,V2,DIn, [E|EOut],DOut) :-
  e_solve_(EIn1,V1,V2,DIn, EOut,DOut).


% replace(+Term,+TermToBeReplaced,+Replacement, -Result)
% SEMANTICS: Result is obtained by replacing every occurrence of
% TermToBeReplaced in Term with Replacement.
% if Term is not a compound and Term equals to TermToBeReplaced,
% then unify Result=Replacement, else Result=Term
replace(Term,TermToBeReplaced,Replacement,Result) :-
  \+ compound(Term),
  !,
  (Term==TermToBeReplaced ->
    Result=Replacement
  ;
    Result=Term
  ).
% if Term is a nonempty list,
% then perform the replacement on every element in the list
replace([Arg1|Args],TermToBeReplaced,Replacement,[ReplacedArg1|ReplacedArgs]) :-
  replace(Arg1,TermToBeReplaced,Replacement,ReplacedArg1),
  !,
  replace(Args,TermToBeReplaced,Replacement,ReplacedArgs).
% if Term is a compound term different from a list,
% then replace TermToBeReplaced with Replacement in the arguments of Term
replace(Term,TermToBeReplaced,Replacement,Result) :-
  Term=.. [Functor|Args],
  replace(Args,TermToBeReplaced,Replacement,ReplacedArgs),
  Result=.. [Functor|ReplacedArgs].


% disequations(?C,?D, -EI)  % turn X=\=Y into not(X=Y)
% C is of the form not([C1,...,CN])    iff
% D is of the form neg(C1);...;neg(CN)
% where Ci, for 1<=i<=N, is an atomic constraints of the form T1=\=T2, and
% neg(Ci) is the negation of Ci
disequations([C|C1],[D|D1],EI) :-
  notAndEqs_orDiseqs(D,C),
  !,
  disequations(C1,D1,EI).
% else
disequations([C|C1],D,[C|EI]) :-
  !,
  disequations(C1,D,EI).
% if the above clause fails, then
% C is a list consisting of positive constraints only
disequations([],[],[]).


% equations(+EI1, -E,-I)
equations(EI,E,I) :-
  select(Elem,EI,C1),
  functor(Elem,=:=,2),
  !,
  E=[Elem|Es],
  equations(C1,Es,I).
equations(EI,[],I) :-
  normalize_list(EI,I).


% full_dimensional(+S)
% full_dimensional(+S) holds iff S' is satisfiable,
% where S' is S with all =< replaced with <
full_dimensional(W) :-
  wi2si(W,S),
  satisfiable(rat,S).


% MODE: wi2si(+W, -S)
% SEMANTICS: weak inequations to strict inequations
% ASSUMPTION: all weak inequations are of the form AX-B=<0
wi2si([],[]).
wi2si([W|Ws],[S|Ss]) :-
  arg(1,W,T1), arg(2,W,T2),
  functor(S,'<',2),
  arg(1,S,T1), arg(2,S,T2),
  wi2si(Ws,Ss).


% foreach x in X
id_solve(I,D,_V,[],I,D).
%
id_solve(I1,D1,V,[X0|Xs],I2,D2) :-
  append(V,Xs,V_X0), % V_X0 = vars({I1,D1}) - {X0}
  incr_solve(I1,D1,V_X0,X0,I_X0_Out,D_X0_Out),
  id_solve(I_X0_Out,D_X0_Out,V,Xs,I2,D2).


% MODE: incr_solve(+I,+D,+V_X0,+X0, -I_X0,-D_X0)
% SEMANTICS: Incremental algorithm associated with Fourier-Motzkin elimination
% I_X0,D_X0 is equivalent to I,D on Vars(I,D)-{X0}
incr_solve(I,D,V_X0,X0, CI_X0,D_X0) :-
  D_X0_In=[],                                                  % step 1 of Fig.1
  ie_solve(I,V_X0,I_X0),                                       % step 2 of Fig.1
  canonical_form(I_X0,CI_X0),
  nonzero_opposite_pairs(I,X0,NOPairs),
  ie_solvedisequations(CI_X0,D,V_X0,X0,NOPairs,D_X0_In, D_X0). % step 3 of Fig.1


% MODE: canonical_form(IE,CIE)
% SEMANTICS: CIE is the list of inequalities and equalities occurring in IE,
% where all the inequalities of the form A>=B have been transformed into
% inequalities of the form B=<A
canonical_form([],[]).
canonical_form([IE|IEs],[CIE|CIEs]) :-
  functor(IE,'>=',2),
  !,
  arg(1,IE,Lhs),
  arg(2,IE,Rhs),
  functor(CIE,'=<',2),
  arg(2,CIE,Lhs),
  arg(1,CIE,Rhs),
  canonical_form(IEs,CIEs).
canonical_form([IE|IEs],[IE|CIEs]) :-
  canonical_form(IEs,CIEs).


% MODE: ie_solvedisequations(+I,+[D|Ds],+V_X0,+X0,+NOPairs,+D_X0_In, -D_X0_Out)
% SEMANTICS: for each d in D,
% if X0 occur in d, then compute new disequations and add them to D_X0_Out
% using the NOPairs generated from the Inequations I
ie_solvedisequations(_I,[],_V_X0,_X0,_NOPairs,D_X0, D_X0).
ie_solvedisequations(I,[D|Ds],V_X0,X0,NOPairs,D_X0_In, D_X0_Out) :-
  map_term_variables(D,DVars),
  member_chk(X0,DVars),
  !,
  project_disequation(I,D,V_X0,NOPairs,D_X0_In, D_X0_In1),
  ie_solvedisequations(I,Ds,V_X0,X0,NOPairs,D_X0_In1, D_X0_Out).
% Else add d to D_X0_Out
ie_solvedisequations(I,[D|Ds],V_X0,X0,NOPairs,D_X0_In, D_X0_Out) :-
  D=not(E),
  put_into(E,I,D_X0_In, D_X0_In1),
  ie_solvedisequations(I,Ds,V_X0,X0,NOPairs,D_X0_In1, D_X0_Out).


% MODE: project_disequation(+I,+D,+V_X0,+NOPairs,+D_X0_In, -D_X0_Out)
%  I: list of Inequations
%  D: list of Disequations
%  V_X0: list of variables occurring in S without X0
%  NOPairs: list of Non-zero Opposite sign pairs (I1,I2) of Inequations
%  D_X0_In,D_X0_In1: lists of Disequations
% SEMANTICS: for each pair {I1,I2} in NOPairs, compute the disequation E
% from D, I1 and I2.
% |PInq X NInq| = 0
project_disequation(_I,_D,_V_X0,[],D_X0,D_X0).
% |PInq X NInq| > 0
project_disequation(I,D,V_X0,NOPairs,D_X0_In,D_X0_Out) :-
  NOPairs=[(I1,I2)|NOPairs1],      % (I1,I2): a non-zero and opposite sign pair
  weak_inequation2equation(I1,E1), % E1: an equation
  weak_inequation2equation(I2,E2), % E2: an equation
  D=not(E3),                       % E3: a (list) system of equations
  ie_solve([E1,E2|E3],V_X0,E),     % step 3.1 of Fig.1
  put_into(E,I,D_X0_In,D_X0_In1),  % step 3.2 of Fig.1
  project_disequation(I,D,V_X0,NOPairs1,D_X0_In1,D_X0_Out).


% MODE: nonzero_opposite_pairs(I,X0,NOPairs)
% SEMANTICS: NOPairs is the list of pairs of inequations in I with non-zero
% and opposite sign coefficients of X0.
nonzero_opposite_pairs(I,X0,NOPairs) :-
  get_positive_negative_inequations(I,X0,PInq,NInq),
  nonzero_opposite_pairs_(PInq,NInq,[], NOPairs).


% MODE: nonzero_opposite_pairs_(+PInq,+NInq,+PIn, -Pout)
% SEMANTICS: nonzero_opposite_pairs/3 utility predicate
% SEMANTICS: % Pout is { (I1,I2) | I1 in PInq, I2 in NInq }
nonzero_opposite_pairs_([],_NInq,P, P).
%
nonzero_opposite_pairs_(PInq,NInq,PIn, Pout) :-
  PInq=[I1|PInq1],
  nonzero_opposite_pairs_(I1,NInq,P),
  append(PIn,P,PIn1),
  nonzero_opposite_pairs_(PInq1,NInq,PIn1, Pout).


% MODE: nonzero_opposite_pairs_(+I1,+NInq, -Pairs)
% SEMANTICS: nonzero_opposite_pairs_/4 utility predicate
% Pairs is { (I1,I) | I in NInq }
nonzero_opposite_pairs_(_I1,[],[]).
%
nonzero_opposite_pairs_(I1,[I2|T],[(I1,I2)|P]) :-
  nonzero_opposite_pairs_(I1,T,P).


% MODE: weak_inequation2equation(+T, -E)
% SEMANTICS: E is of the form T1=T2 if T is a term of the form T1=<T2
weak_inequation2equation(T,E) :-
  functor(T,'=<',2),
  arg(1,T,A), arg(2,T,B),
  functor(E,'=:=',2),
  arg(1,E,A), arg(2,E,B).


% MODE: notAndEqs_orDiseqs(+E, -D)
notAndEqs_orDiseqs(not([E]),D) :-
  functor(E,=:=,2), functor(D,=\=,2),
  !,
  arg(1,E,A), arg(1,D,A),
  arg(2,E,B), arg(2,D,B).
notAndEqs_orDiseqs(not([E|Eqs]),D) :-
  functor(D,';',2),
  arg(1,D,D1),
  arg(2,D,D2),
  notAndEqs_orDiseqs(not([E]),D1),
  notAndEqs_orDiseqs(not(Eqs),D2).


% MODE: put_into(+E,+I,+D_X0_In, -D_X0_In)
%
put_into(E,_I,D_X0, D_X0) :-
  E==[false],
  !.
%
put_into(E,I,D_X0_In, D_X0_Out) :-
  append(E,I,C),
  notAndEqs_orDiseqs(not(E),DisjE),
  ((% check if not(E) is relevant, i.e., I,E is satisfiable
    satisfiable(rat,C),
    % check if D_X0_In1 |=/= D
    \+ entails(rat,D_X0_In,DisjE)
   ) ->
   % if not(E) is relevant and D_X0_In1 |=/= D, then
    ( % 1. put not(E) into D_X0_In
      D_X0_In1=[not(E)|D_X0_In],
      % 2. remove redundant disequations
      remove_redundant(D_X0_In1,D_X0_Out)
    )
  ; % else
    D_X0_In=D_X0_Out
  ).


remove_redundant([],[]).
remove_redundant([Disj|D_X0],DOut) :-
  entails(rat,D_X0,Disj),
  !,
  remove_redundant(D_X0,DOut).
remove_redundant([D|DIn],[D|DOut]) :-
  remove_redundant(DIn,DOut).


% ------------------------------------------------------------------------------

get_positive_negative_inequations([],_V,[],[]).
get_positive_negative_inequations([I|Is],V,Pos,Neg) :-
  arg(1,I,E), % I =.. ['=<',E,0],
  expr_coeff2(E,V,L),
  ( get_coeff(V,L,C) ->
    ( negative(C) ->
      (
       Neg=[I|Neg1],
       get_positive_negative_inequations(Is,V,Pos,Neg1)
      )
    ;
      (
       Pos=[I|Pos1],
       get_positive_negative_inequations(Is,V,Pos1,Neg)
      )
    )
  ;
    get_positive_negative_inequations(Is,V,Pos,Neg)
  ).


% MODE: expr_coeff2(+E,+V,-C)
% TYPE: expr_coeff2(clpqexpr, var, list(rat))
% SEMANTICS: E is an expression of the form [A1*]X1 +/- ... +/- [An*]Xn [+/- A0],
% where Ai's are rationals, V is Xi for some i, and C is [(Xi,Ai)]
%
expr_coeff2(E,V,L) :-
  var(E),
  !,
  (E==V -> L=[(E,1)] ; L=[]).
%
expr_coeff2(E,_V,L) :-
  map_rational(E),
  !,
  L=[].
%
expr_coeff2(E,V,L) :-
  functor(E,F,1),
  (F='+';F='-'),
  !,
  arg(1,E,Arg),
  expr_coeff2(Arg,V,AL),
  (F='-' ->
    opposite_list(AL,L)
  ;
    L=AL
  ).
%
expr_coeff2(E,V,L) :-
  functor(E,F,2), (F='+';F='-'), !,
  arg(1,E,LHS), arg(2,E,RHS),
  expr_coeff2(LHS,V,LL),
  (LL==[] ->
    ( expr_coeff2(RHS,V,RL),
      (F='-' ->
        opposite_list(RL,ORL)
      ;
        RL=ORL
      ),
      append(LL,ORL,L)
    )
  ;
    L=LL
  ).
%
expr_coeff2(E,V,L) :-
  functor(E,'*',2),
  arg(1,E,LHS), arg(2,E,RHS),
  (V==RHS ->
    L=[(RHS,LHS)]
  ;
    (V==LHS ->
      L=[(LHS,RHS)]
    ;
      L=[]
    )
  ).


%
opposite_list([],[]).
opposite_list([(A,X)|Xs],[(A,Y)|Ys]) :-
  (functor(X,'-',1) ->
    arg(1,X,Y)
  ;
    Y=..['-',X]
  ),
  opposite_list(Xs,Ys).


%
get_coeff(Var,L,C) :-
  member((V1,C1), L),
  Var==V1,
  !,
  C=C1.


%
negative(C) :-
  functor(C,'-',1).


%
positive(C) :-
  \+ negative(C).
