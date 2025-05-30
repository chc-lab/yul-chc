:- use_module(library(lists),
    [ append/3
    , member/2
    , select/3
    , flatten/2
    , list_to_set/2
    , nth0/3
    , nth0/4
    , nth1/3
    , nth1/4
    , prefix/2
    , permutation/2
    , reverse/2 ]).
:- use_module(library(terms),
    [ variant/2 ]).
:- use_module(library(dialect/hprolog),
    [ memberchk_eq/2 ]).
:- use_module(library(dialect/sicstus/lists),
    [ sublist/2
    , substitute/4 ]).
:- use_module(library(varnumbers),
    [ numbervars/1
    , varnumbers/2 ]).
:- use_module(library(occurs),
    [ contains_var/2 ]).

% ------------------------------------------------------------------------------
%
map_term_variables(Term,Vars) :-
  term_variables(Term,Vars).

% ------------------------------------------------------------------------------
% MODE: map_deep_copy_term_list(Term,Copy)
% TYPE: map_deep_copy_term_list(term,term)
% SEMANTICS: see map_deep_copy_term - use this version
% instead of map_deep_copy_term to deal with huge lists
map_deep_copy_term_list([],[]).
map_deep_copy_term_list([A|T],[B|T1]) :-
  map_deep_copy_term(A,B),
  map_deep_copy_term_list(T,T1).


% MODE: map_deep_copy_term(Term,Copy)
% TYPE: map_deep_copy_term(term,term)
% SEMANTICS: creates a term Copy as a copy of Term without any attributes
:- multifile map_deep_copy_term/2.
:- dynamic   map_deep_copy_term/2.
map_deep_copy_term(T,T1) :- copy_term(T,T1).

map_deep_copy_term_(Term,[],Term1,_) :- copy_term(Term,Term1,_).


% ------------------------------------------------------------------------------
%
map_nth0(N,List,Elem) :-
  nth0(N,List,Elem).
%
map_nth0(N,List,Elem,Rest) :-
  nth0(N,List,Elem,Rest).


%
map_nth1(N,List,Elem) :-
  nth1(N,List,Elem).
%
map_nth1(N,List,Elem,Rest) :-
  nth1(N,List,Elem,Rest).

% ------------------------------------------------------------------------------
%
map_remove_duplicates(VC,VC1) :-
  list_to_set(VC,VC1).

% ------------------------------------------------------------------------------
% member_chk(+X,+Ys) :- there is a member Y of the list of terms Ys
% (possibly with variables) such that X==Y. No variable is bound.
% NOTE: Not to be confused with memberchk/2
member_chk(X,L) :- memberchk_eq(X,L).

% ------------------------------------------------------------------------------
%
select_chk(X,[Y|L],L) :-
  X == Y.
select_chk(X,[Y|L],[Y|M]) :-
  select_chk(X,L,M).

% ------------------------------------------------------------------------------

% map_rational(+Term, -Numerator, -Denominator)
% Term is a rational number with given Numerator and Denominator.
map_rational(Rational,Numerator,Denominator) :-
  rational(Rational,Numerator,Denominator).


% map_rational(+Term)
% Term is a rational number.
map_rational(Rational) :-
  rational(Rational).

% ------------------------------------------------------------------------------
%
map_getenv(A,B) :-
  getenv(A,B).

% ------------------------------------------------------------------------------
%
is_set_env(VarName) :- map_getenv(VarName,_).

% ------------------------------------------------------------------------------
% --- Operations on clauses, clause selection 2, goals, atoms, literals, terms

% --- clause -------------------------------------------------------------------
%
clause_components(Cl,H,C,L) :-
  Cl=(H,bd(C,L)).

%
clause_hd(Cl,H) :-
	Cl=(H,_).

%
clause_bd(Cl,B) :-
	Cl=(_,B).

%
clause_bd_cns(Cl,Cns) :-
	Cl=(_,bd(Cns,_)).

%
clause_bd_goal(Cl,G) :-
	Cl=(_,bd(_,G)).

%
cfact(Cl) :-
  clause_bd_goal(Cl,[]).

%
linear_cl(Cl) :-
  clause_bd_goal(Cl,[_]),
  !.
linear_cl(Cl) :-
  clause_bd_goal(Cl,[]).

%
nonlinear_cl(Cl) :-
  clause_bd_goal(Cl,[_,_|_]).

%
copy_cl(Cl,CpyCl) :-
  clause_components(Cl, H,C,B),
  constr_vars(C,Vars),
  % make a copy the head and the atoms in the body of the clause
  copy_term((H,B,Vars),(CpyH,CpyB,CpyVars)),
  % make a copy of the constraint
  constr_copy(C,CpyC),
  % unify the list of variables of C and its copy
  constr_vars(CpyC,CpyVars),
  clause_components(CpyCl, CpyH,CpyC,CpyB).

%
cls_to_hdbdpair([],[]).
cls_to_hdbdpair([Cl|Cls],[HdBdPair|HdBdPairs]) :-
  clause_components(Cl, H,C,G),
  constr(T,C,[]),
  append(T,G,L),
  (L==[] -> B=true ; list_to_conj(L,B)),
  HdBdPair = (H,B),
  cls_to_hdbdpair(Cls,HdBdPairs).

% --- clause selection 2  ------------------------------------------------------
%
clsel2_components((H,bd(Cns,Lhs,Rhs)),H,Cns,Lhs,Rhs).

%
clsel2_hd(ClSel2,H) :-
  clsel2_components(ClSel2,H,_,_,_).

%
clsel2_bd(Cl,B) :-
	Cl=(_,B).

%
clsel2_bd_cns(ClSel2,Cns) :-
	clsel2_components(ClSel2,_,Cns,_,_).

%
clsel2_bd_goal(ClSel2,G1,G2) :-
	clsel2_components(ClSel2,_,_,G1,G2).

%
clsel2_bd_1st_goal(ClSel2,G1) :-
	clsel2_components(ClSel2,_,_,G1,_).
clsel2_bd_2nd_goal(ClSel2,G2) :-
	clsel2_components(ClSel2,_,_,_,G2).

%
clsel2_hd_pred(Cl,P/N)  :-
	Cl=(H,_),
	functor(H,P,N).

%
copy_clsel2(Cl,CpyCl) :-
  clsel2_components(Cl,H,C,B1,B2),
  constr_vars(C,Vars),
  copy_term((H,Vars,B1,B2),(CpyH,CpyVars,CpyB1,CpyB2)),
  constr_copy(C,CpyC),
  constr_vars(CpyC,CpyVars),
  clsel2_components(CpyCl,CpyH,CpyC,CpyB1,CpyB2).

% --- atoms, literals, terms ---------------------------------------------------
hd_pred(Cl,P/N) :-
	Cl=(H,_),
	functor(H,P,N).

%
hd_args(Cl,Args) :-
	Cl=(H,_),
	H=..[_|Args].

%
bd_goal_preds(Cl,Preds) :-
  clsel2_bd(Cl,Gl),
  goal_preds(Gl,Preds).

%
atom(L,A) :-
	L=(\+ A1) -> A=A1 ; A=L.

%
atom_pred(A,P/N) :-
	functor(A,P,N).

%
literal_pred(L,P/N) :-
	atom(L,A),
	functor(A,P,N).

%
goal_preds(Goal,Preds) :-
  findall(Pred/Arity,
    ( member(Atom,Goal), functor(Atom,Pred,Arity) ), Preds).

%
pred_list_args([],Args,Args).
%
pred_list_args([H|T],ArgsIn,ArgsOut) :-
  H=..[_|Args],
  append(ArgsIn,Args,ArgsIn1),
  pred_list_args(T,ArgsIn1,ArgsOut).


% Change body representation
split_bd(Lits,bd(Cns,RestLits)) :-
  constr(Lits,Cns,RestLits).

%
negative_literal(L) :-
  L=(\+ _).

%
positive_literal(L) :-
  \+ negative_literal(L).

%
inprog_pred(Pred) :-
  cc_inprog:cc(Pred,_Cl).

%
inprog_clause(Pred, Cl) :-
  cc_inprog:cc(Pred,Cl).

%
inprog_clauses(Pred, Cls) :-
  findall(Cl, cc_inprog:cc(Pred,Cl), Cls).

%
linking_vars((H,B),LinkingVars) :-
  map_term_variables(H,VH),
  map_term_variables(B,VB),
  intersection_vars(VB,VH,LinkingVars).
%
linking_vars(T1,T2,LinkingVars) :-
  map_term_variables(T1,VT1),
  map_term_variables(T2,VT2),
  intersection_vars(VT2,VT1,LinkingVars).


% From library(anti_unify):
% Anti-unification is the mathematical dual of unification: given two terms T1
% and T2 it returns the most specific term which generalises them, T.
% T is the most specific term which unifies with both T1 and T2.
% A common use for this is in learning; the idea of using it that way comes from
% Gordon Plotkin. The code here is based on a routine called 'generalize/5'
% written by Fernando Pereira. The name was changed because there are other
% ways of generalising things, but there is nly one dual of unification.

% anti_unify(+Term1, +Term2, -Term)
% binds Term to a most specific generalisation of Term1 and Term2.
% When you call it, Term should be a variable.
% TODO: replace the following implementation with a call to:
% SWI:   http://www.swi-prolog.org/pldoc/doc_for?object=term_subsumer/3
% SICS:  https://sicstus.sics.se/sicstus/docs/3.12.5/html/sicstus/Term-Utilities.html#Term%20Utilities
anti_unify(Term1, Term2, Term) :- anti_unify(Term1, Term2, _, _, Term).

% anti_unify(+Term1, +Term2, -Subst1, -Subst2, -Term)
% binds Term to a most specific generalisation of Term1 and Term2,
% and Subst1 and Subst2 to substitutions such that
%  Subst1(Term) = Term1
%  Subst2(Term) = Term2
% Substitutions are represented as lists of Var=Term pairs, where
% Var is a Prolog variable, and Term is the term to substitute for Var.
% When you call it, Subst1, Subst2, and Term should be variables.
% TODO: see https://quintus.sics.se/isl/quintus/html/quintus/lib-abs.html
anti_unify(Term1, Term2, Phi1, Phi2, Term) :-
	anti_unify(Term1, Term2, [], [], Phi1, Phi2, Term).
anti_unify(Term1, Term2, Phi1, Phi2, Theta1, Theta2, Term) :-
  (nonvar(Term1), nonvar(Term2), functor(Term1, F, N), functor(Term2, F, N) ->
    functor(Term, F, N), anti_unify(N, Term1, Term2, Phi1, Phi2, Theta1, Theta2, Term)
  ; Term1 == Term2 -> Theta1 = Phi1, Theta2 = Phi2, Term = Term1
  ; already_covered(Phi1, Phi2, Term1, Term2, V) -> Theta1 = Phi1, Theta2 = Phi2, Term = V
  ;   /* Not same functor, not identical, not covered by an existing V */
  Theta1 = [V = Term1|Phi1], Theta2 = [V = Term2|Phi2], Term = V ).

anti_unify(0, _, _, SS, ST, SS, ST, _) :- !.
anti_unify(N, S, T, SS0, ST0, SS, ST, U) :-
  arg(N, S, Sn), arg(N, T, Tn), arg(N, U, Un),
  anti_unify(Sn, Tn, SS0, ST0, SS1, ST1, Un),
  M is N-1,
  anti_unify(M, S, T, SS1, ST1, SS, ST, U).

already_covered([V=S0|_], [V=T0|_], S, T, V) :-
  S0 == S, T0 == T, !.
already_covered([_|Phi1], [_|Phi2], S, T, V) :-
  already_covered(Phi1, Phi2, S, T, V).

% anti_unify_vars/3
% MODE: anti_unify_vars(+T1, -T2,-U).
% T2 is a generalization of T1 with all distinct variables,
% T1 can be made equivalent to T2 by calling U
anti_unify_vars(T1, T2,U) :-
  anti_unify_vars_auc(rep_member,T1,[],[], T2,_V,U).

% MODE: anti_unify_vars_auc(+AuC,+T1,+V1,-U1, -T2,-V2,-U2).
% T1 is a variable: keep/replace acconding to Auc
anti_unify_vars_auc(AuC,T1,V1,U1, T2,V2,U2) :-
  var(T1),
  !,
  anti_unify_var_auc(AuC,T1,V1,U1, T2,V2,U2).
% T1 is a ground term (e.g., a number)
anti_unify_vars_auc(_AuC,T1,V1,U1, T2,V2,U2) :-
  ground(T1),
  !,
  T1=T2, V1=V2, U1=U2.
% T1 is an empty list
anti_unify_vars_auc(_AuC,T1,V1,U1, T2,V2,U2) :-
  T1 == [],
  !,
  T1=T2, V1=V2, U1=U2.
% T1 is a nonempty list
anti_unify_vars_auc(AuC,T1,V1,U1, T2,V3,U3) :-
  T1=[H1|L1],
  !,
  anti_unify_vars_auc(AuC,H1,V1,U1, H2,V2,U2),
  anti_unify_vars_auc(AuC,L1,V2,U2, L2,V3,U3),
  T2=[H2|L2].
% T1 is a compound term (different from list)
anti_unify_vars_auc(AuC,T1,V1,U1, T2,V2,U2) :-
  T1=..[F|A1],
  anti_unify_vars_auc(AuC,A1,V1,U1, A2,V2,U2),
  T2=..[F|A2].

%
anti_unify_var_auc(rep_member,T1,V1,U1, T2,V2,U2) :-
  ( member_chk(T1,V1) ->
   % replace T1 with a fresh new variable
   (T2=_V, U2=[T1=T2|U1], V1=V2 )
  ;
   % keep variable T1
   (T2=T1, U2=U1, V2=[T1|V1] )
  ).
anti_unify_var_auc(keep_select,T1,V1,U1, T2,V2,U2) :-
  ( select_chk(T1,V1,R1) ->
   % keep variable T1
   (T2=T1, U2=U1, V2=R1 )
  ;
   % replace T1 with a fresh new variable
   (T2=_V, U2=[T1=T2|U1], V1=V2 )
  ).

% anti_unify_vars/4
% MODE: anti_unify_vars(+T1,+S, -T2,-U).
% T2 is a generalization of T1 in which all variables not in S are distinct,
% T1 can be made equivalent to T2 by calling U
anti_unify_vars(T1,S, T2,U) :-
  anti_unify_vars(T1,[],[],S, T2,_V,U).

% anti_unify_vars/5
% MODE: anti_unify_vars(+T1,+V1,+S, -T2,-U).
% T2 is a generalization of T1 in which all variables not in S are distinct,
% T1 can be made equivalent to T2 by calling U
anti_unify_vars(T1,V1,S, T2,U) :-
  anti_unify_vars(T1,V1,[],S, T2,_V,U).

% anti_unify_vars/7
% MODE: anti_unify_vars(+T1,+V1,+U1,+S, -T2,-V2,-U2).
% T1 is a variable: if T1 occurs in S, do nothing;
anti_unify_vars(T1,V1,U1,S, T2,V2,U2) :-
  var(T1),
  member_chk(T1,S),
  !,
  T2=T1, U2=U1, V2=V1.
% else replaces T1 with a fresh new variable _V
anti_unify_vars(T1,V1,U1,_S, T2,V2,U2) :-
  var(T1),
  !,
  ( member_chk(T1,V1) ->
   % replace T1 with a fresh new variable
   ( T2=_V, U2=[T1=T2|U1], V1=V2 )
  ;
   % keep variable T1
   ( T2=T1, U2=U1, V2=[T1|V1] )
  ).
% T1 is ground or an empty list
anti_unify_vars(T1,V1,U1,_S, T2,V2,U2) :-
  ground(T1),
  !,
  T1=T2, V1=V2, U1=U2.
% T1 is a nonempty list
anti_unify_vars(T1,V1,U1,S, T2,V3,U3) :-
  T1=[H1|L1],
  !,
  anti_unify_vars(H1,V1,U1,S, H2,V2,U2),
  anti_unify_vars(L1,V2,U2,S, L2,V3,U3),
  T2=[H2|L2].
% T1 is a compound term (different from list)
anti_unify_vars(T1,V1,U1,S, T2,V2,U2) :-
  T1=..[F|A1],
  anti_unify_vars(A1,V1,U1,S, A2,V2,U2),
  T2=..[F|A2].


% MODE: select_heads(+LL, -L)
% TYPE: select_heads(list(list(any)),list(any))
% SEMANTICS: L is the list obtained from the list LL of lists
% by taking all first elements of the elements of LL

select_heads([],[]).
select_heads([[H|_]|Ls],[H|T]) :- select_heads(Ls,T).


%
map_constant(C) :-
  ground(C),
  (integer(C); map_rational(C)).


% SEMANTICS: Cls is the list of clauses occurring in Prog
prog_cls(Prog,Cls) :-
  nonvar(Prog), var(Cls),
  !,
  findall(PCls,(member((_Pred,PCls),Prog)),LCls),
  flatten(LCls,Cls).
%
prog_cls(Prog,Cls) :-
  var(Prog), nonvar(Cls),
  !,
  preds_in_cls(Cls,[],Preds),
  cls_to_defs(Preds,Cls,Prog).
%
prog_cls(_Prog,_Cls) :-
  throw('prog_cls/2: instantiation error.').


% MODE: linear_cls(+Cls)
% SEMANTICS: linear_cls holds iff Cls is a list of linear clauses

linear_cls([]).
linear_cls([Cl|Cls]) :-
  linear_cl(Cl),
  linear_cls(Cls).


% MODE: nofacts(+Cls)
% SEMANTICS: nofacts holds iff Cls is a list of clauses with no facts

no_facts([]).
no_facts([Cl|Cls]) :-
  \+ cfact(Cl),
  no_facts(Cls).


% MODE: subset_chk(?Ts1,?Ts2)
% TYPE: subset_chk(list(term),list(term))
% SEMANTICS: each term in Ts1 occurs in Ts2

subset_chk([],_).
subset_chk([T1|Ts1],Ts2) :-
  member_chk(T1,Ts2),
  subset_chk(Ts1,Ts2).


% MODE: subsumes_chk_conj(+T1,+T2)
% TYPE: subsumes_chk_conj(list(term),list(term))
% SEMANTICS: list T1 subsumes list T2, that is, there exists a sublist T3
% consisting of elements in T2 which is subsumed by T1.

subsumes_chk_conj(A,B) :-
  subsumes_list(A,B,SL,_),
  subsumes_chk(A,SL).


% MODE: subsumes_chk_conj(+T1,+T2, -T3,-T4)
% TYPE: subsumes_chk_conj(list(term),list(term),list(term),list(term))
% SEMANTICS: T1 and T2 are two list of atoms which encode conjunction of atoms
% T1 subsumes T2, i.e., there exists a sublist T3 consisting of elements
% in T2 which is subsumed by T1, T4 is the list of elements T2\T3.
% It does not unify T1 with T3.

subsumes_chk_conj(A,B,SL,RL) :-
  subsumes_list(A,B,SL,RL),
  subsumes_chk(A,SL).


% MODE: subsumes_list(+T1,+T2, -T3,-T4)
% TYPE: subsumes_list(list(term),list(term),list(term),list(term))
% SEMANTICS: T3 is a list consisting of elements in T2 each of which
% is subsumed by an element in T1. T4 is T2\T3.

subsumes_list([],B,[],B).
subsumes_list([G|T],B,SL,RL) :-
  select_subsumed(G,B,S,R),
  subsumes_list(T,R,SL1,RL),
  SL=[S|SL1].

% MODE: subsumes_conj_bucket(+T1,+T2, -T3,-T4)
% TYPE: subsumes_conj_bucket(list(term),list(buckets),term,term)
% SEMANTICS: T1 and T2 are two list of atoms which encode conjunction of atoms
% T1 subsumes T2, i.e., there exists a sublist T3 consisting of elements
% in T2 which is subsumed by T1, T4 is the list of elements T2\T3.
% It does not unify T1 with T3.

subsumes_chk_conj_bucket(A,B,SL,RL) :-
  subsumes_bucket(A,B,SL,RL),
  subsumes_chk(A,SL).

%
subsumes_chk_conj_bucket_pos(A,B,SL,RL1,P) :-
  buckets_to_posbuckets(B,BP),
  subsumes_bucket_pos(A,BP,SL,RL,P),
  posbuckets_to_buckets(RL,RL1),
  subsumes_chk(A,SL).

%
buckets_to_posbuckets([],[]).
buckets_to_posbuckets([(P/N,L)|T],[(P/N,PL)|T1]) :-
  list_to_poslist(L,PL,1),
  buckets_to_posbuckets(T,T1).

%
posbuckets_to_buckets([],[]).
posbuckets_to_buckets([(P/N,PL)|T],[(P/N,L)|T1]) :-
  poslist_to_list(PL,L),
  posbuckets_to_buckets(T,T1).

%
list_to_poslist([],[],_).
list_to_poslist([H|T],[(N,H)|T1],N) :-
  M is N + 1,
  list_to_poslist(T,T1,M).

%
poslist_to_list([],[]).
poslist_to_list([(_,E)|T],[E|T1]) :-
  poslist_to_list(T,T1).

%
subsumes_bucket([],B,[],B).
subsumes_bucket([G|T],B,SL,RL) :-
  functor(G,F,N),
  select((F/N,L),B,B1),
  select_subsumed(G,L,S,R),
  subsumes_bucket(T,[(F/N,R)|B1],SL1,RL),
  SL=[S|SL1].

%
subsumes_bucket_pos([],B,[],B,[]).
subsumes_bucket_pos([G|T],B,SL,RL,[P|PLst]) :-
  functor(G,F,N),
  select((F/N,L),B,B1),
  select_subsumed_pos(G,L,S,R,P),
  subsumes_bucket_pos(T,[(F/N,R)|B1],SL1,RL,PLst),
  SL=[S|SL1].

%
select_subsumed(G,[S|T],S,T) :-
  subsumes_chk(G,S).
select_subsumed(G,[H|T],S,[H|T1]) :-
  select_subsumed(G,T,S,T1).

%
select_subsumed_pos(G,[(P,S)|T],S,T,P) :-
  subsumes_chk(G,S).
select_subsumed_pos(G,[H|T],S,[H|T1],P) :-
  select_subsumed_pos(G,T,S,T1,P).


% MODE: permutation_functor(+T1,+T2, -T3)
% SEMANTICS: T3 is a permutation of T1 sorted by functors occurring in T2.
permutation_functor([],[],[]).
permutation_functor(As,[B|Bs], [A|P1]) :-
  functor(B,P,N), functor(A,P,N),
  select(A,As,As1),
  permutation_functor(As1,Bs, P1).


% MODE: permutation_variant(+L1,+L2, -L3)
% SEMANTICS: L3 is a permutation of L1 which is a variant of L2
% length 1
permutation_variant(L1,L2, L1) :-
  L1 = [_], L2 = [_],
  !,
  L1 =@= L2.
% length 2
permutation_variant(L1,L2, L1) :-
  L1 = [_,_],
  L2 = [_,_],
  L1 =@= L2.
permutation_variant(L1,L2, P1) :-
  L1 = [X,Y],
  P1 = [Y,X],
  !,
  P1 =@= L2.
% length >= 3
permutation_variant(L1,L2, P1) :-
  L1 = [_,_,_|T1],
  L2 = [_,_,_|T2],
  !,
  length(T1,N), length(T2,N),
  permutation_functor(L1,L2, P1), % P1 is a permutation of L1
  P1 =@= L2.                      % P1 is a variant of L2


% MODE: permutation_subsumes_term(+L1,+L2, -L3)
% SEMANTICS: L3 is a permutation of L1 which subsumes L2
% length 1
permutation_subsumes_term(L1,L2, L1) :-
  L1 = [_], L2 = [_],
  !,
  subsumes_term(L1,L2).
% length 2
permutation_subsumes_term(L1,L2, L1) :-
  L1 = [_,_],
  L2 = [_,_],
  subsumes_term(L1,L2).
permutation_subsumes_term(L1,L2, P1) :-
  L1 = [X,Y],
  P1 = [Y,X],
  !,
  subsumes_term(P1,L2).
% length >= 3
permutation_subsumes_term(L1,L2, P1) :-
  L1 = [_,_,_|T1],
  L2 = [_,_,_|T2],
  !,
  length(T1,N), length(T2,N),
  permutation_functor(L1,L2, P1), % P1 is a permutation of L1
  subsumes_term(P1,L2).           % P1 subsumes L2


% MODE: k_permutation_functor(+L1,+L2, -P1,-R1,-P2,-R2)
% SEMANTICS: P1 is a k-permutation of L1 and P2 is a k-permutations of L2,
% the lists P1 and P2 share the same list of functors. R1 (R2) is the list
% of elements occurring in L1 (L2) and not occurring in P1 (P2).
k_permutation_functor([A|As1],Bs, [A|As2],R1,[B|Bs2],R2) :-
  functor(A,P,N), functor(B,P,N),
  select(B,Bs,Bs1),
  k_permutation_functor(As1,Bs1, As2,R1,Bs2,R2).
k_permutation_functor([A|As1],Bs, As2,[A|R1],Bs2,R2) :-
  k_permutation_functor(As1,Bs, As2,R1,Bs2,R2).
k_permutation_functor(As,Bs, [],As,[],Bs).


% MODE: k_permutation_variant(+L1,+L2, -L3)
% SEMANTICS: L3 is a k-permutation of L1 which is a variant of L2
% and R1 is the list of elements in L1 not occurring in P1.
k_permutation_variant(L1,L2, P1,R1,P2,R2) :-
  k_permutation_functor(L1,L2, P1,R1,P2,R2),
  variant(P1,P2).


% MODE: list_to_conj(+Lst, -Conj)
% TYPE: list_to_conj(list(term), (term1,...,termN))
% SEMANTICS: generate the conjuntion (term1,...,termN)
% from the list of terms [term1,...,termN]

list_to_conj([H], H) :- !.
list_to_conj([H | T], ','(H, Conj)) :-
  list_to_conj(T, Conj).


two_lists_in_one([],[],[]).
two_lists_in_one([V|Vs],[T|Ts],[pair(V,T)|Pairs]) :-
  two_lists_in_one(Vs,Ts,Pairs).

% ------------------------------------------------------------------------------
% map_union(+Lst1,+Lst2, -Union)
% Union is the list representing the set of elements in Lst1 and Lst2
map_union(Lst1,Lst2, Union) :-
  append(Lst1,Lst2, Lst3),
  sieve_multiple_occurrences(Lst3, Union).
%
sieve_multiple_occurrences([], []).
sieve_multiple_occurrences([E|Lst], Union) :-
  select_chk(E,Lst,Lst1),
  !,
  sieve_multiple_occurrences([E|Lst1], Union).
sieve_multiple_occurrences([E|Lst], [E|Union]) :-
  sieve_multiple_occurrences(Lst, Union).


%
unfold_constants(B1,B2) :-
  select_relop(B1,C0,R0),
  map_remove_duplicates(C0,C1),
  map_term_variables(C1,V1),
  copy_term(V1-C1,CpyV1-CpyC1),
  select_varconst(CpyC1,CpyV1,C2,V2),
  V1 = V2,
  unfold_constants_fix(C2,C3),
  append(C3,R0,B2).

%
select_relop([],[],[]).
select_relop([C|C1],[C|C2],R) :-
  functor(C,F,_), memberchk(F,['>','<','>=','=<','=','=:=']),
  !,
  select_relop(C1,C2,R).
select_relop([C|C1],C2,[C|R]) :-
  select_relop(C1,C2,R).

%
select_varconst([], VIn,[],VIn).
select_varconst([E1|Cs1], VIn,[E2|Cs2],VOut) :-
  E1 =.. [F,A1,A2], ( F == '=' ; F == '=:=' ),
	var_const(A1,A2, V1,C1),
	!,
  E2 =.. [F,V2,C1], % replace V1 by a fresh new variable V2
  substitute(V1,VIn,V2,VIn1), % replace V1 by V2 from the set of variables
  V1 = C1,          % remove V1 = C1 (by apply unification)
  select_varconst(Cs1, VIn1,Cs2,VOut).
select_varconst([C|Cs1], VIn,[C|Cs2],VOut) :-
	select_varconst(Cs1, VIn,Cs2,VOut).

%
var_const(A,B, A,B) :-
  var(A), number(B).
var_const(A,B, B,A) :-
  number(A), var(B).

%
unfold_constants_fix([],[]).
unfold_constants_fix([E1|Ts],[E2|Vs]) :-
  E1 =.. [F,T1,T2], memberchk(F,['>','<','>=','=<','=','=:=']),
  simplify_ground(T1,S1), % remove terms of the form 1+2, 1*3, etc.
  simplify_ground(T2,S2),
  !,
  E2 =.. [F,S1,S2],
  unfold_constants_fix(Ts,Vs).
unfold_constants_fix([T|Ts],[T|Vs]) :-
  unfold_constants_fix(Ts,Vs).

%
simplify_ground(A,B) :-
  ground(A), compound(A), !, B is A.
simplify_ground(A,A).

%
unify_eqs_not_const([],[],[]).
unify_eqs_not_const([V|Vs],[C|Cs],[V=C|E]) :-
	ground(C),
	unify_eqs_not_const(Vs,Cs,E).
unify_eqs_not_const([V|Vs],[C|Cs],E) :-
	V=C,
	unify_eqs_not_const(Vs,Cs,E).

%
distinct_vars([]).
distinct_vars([V|Vs]) :- var(V), \+ member_chk(V,Vs), distinct_vars(Vs).


% commonvars(E1,E2,CVars) :- CVars is the set of variables
% occurring both in E1 and in E2

commonvars(E1,E2,CVars) :-
  map_term_variables(E1,V1),
  map_term_variables(E2,V2),
  setof(X,( member(X,V1), member_chk(X,V2) ), LV) -> CVars=LV ; CVars=[].


% vars_subset(T1,T2): each variable occurring in the term T1 occurs also in the term T2.
vars_subset(T1,T2) :-
  free_variables(T2,[],[],V1),
  free_variables(T1,V1,[],[]).

intersection_vars_non_empty(L1,L2) :- intersection_vars(L1,L2,L3), L3=[_|_].

intersection_vars_empty(L1,L2) :- intersection_vars(L1,L2,L3), L3==[].

%
intersection_vars([],_,[]).
intersection_vars([E|L],L2,[E|L3]) :-
  belongs(E,L2),
  !,
  intersection_vars(L,L2,L3).
intersection_vars([_|L],L2,L3) :-
  intersection_vars(L,L2,L3).


% belongs(E,L): E is an element of list L.
belongs(X,L) :- member_chk(X,L).


% conj_to_list(S,L): S a conjunction of the form (A1,...,An), and L is the list [A1,...,An].
conj_to_list(X,[]) :-
  X==true,
  !.
conj_to_list(B,L) :-
  ( nonvar(B), functor(B,',',_) ->
    ( B = (B1,B2), L=[B1|H], conj_to_list(B2,H) )
  ;
    L=[B]
  ).


delete_3([],L,L).
delete_3([X|R],L,L1) :- del_3(X,L,L2), delete_3(R,L2,L1).


del_3(_,[],[]).
del_3(X,[Y|L],L1) :- X==Y, !, del_3(X,L,L1).
del_3(X,[Y|L],[Y|L1]) :- del_3(X,L,L1).


% MODE: delete_chk(+A,+B,-C)
% SEMANTICS: C is the list of elements in B obtained by deleting from B all
% occurrences of the elements in A (element comparison is performed using ==).
delete_chk([],L,L).
delete_chk([X|R],L,L1) :-
  delete_elem_chk(X,L,L2),
  delete_chk(R,L2,L1).


% MODE: delete_elem_chk(+A,+B,+C)
% SEMANTICS: C is the list of elements in B obtained by deleting from B all
% occurrences of the element X (element comparison is performed using ==).
delete_elem_chk(_,[],[]).
delete_elem_chk(X,[Y|L],L1) :-
  X==Y,
  !,
  delete_elem_chk(X,L,L1).
delete_elem_chk(X,[Y|L],[Y|L1]) :-
  delete_elem_chk(X,L,L1).


% free_variables(+Goal, +Bound, +Vars0, -Vars) binds Vars to the union of Vars0 with
% the set of *FREE* variables in Goal, that is the set of variables which are captured
% neither by Bound nor by any internal quantifiers or templates in Goal.
free_variables(Term, Bound, Vars0, Vars) :-
  ( nonvar(Term) -> free_variables_1(Term, Bound, Vars0, Vars)
  ; term_is_free_of(Bound, Term), list_is_free_of(Vars0, Term) -> Vars = [Term|Vars0]
  ; Vars = Vars0 ).

free_variables_1((Conjunct,Conjuncts), Bound) --> !,
  free_variables(Conjunct,  Bound),	free_variables(Conjuncts, Bound).
free_variables_1((Disjunct ; Disjuncts), Bound) --> !,
  free_variables(Disjunct,  Bound), free_variables(Disjuncts, Bound).
free_variables_1(NormalGoal, Bound) --> data_variables(NormalGoal, Bound).

% data_variables(+Term, +Bound, +Vars0, -Vars) binds Vars to the union of Vars0 with the
% set of variables in Term which do not occur in (are not "captured by") Bound.
% When the Bound contains no variables, it delivers the same results as
% term_variables(Term, Vars0, Vars).
data_variables(Term, Bound, Vars0, Vars) :-
  ( nonvar(Term) -> functor(Term, _, N), data_variables(N, Term, Bound, Vars0, Vars)
  ; term_is_free_of(Bound, Term), list_is_free_of(Vars0, Term) ->  Vars = [Term|Vars0]
  ; Vars = Vars0 ).

data_variables(N, Term, Bound) -->
  (  { N =:= 0 } -> [] ; { arg(N, Term, Arg), M is N-1 },
  data_variables(Arg, Bound), data_variables(M, Term, Bound)).

% term_is_free_of(+Term, +Var) is a meta-logical predicate which is true when the variable
% Var does not occur anywhere in the term Term.  It is used when the Term is a tree
% built from all the existential quantifiers and Templates dominating
% (the goal containing) this variable.
term_is_free_of(Term, Var) :-
  ( var(Term) -> Term \== Var ; functor(Term, _, N), term_is_free_of(N, Term, Var) ).
term_is_free_of(N, Term, Var) :-
  ( N =:= 0 -> true ; arg(N, Term, Arg), term_is_free_of(Arg, Var), M is N-1,
  term_is_free_of(M, Term, Var) ).

% list_is_free_of(+Vars0, +Var) is a meta-logical predicate which is true when the
% variable Var is not an element of Vars0, which is known to be a list of variables.
% It is used when Vars0 is the set of free variables which have been built up so far,
% and we are considering whether Var should be added to this set.
list_is_free_of([], _).
list_is_free_of([Head|Tail], Var) :-
  Head \== Var,
  list_is_free_of(Tail, Var).


% ------------------------------------------------------------------------------
% caching mechanism
% ------------------------------------------------------------------------------
:- dynamic cache/2.

% cache(CacheName,Element)
% put Element into CacheName
put_in_cache(CacheName,Element) :-
  assert(cache(CacheName,Element)),
  map_log(finest,
    (write(' -put in '), write(CacheName), write(': '), write(Element), nl, nl)).

% hit(CacheName,Element)
% succeed if Element is in CacheName
hit(CacheName,Element) :-
  cache(CacheName,Element),
  map_log(finest,
    (write(' -hit in '), write(CacheName), write(': '), write(Element), nl, nl)).

% rem_from_cache(CacheName,Element)
% succeed if Element is in CacheName
rem_from_cache(CacheName,Element) :-
  retractall(cache(CacheName,Element)),
  map_log(finest,
    (write(' -rem from '), write(CacheName), write(': '), write(Element), nl, nl)).


% ------------------------------------------------------------------------------
initialize_current_new_def_functor(Cls) :-
  % inialize generator of new predicate definitions
  retractall(current_new_def_functor(_)),
  retractall(starting_new_def_functor(_)),
  new_name_functor_basenames(BaseNameList),
  findall(P, member((P/_,_),Cls), Preds), sort(Preds,SPreds),
  % collect all number X occurring in the heads of the form PrefixX,
  % where Prefix is the codomain of rename_pfun
  findall(Number,
    ( member(Pred,SPreds), member(Prefix,BaseNameList),
      atom_concat(Prefix,Suffix,Pred), atom_number(Suffix,Number) ), NList),
  % initialize suffix for new predicate definitions
  ( NList == [] ->  Max = 0 ; max_list(NList,Max) ),
  New is Max + 1,
  assert(current_new_def_functor(Max) ),
  assert(starting_new_def_functor(New)).

%
gen_new_name(Term,NewName) :-
  term_pred_basename(Term,Basename),      % defined in config.pl
  pred_basename_suffix(Basename,Suffix),  % defined in config.pl
  atom_concat(Basename,Suffix,NewName).

%
std_basename_suffix(M) :-
  retract(current_new_def_functor(N)),
  N2 is N + 1,
  assert(current_new_def_functor(N2)),
  number_codes(N2,N2C), atom_codes(M,N2C).

% -- gen_new_name_functor utility predicates -----------------------------------

strip_suffixes(A,B) :-
  append(B,[46|_Suffixes],A),
  \+ member(46,B). % 46='.'


filename_to_pred([C1|C1s],[C2|C2s]) :-
  ( uppercase_char(C1,C2); lowercase_char(C1,C2) ),
  !,
  filename_to_pred_tail(C1s,C2s).

filename_to_pred(C1,[110,101,119|C2]) :-
  filename_to_pred_tail(C1,C2).


filename_to_pred_tail([],[]).
filename_to_pred_tail([C1|C1s],[C2|C2s]) :-
  pred_char(C1,C2),
  filename_to_pred_tail(C1s,C2s).


pred_char(C1,C2) :-
  digit_char(C1),
  !,
  C1=C2.
pred_char(C1,C2) :-
  uppercase_char(C1),
  !,
  C1=C2.
pred_char(C1,C2) :-
  lowercase_char(C1),
  !,
  C1=C2.
pred_char(_C,95).


digit_char(C) :- C>=48, C=<57.


uppercase_char(C) :- C>=65, C=<90.


lowercase_char(C) :- C>=97, C=<122.


:- discontiguous pred_of_past_transformations/1.
% the current predicate basename does not occur in the input program
pred_of_past_transformations(Functor) :-
  \+ prefix_of_new_name_functor_basename(Functor).
prefix_of_new_name_functor_basename(Functor) :-
  new_name_functor_basenames(BaseNameList),
  member(BaseName,BaseNameList),
  sub_atom(Functor, 0, _, _, BaseName).
% the current predicate basename occurs in the input program,
% check if the number associated with the predicate name has been generated by
% the current transformation
pred_of_past_transformations(Functor) :-
  new_name_functor_basenames(BaseNameList),
  member(BaseName,BaseNameList),
  atom_concat(BaseName,TrailingChars,Functor),
  % atom_codes(TrailingChars,N1), number_codes(N,N1),
  ( atom_number(TrailingChars,N) ->
    % N is the number occurring in the predicate of the literal considered for folding
    % S is the maximum number occurring in a predicate of the input program
    ( starting_new_def_functor(S), N<S )
  ;
    % TrailingChars does not represent a number (not a new definiton)
    true
  ).

% ------------------------------------------------------------------------------
% MODE: preds_in_cls(+Cls,+InPreds, -OutPreds)
% TYPE: preds_in_cls(list(clause),list(predicate/arity),list(predicate/arity))
% SEMANTICS: OutPreds is the list of predicates occurring in Cls and in InPreds

preds_in_cls([],Preds,Preds).
preds_in_cls([Cl|Cls],InPreds,OutPreds) :-
  preds_in_cl(Cl,InPreds,Ps),
  preds_in_cls(Cls,Ps,OutPreds).


% MODE: preds_in_cl(+Cl,+InPreds, -OutPreds)
% TYPE: preds_in_cl(clause,list(predicate/arity),list(predicate/arity))
% SEMANTICS: OutPreds is the list of predicates occurring in Cl and in InPreds

preds_in_cl((H,bd(_C,G)),InPreds,Preds) :-
	preds_in_goal([H|G],InPreds,Preds).


% MODE: preds_in_goal(+Goal,+InPreds, -OutPreds)
% TYPE: preds_in_goal(list(literal),list(predicate/arity),list(predicate/arity))
% SEMANTICS: OutPreds is the list of predicates occurring in Goal and in InPreds
preds_in_goal(Goal,Preds) :-
  preds_in_goal(Goal,[],Preds).

preds_in_goal([],InPreds,InPreds).
preds_in_goal([A|As],InPreds,Preds) :-
	literal_pred(A,P/N),
	(member_chk(P/N,InPreds)  ->
		preds_in_goal(As,InPreds,Preds)
  ;
		preds_in_goal(As,[P/N|InPreds],Preds)
  ).

% MODE: preds_in_bd_cls(+Cls,+InPreds, -OutPreds)
% TYPE: preds_in_bd_cls(list(clause),list(predicate/arity),list(predicate/arity))
% SEMANTICS: OutPreds is the list of predicates occurring in Cls U InPreds

preds_in_bd_cls([],Preds,Preds).
preds_in_bd_cls([Cl|Cls],InPreds,OutPreds) :-
  preds_in_bd_cl(Cl,InPreds,Ps),
  preds_in_bd_cls(Cls,Ps,OutPreds).

preds_in_bd_cl((_H,bd(_C,G)),InPreds,Preds) :-
	preds_in_goal(G,InPreds,Preds).

% MODE: preds_in_hd_cls(+Cls,+InPreds, -OutPreds)
% TYPE: preds_in_hd_cls(list(clause),list(predicate/arity),list(predicate/arity))
% SEMANTICS: OutPreds is the list of predicates occurring in the heads of Cls

preds_in_hd_cls([],Preds,SPreds) :-
  sort(Preds,SPreds).
preds_in_hd_cls([Cl|Cls],InPreds,OutPreds) :-
  hd_pred(Cl,Pred),
  preds_in_hd_cls(Cls,[Pred|InPreds],OutPreds).

% MODE: select_hd_pred(+Pred,+Cls, -Def,-Res)
% TYPE: select_hd_pred(predicate/arity,list(clause),def,list(clause))
% SEMANTICS: Def is (Pred,D) where D is the list of clauses
% occurring in Cls whose head predicate is Pred, Res is the list of
% clauses whose head is different from Pred.

select_hd_pred(_,[],[],[]).
select_hd_pred((P/N),[C|Cls],Def,Res) :-
	(hd_pred(C,P/N) ->
		( Def=[C|Def1], select_hd_pred((P/N),Cls,Def1,Res) )
  ;
		( Res=[C|Res1], select_hd_pred((P/N),Cls,Def,Res1) )
  ).


% MODE: csel2_to_clause(+Csel, -Cl)
% SEMANTICS: transform a clause selection whose literals are partitioned into
% two (three) lists of literals into a clause with a single list of literals

csel2_to_clause((H,bd(C,B1,B2)),(H,bd(C,B))) :-
  append(B1,B2,B).


% MODE: cls_to_defs(+Preds,+Cls, -Defs)
% TYPE: cls_to_defs(list(predicate/arity),list(clause),list(def))
% SEMANTICS: the list Cls of clauses is transformed into the list Defs of
% predicate definitions consisting of a definition for each predicate in Preds
% Performance improvement: 'filter_hd_pred' has been replaced by
% 'select_hd_pred' which returns the list Res of clauses in Cls whose head
% predicate is different from P

cls_to_defs([],_,[]).
cls_to_defs([(P/N)|Preds],Cls,[(P/N,Def)|Defs]) :-
  select_hd_pred((P/N),Cls,Def,Res),
  cls_to_defs(Preds,Res,Defs).


% MODE: defs_to_cls(+Defs, -Cls)
% TYPE: defs_to_cls(list(def),list(clause))
% SEMANTICS: Cls the list of clauses occurring in Defs

defs_to_cls([],[]).
defs_to_cls([(_,Cls1)|Defs],Cls) :-
  append(Cls1,Cls2,Cls),
  defs_to_cls(Defs,Cls2).


% MODE: def(+Pred,+Defs, -Def)
% TYPE: def(predicate/arity,list(def),def)
% SEMANTICS: in Defs there exists a definition (Pred,Def) for Pred

def(P,[(P1,Def1)|_Defs],Def2) :-
  P=P1,
  !,
  Def1=Def2.
def(P,[_|Defs],Def2) :-
  def(P,Defs,Def2).


% MODE: del_def(+P,+Defs1, -Def,-Defs2)
% TYPE: del_def(predicate/arity,list(def),def,list(def))
% SEMANTICS:
% (P,Def) is the definition of P in Defs1 and Defs2 is obtained by deleting
% (P,Def) from Defs1

del_def(_P,[],[],[]).
del_def(P,[(P1,D1)|Defs],D,DDefs) :-
  ( P=P1 ->
    ( D=D1, DDefs=Defs )
  ;
    ( DDefs=[(P1,D1)|DDefs1], del_def(P,Defs,D,DDefs1) )
  ).

% ------------------------------------------------------------------------------
% bounded_width_proof_tree(+Prog,+Query) holds iff the proof tree for the input
% program Prog and the query Query has a bounded width
bounded_width_proof_tree :-
  prop_abs(Abs),
  map_log(finer,
    ( nl, nl, write('Propositional abstraction:'), nl, write(Abs), nl, nl)
  ),
  vs(prop(Name/_Arity)),
  findall((Name,L), member((Name,L),Abs), Ls), % query
  bounded(Ls,Abs,(Ls,[])),
  map_log(finer,
    ( nl, write('The program has a bounded proof tree.'), nl, nl )
  ).


% bounded(+Cls,+Prog,+Ancs) holds iff the list of clauses Cls reduces to the
% empty list by repeatedly unfolding a clause in Cl and by removing from the
% result of the unfolding all facts and all clauses whose body is exaclty
% embedded in Ancs
bounded([],_,_).
bounded([(N,L)|Ls],A,Proc) :-
  map_log(finer, ( write('Processing: '), write(L), nl ) ),
  replace(L,A,R),
  map_log(finer, ( write('Replacement: '), write(R), nl ) ),
  new_conj(N,R,Proc, R1,Proc1),
  map_log(finer, ( write('New lists: '), write(R1), nl ) ),
  append(Ls,R1,Ls1),
  bounded(Ls1,A,Proc1).


% SEMANTICS: create the propositional abstraction of the input program
prop_abs(Abs) :-
  % get the initial program (by possibly excluding some clauses)
  findall(Cl, (cc_inprog:cc(F/_,Cl), \+ to_be_exc(F) ), Cls),
  initialize_current_new_def_functor(Cls),
  prop_abs_cls(Cls,Abs).
% SEMANTICS: create the propositional abstraction of clauses
prop_abs_cls([],[]).
prop_abs_cls([Cl|Cls],[(H1,L1)|Abs]) :-
  clause_components(Cl,H,_,L),
  % get an abstraction of the clauses (by possibly excluding some calls)
  findall(F, ( member(A,[H|L]), functor(A,F,_), \+ to_be_exc(F) ), [H1|L1] ),
  prop_abs_cls(Cls,Abs).


% calls to be ecluded
to_be_exc(Name) :-
  sub_atom(Name,0,8,_,Prefix),
  memberchk(Prefix,['map_ior_','map_ite_','map_iff_','map_neq_','map_and_']).


% MODE: replace(+L,+A,-I)
% SEMANTICS: replace each element E in L by the elements in P where (E,P) in A
replace(L,A,I) :-
  replace_(L,A,[[]],I).
%
replace_([],_Abs,In,In).
replace_([E|Es],Abs,In,Out) :-
  findall(L, member((E,L),Abs), LDef),
  replace_acc(LDef,In,[], In1),
  replace_(Es,Abs,In1,Out).  % recursive step first to preserve the order


%
replace_acc([],_Ls,In, In).
replace_acc([D|Ds],Ls,In, Out) :-
  rep_append(D,Ls, O),
  append(In,O,In1),
  replace_acc(Ds,Ls,In1, Out).


%
rep_append(_D,[], []).
rep_append(D,[L|Ls], [O|O1]) :-
  append(D,L,O),
  rep_append(D,Ls, O1).


% MODE new_conj(+Cls,+Ancs, -Cls1,-Ancs)
% SEMANTICS: if NONE of the clauses in Cls is properly embedded in Ancs,
% then Cls1 is the list of clauses in Cls NOT embedded in Ancs and Ancs1
% is the Ancs U Cls1
new_conj(_P,[],Proc, [],Proc).
% Cl is a fact (leaf of the tree)
new_conj(P,[L|LsIn],Proc, LsOut,NewProc) :-
  L == [],
  !,
  map_log(finer, ( write('Deleted a fact.'), nl ) ),
  new_conj(P,LsIn,Proc, LsOut,NewProc).
% Cl is of the form H :- L and it has been processed (added to the list of
% clauses to be analyzed).
new_conj(P,[L|LsIn],Proc, LsOut,NewProc) :-
  covered(P,L,Proc),
  !,
  map_log(finer, ( write('Skipping subtree rooted in: '), write(L), nl ) ),
  new_conj(P,LsIn,Proc, LsOut,NewProc).
% Cl is of the form H :- L and it has not been processed.
new_conj(P,[L|LsIn],Proc, [C|LsOut],NewProc) :-
  \+ embedded(P,L,Proc), % L is NOT embedded in Proc
  add_conj(P,L,Proc, C,Proc1),
  map_log(finer, ( write('Not embedded, added: '), write(L), nl ) ),
  new_conj(P,LsIn,Proc1, LsOut,NewProc).


% exaclty_embedded(L1,Ls) holds iff there exists a list L in Ls
% such that L is a permutation of L1
covered(P,L,(Defs,_Ancs)) :-
  member((P,M),Defs),
  permutation(M,L).
%
covered(P,L,(Defs,Ancs)) :-
  member((A,P),Ancs),
  !,
  covered(A,L,(Defs,Ancs)).


% P is properly embedded in L
embedded(P,L,Proc) :-
  length(L,LLen),
  !,
  embedded_(P,L,LLen,Proc).
%
embedded_(P,L,_LLen,(Defs,_Ancs)) :-
  member((P,M),Defs),
  list_properly_embedded(M,L),
  !,
  map_log(finer,
    ( write('Properly embedded: '), nl, write(L), nl, write(L), nl ) ).
%
embedded_(P,L,LLen,(Defs,Ancs)) :-
  member((M,P),Ancs),
  length(M,MLen),
  MLen < LLen,
  embedded_(M,L,LLen,(Defs,Ancs)).


% list_properly_embedded(L1,L2) holds iff
% - each element of L1 belonds to L2 and
% - length(L2) > length(L1)
list_properly_embedded([],L) :-
  L \== [].
list_properly_embedded([E|L1],L2) :-
  select(E,L2,L3),
  list_properly_embedded(L1,L3).


% add the pair of lists (P,L) to Proc, where
add_conj(P,L,Proc, (Pred,L),NewProc) :-
  Proc = (Defs,Ancs),
  gen_new_name(_,Pred),
  NewProc = ([(Pred,L)|Defs],[(P,Pred)|Ancs]).


%
bagof_split_ineqs(TermsIn, TermsOutLst) :-
  bagof(TermsOut, split_ineqs(TermsIn, TermsOut), TermsOutLst).


%
split_ineqs(TermsIn, [Diseq|TermsOut]) :-
  select(Term,TermsIn,TermsIn1), Term = ( Lhs =\= Rhs ),
  !,
  ( Diseq = (Lhs < Rhs ) ; Diseq = (Lhs > Rhs ) ),
  split_ineqs(TermsIn1, TermsOut).
split_ineqs(Terms, Terms).


% SEMANTICS: unify all equalities between variables and terms
unify_eqs([]).
unify_eqs([T1=T2|Eqs]) :-
  ( var(T1) ; var(T2) ),
  call(T1=T2),
  !,
  unify_eqs(Eqs).
unify_eqs([T1=:=T2|Eqs]) :-
  ( var(T1) ; var(T2) ),
  call(T1=T2),
  !,
  unify_eqs(Eqs).
unify_eqs([_|Eqs]) :-
  unify_eqs(Eqs).


unify_eqs([], []).
unify_eqs([T1=T2|Eqs], Eqs1) :-
  ( var(T1) ; var(T2) ),
  call(T1=T2),
  !,
  unify_eqs(Eqs, Eqs1).
unify_eqs([T1=:=T2|Eqs], Eqs1) :-
  ( var(T1) ; var(T2) ),
  call(T1=T2),
  !,
  unify_eqs(Eqs, Eqs1).
unify_eqs([Eq|Eqs], [Eq|Eqs1]) :-
  unify_eqs(Eqs, Eqs1).


%
unify_eqs([],_Vars, []).
unify_eqs([Atom|Eqs],Vars, Atoms1) :-
  ( Atom = (T1=T2) ; Atom = (T1=:=T2) ),
  ( ( var(T1), member_chk(T1,Vars) ) ;
    ( var(T2), member_chk(T2,Vars) ) ;
    ( nonvar(T1), nonvar(T2)     ) ),
  call(T1=T2),
  !,
  unify_eqs(Eqs,Vars, Atoms1).
unify_eqs([Atom|Atoms],Vars, [Atom|Atoms1]) :-
  unify_eqs(Atoms,Vars, Atoms1).

%
unify_vars_eqs(Terms) :-
  unify_vars_eqs(Terms, _).

%
unify_vars_eqs([], []).
unify_vars_eqs([Atom|Eqs], Atoms1) :-
  ( Atom = (T1=T2) ; Atom = (T1=:=T2) ),
  var(T1), var(T2),
  !,
  call(T1=T2),
  unify_vars_eqs(Eqs, Atoms1).
unify_vars_eqs([Atom|Atoms], [Atom|Atoms1]) :-
  unify_vars_eqs(Atoms, Atoms1).

%
unify_vars_eqs([], [],[]).
unify_vars_eqs([Atom|Atoms], [Atom|Atoms1],Atoms2) :-
  ( Atom = (T1=T2) ; Atom = (T1=:=T2) ),
  var(T1), var(T2),
  !,
  call(T1=T2),
  unify_vars_eqs(Atoms, Atoms1,Atoms2).
unify_vars_eqs([Atom|Atoms], Atoms2,[Atom|Atoms1]) :-
  unify_vars_eqs(Atoms, Atoms1,Atoms2).

%
list_to_singletons([],[]).
list_to_singletons([E|Es],[[E]|EsS]) :-
    list_to_singletons(Es,EsS).


% MODE: select_by_funct(+Terms,+Functs -Sel,-NotSel)
% SEMANTICS: Sel is the list of terms occurring in Terms whose functor belongs
% to Functs. NotSel is the list of terms in Terms not occurring in Sel.
select_by_funct(Terms,Functs, Sel,NotSel) :-
  is_list(Functs),
  !,
  select_by_funct_aux(Terms,Functs, Sel,NotSel).
select_by_funct(Terms,Funct, Sel,NotSel) :-
  Funct == _/_,
  !,
  Functs = [Funct],
  select_by_funct_aux(Terms,Functs, Sel,NotSel).


% MODE: select_by_funct_aux(+Terms,+Funct -Sel,-NotSel)
% SEMANTICS: Sel is the lest of terms occurring in Terms whose functor is Funct.
% NotSel is the list of terms in Terms not occurring in Sel.
select_by_funct_aux([],_, [],[]).
select_by_funct_aux([Term|Terms],Functs, [Term|Sel],NotSel) :-
  functor(Term,Name,Arity),
  memberchk(Name/Arity,Functs),
  !,
  select_by_funct_aux(Terms,Functs, Sel,NotSel).
select_by_funct_aux([Term|Terms],Functs, Sel,[Term|NotSel]) :-
  select_by_funct_aux(Terms,Functs, Sel,NotSel).

% MODE: select_by_funct_aux(+Terms,+Funct -Sel)
% SEMANTICS: Sel is the lest of terms occurring in Terms whose functor is Funct.
select_by_funct_aux([],_, []).
select_by_funct_aux([Term|Terms],Functs, [Term|Sel]) :-
  functor(Term,Name,Arity),
  memberchk(Name/Arity,Functs),
  !,
  select_by_funct_aux(Terms,Functs, Sel).
select_by_funct_aux([_|Terms],Functs, Sel) :-
  select_by_funct_aux(Terms,Functs, Sel).




%%% TODO: CAN BE REPLACED BY downcase_atom ????
% MODE: term_lower(+X,-LX)
% SEMANTICS: term LX is obtained by converting term X to lower case
term_lower(X,LX) :- term_string(X,S), string_lower(S,LS), term_string(LX,LS).

%%% PRETTY PRINT TERMS
% :- use_module(library(pprint)).
%print_term(T,[nl(true)]), nl, nl,

% main predicate to pretty-print a term as JSON with indentation
pprint_term(Term) :-
  pprint_json(Term, 0), ! .


% base case: if the term is atomic, just print it with proper indentation
pprint_json(Term, Indent) :-
  (atomic(Term) ; var(Term)), !,
  indent(Indent),
  write('"'), write(Term), write('"').

% if the term is a list, print it as a JSON array
pprint_json(Term, Indent) :-
  is_list(Term), !,
  indent(Indent),
  write('['), nl,
  NewIndent is Indent + 4,
  pprint_list(Term, NewIndent),
  nl, indent(Indent), write(']').

% if the term is a compound term, print it as a JSON object
pprint_json(Term, Indent) :-
  compound(Term),
  Term =.. [Functor | Args],  % Decompose the term into functor and argument list
  indent(Indent),
  write('{'), nl,
  NewIndent is Indent + 4,
  indent(NewIndent),
  write('"'), write(Functor), write('": '), nl,
  indent(NewIndent),
  write('['), nl,
  NewIndentArgs is NewIndent + 4,
  pprint_list(Args, NewIndentArgs),
  nl, indent(NewIndent), write(']'), nl,
  indent(Indent), write('}').



% print the elements of a list (with commas between elements)
pprint_list([] , _) :- !. % base case: no more elements to print

pprint_list([Arg], Indent) :-  % if there's only one element, no comma is needed
  pprint_json(Arg, Indent).

pprint_list([Arg | Rest], Indent) :-
  pprint_json(Arg, Indent),
  write(', '), nl,
  pprint_list(Rest, Indent).

% helper predicate to print indentation
indent(0) :- !.
indent(N) :-
  N > 0,
  write(' '),
  N1 is N - 1,
  indent(N1).
