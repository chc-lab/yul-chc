% MODULE: remove_unfold
% provides: remove_unfold/2
% requires: basic_op [member_chk/2,sel_elem/3]

%:- compile('basic_op').

% TYPES
%
% Base types: term, predicate, nat, rat, any.
% Type constructors: list/1, sorted_list/1.
% Type definitions:
%    atom == predicate(term1,...,termN).
%    literal == atom; \+ atom.
%    clause == (atom, bd(list(constraint),list(literal))).
%    clause_sel == (atom,bd(list(constraint),list(literal),list(literal))).
%         (the first literal of the second list of literals
%          is the literal selected for unfolding)
%    neg_clause == (\+atom, bd(list(constraint),list(literal))).
%    arity == nat.
%    def == (predicate/arity,list(clause)).
%    def_sel == (predicate/arity, list(clause_sel)).
%    answer == true; false; unknown.
%    constraint == rat=<rat; rat>=rat; rat<rat; rat>rat; rat=rat; rat=\=rat.
%    bit == 0; 1.

% MODE: remove_unfold(+Pin, -Pout)
% TYPE: remove_unfold(list(def), list(def))
% SEMANTICS: Pin is transformed into Pout by
%    ((removing useless clauses;
%      removing subsumed clauses) ;
%    (positively and negatively unfolding wrt atoms defined by constrained facts)*)*

remove_unfold(Pin, Pout) :-
	remove_unfold_count(Pin,[], Pout, 1, 1).


% MODE: remove_unfold_count(+Pin,+M, -Pout, +N, +K)
% TYPE: remove_unfold_count(list(def),list(def), list(def), nat, bit)
% SEMANTICS: (Pin,M) is the input program, where M is the list of decided
% predicate definitions (possibly empty list of constrained facts)
% Pout is the output program
% N is the number of iterations
% At each call of remove_unfold_count(Pin,M, Pout, N, K),
% K is 1 if at least one transformation has been applied
% during the last iteration and 0 otherwise

remove_unfold_count(Pin,M, Pout, _N, K) :-
	K=0, !,
	append(Pin,M, Pout).
remove_unfold_count(Pin,Min, Pout, N, 1) :-
        map_log(finest,(write(N), nl)),
	N1 is N+1,
	decided(Pin,Min, P0,M0),
	remove_cl(P0,M0, P1,M1, K1),
        map_log(finest,(write(' -remove clauses- '), nl,
                        show_prog(P1), nl, show_prog(M1), nl)),
	unfold_cfacts(P1,M1, P2,M2, K2),
        map_log(finest,(write(' -unfold wrt constrained facts- '), nl,
                        show_prog(P2), nl,
                        show_prog(M2), nl)),
	K is max(K1,K2),
	remove_unfold_count(P2,M2, Pout, N1, K).


% MODE: decided(+P1,+M1, -P2,-M2)
% TYPE: decided(list(def),list(def), list(def),list(def))
% SEMANTICS: P2=P1\M11, M2=M1 U M11, where M11
% is the list of decided predicate definitions
% (possibly empty list of constrained facts) in P1

decided([],M, [],M).
decided([((P/N),Def)|Defs],M1, P2,M2) :-
	cfacts(Def), !,
	P2=P11,
	remove_s1(Def,Def1,_),
	M2=[((P/N),Def1)|M11],
	decided(Defs,M1, P11,M11).
decided([((P/N),Def)|Defs],M1, P2,M2) :-
	P2=[((P/N),Def)|P11],
	M2=M11,
	decided(Defs,M1, P11,M11).


% MODE: cfacts(+Def)
% TYPE: cfacts(list(clause))
% SEMANTICS: Def is a (possibly empty) list of constrained facts

cfacts([]).
cfacts([(_H,bd(_C,[]))|Cls]) :- cfacts(Cls).



% REMOVE Strategy

% MODE: remove_cl(+Pin,+Min, -Pout,-Mout, -K)
% TYPE: remove_cl(list(def),list(def), list(def),list(def), bit)
% SEMANTICS: (Pin,Min) is the input program and (Pout,Mout) is the program obtained
% from (Pin,Min) by removing useless clauses and subsumed clauses.
% Min and Mout are the decided predicate definitions.
% K is 1 iff at least one clause is removed

remove_cl(Pin,Min, Pout,Mout, K) :-
	remove_u(Pin,Min, P1,M1, K1),
	remove_s(P1,M1, Pout,Mout, K2),
	K is max(K1,K2).


% MODE: remove_u(+Pin,+Min, -Pout,-Mout, -K)
% TYPE: remove_u(list(def),list(def), list(def),list(def), bit)
% SEMANTICS: (Pout,Mout) is obtained by removing all useless clauses from (Pin,Min).
% K is 1 iff at least one clause is removed.

remove_u(Pin,Min, Pout,Mout, K) :-
	useless(Pin,UPreds1),
	(UPreds1=[] -> K=0;K=1),
        findall(P/N,member((P/N,[]),Min),UPreds2), % empty definitions
        append(UPreds1,UPreds2,UPreds),
	remove_all(UPreds,Pin,Pout),
	empty_defs(UPreds1,Min,Mout).


% MODE: useless(+Prog,-UPreds)
% TYPE: useless(list(def),list(predicate/arity))
% SEMANTICS: UPreds is the set of useless predicates in program Prog

useless(Prog,UPreds) :-
	hd_preds_in_prog(Prog,Preds),
	sort(Preds,SPreds),
	fix(Prog,SPreds,UPreds).


% MODE: hd_preds_in_prog(+Prog,-Preds)
% TYPE: hd_preds_in_prog(list(def),list(predicate/arity))
% SEMANTICS: Prog is a list of definitions for the predicates occurring in the list Preds

hd_preds_in_prog([],[]).
hd_preds_in_prog([(P/N,_Def)|Defs],[P/N|Preds]) :-
        hd_preds_in_prog(Defs,Preds).


% MODE: fix(+Prog,+Preds,-UPreds)
% TYPE: fix(list(defs),sorted_list(predicate/arity),sorted_list(predicate/arity))
% SEMANTICS: UPreds is the set of useless predicates of Prog
% which are computed as the greatest fixpoint of
% transf(Prog,-,-): Preds -> Preds

fix(Prog,Preds,UPreds) :-
        transf(Prog,Preds,TPreds),
	fix1(Prog,Preds,TPreds,UPreds).


% MODE: fix1(+Prog,+Preds,+TPreds,-UPreds)
% TYPE: fix1(list(defs),
%            sorted_list(predicate/arity),
%            sorted_list(predicate/arity),
%            sorted_list(predicate/arity))
% SEMANTICS: auxiliary predicate used in the definition of fix

fix1(_,Preds,TPreds,UPreds) :-
        subset(Preds,TPreds), !,
	UPreds=Preds.
fix1(Prog,_,TPreds,UPreds) :-
	fix(Prog,TPreds,UPreds).


% MODE: transf(+Prog,+InPreds,-OutPreds)
% TYPE: transf(list(defs),sorted_list(predicate/arity),sorted_list(predicate/arity))
% SEMANTICS: OutPreds is the subset of the predicates in InPreds which do not have
% a useful body in Prog

transf(Prog,InPreds,OutPreds) :-
        setof(P/N,
	      (member(P/N,InPreds),
	      \+ has_useful_body(Prog,P/N,InPreds)),
	      Preds),!,
	OutPreds=Preds.
transf(_Prog,_InPreds,OutPreds) :- OutPreds=[].


% MODE: has_useful_body(+Prog,+P/N,-Preds)
% TYPE: has_useful_body(list(defs),predicate/arity,list(predicate/arity))
% SEMANTICS: there exists a clause (H,bd(C,G)) in Prog such that the head
% H has predicate P/N and G contains an atom with predicate in Preds
% Note: if P/N is empty, clause_in_defs fails due to the failure of member

has_useful_body(Prog,P/N,Preds) :-
        atom_pred(H,P/N),
        clause_in_defs((H,bd(_C,G)),Prog),
        \+ has_useless_atom(G,Preds), !.


% MODE: clause_in_defs(-C,+Defs)
% TYPE: clause_in_defs(clause,list(def))
% SEMANTICS: C is a clause occurring in a definition belonging to Defs

clause_in_defs(C,[(P,Def)|_]) :-
	hd_pred(C,P), !,
	member(C,Def).
clause_in_defs(C,[_|Defs]) :-
	clause_in_defs(C,Defs).


% MODE: has_useless_atom(+Goal,+Preds)
% TYPE: has_useless_atom(goal,list(predicate/arity))
% SEMANTICS: Goal contains an atom whose predicate belongs to Preds

has_useless_atom(Goal,Preds) :-
        member(Atom,Goal),
        atom_pred(Atom,P/N),
        member(P/N,Preds), !.


% MODE: remove_all(+Preds,+Pin,-Pout)
% TYPE: remove_all(list(predicate/arity),list(def),list(def))
% SEMANTICS: Pout is obtained by deleting from Pin
% the definitions of all predicates in Preds

remove_all(_Preds,[],[]).
remove_all(Preds,[(P,_)|Defs],Pout) :-
        member(P,Preds), !,
	remove_all(Preds,Defs,Pout).
remove_all(Preds,[(P,Def)|Defs],Pout) :-
        remove_all_finitely_failed(Def,Preds,Def1),
        Pout=[(P,Def1)|Defs1],
        remove_all(Preds,Defs,Defs1).
%remove_all(Preds,[(P,Def)|Defs],Pout) :-
%	Pout=[(P,Def)|Defs1],
%	remove_all(Preds,Defs,Defs1).


% MODE: remove_all_finitely_failed(+Preds,+Pin,-Pout)
% TYPE: remove_all_finitely_failed(list(predicate/arity),list(def),list(def))
% SEMANTICS: Pout is obtained by deleting from Pin the definitions whose
% bodies contain an atom that finitely fails.

remove_all_finitely_failed([],_Preds,[]).
remove_all_finitely_failed([Cl|Cls1],Preds,Cls2) :-
        clause_bd_goal(Cl,G),
        % G contains an atom whose predicate belongs to the set of Useless Preds
        has_useless_atom(G,Preds),
        remove_all_finitely_failed(Cls1,Preds,Cls2).
remove_all_finitely_failed([Cl|Cls1],Preds,[Cl|Cls2]) :-
        remove_all_finitely_failed(Cls1,Preds,Cls2).


% MODE: remove_s(+P1,+M1, -P2,-M2, -K)
% TYPE: remove_s(list(def),list(def), list(def),list(def), bit)
% SEMANTICS: P2 is obtained by removing from P1 all clauses subsumed by a
% constrained fact in P1. If, after deletion, a definition in
% P1 consists of a list of constrained facts, then this definition
% is removed from P1 and added to M1, thereby deriving M2.
% K is 1 iff at least one clause is removed

remove_s([],M1, [],M1, 0).
remove_s([(P,Def1)|Defs1],M1, Defs2,M2, K) :-
	remove_s1(Def1,Def2,K1),
	new_prog(K1,P,Def2, Defs11,M11, Defs2,M2),
	remove_s(Defs1,M1, Defs11,M11, K2),
	K is max(K1,K2).


% MODE: remove_s1(+Def1,-Def2,-K1)
% TYPE: remove_s1(list(clause),list(clause),bit)
% SEMANTICS: Def2 is obtained by removing from Def1 all clauses subsumed by a
% constrained fact in Def1.

remove_s1([],[],0).
remove_s1([Cl1|Cls],Ds,1) :-
        select(Cl2,Cls,Cls1),
        cfact_subsumes_clause_chk(Cl1,Cl2), !,
        remove_s1([Cl1|Cls1],Ds,_).
remove_s1([Cl1|Cls],Ds,1) :-
        member(Cl2,Cls),
        cfact_subsumes_clause_chk(Cl2,Cl1), !,
        remove_s1(Cls,Ds,_).
remove_s1([Cl|Cls],[Cl|Ds],K) :-
        remove_s1(Cls,Ds,K).


remove_subs(Cls,Ds) :-
	Cf = (H1,bd(_,[])),
  select(Cf,Cls,Cls1),
	functor(H1,F,_),
  select(Cl,Cls1,Cls2),
	clause_hd(Cl,H2),
	functor(H2,F,_),
  cfact_subsumes_clause_chk(Cf,Cl),
	write('@@@@@ deleted!'), nl,
	!,
  remove_subs([Cf|Cls2],Ds).
remove_subs(Cls,Cls).


% MODE: cfact_subsumes_clause_chk(+Cl1,+Cl2)
% TYPE: cfact_subsumes_clause_chk(clause,clause)
% SEMANTICS: Cl1 is a constrained fact and Cl1 subsumes Cl2

cfact_subsumes_clause_chk((H,bd(C,[])),(H2,bd(C2,_G2))) :-
      copy_term((H,bd(C,[])),(H1,bd(C1,[]))),
        subsumes_chk(H1,H2),
        H1=H2,
        constr_imp(C2,C1).


% MODE: cfact_subsumes_clsel_chk(+ClSel1,+ClSel2)
% TYPE: cfact_subsumes_clsel_chk(clsel2,clsel2)
% SEMANTICS: Cl1 is a constrained fact and Cl1 subsumes Cl2

cfact_subsumes_clsel_chk((H,bd(C,[],[])),(H2,bd(C2,_G1,_G2))) :-
    copy_term((H,bd(C,[],[])),(H1,bd(C1,[],[]))),
    subsumes_chk(H1,H2),
    H1=H2,
    constr_imp(C2,C1).


% MODE: new_prog(+K,+P,+Def, +P1,+M1, -P2,-M2)
% TYPE: new_prog(bit,predicate/arity,list(clause),list(def),list(def),list(def),list(def))
% SEMANTICS: if K>0 (at least one subsumed clause has been deleted from the definition of P,
% thereby obtaining Def2), then add (P,Def2) to M1, otherwise add (P,Def2) to Defs1.

new_prog(K,P,Def2, Defs1,M1, Defs2,M2) :-
	K>0,
	cfacts(Def2), !,
	Defs2=Defs1,
	M2=[(P,Def2)|M1].
new_prog(_K,P,Def2, Defs1,M1, Defs2,M2) :-
	Defs2=[(P,Def2)|Defs1],
	M2=M1.


% MODE: empty_defs(+Preds,+M1,-M2)
% TYPE: empty_defs(list(predicate/arity),list(def),list(def))
% SEMANTICS: M2 is derived from M1 by adding a definition of the form
% ((P/N),[]) for each (P/N) in Preds

empty_defs([],M,M).
empty_defs([(P/N)|Preds],Min,[((P/N),[])|Mout]) :-
	empty_defs(Preds,Min,Mout).


% UNFOLD CONSTRAINED FACTS

% MODE: unfold_cfacts(+P1,+M1, -P2,-M2, -K)
% TYPE: unfold_cfacts(list(def),list(def), list(def),list(def), bit)
% SEMANTICS: (P2,M2) is obtained by unfolding P1 wrt all literal which
% are defined by (possibly empty) lists of constrained facts
% occurring in M1
% K is 1 iff at least one clause is unfolded

unfold_cfacts(P1,M1, P2,M2, K) :-
	rewrite_as_defs_with_selected_lit(P1,Defs),
	unfold_all_defs(Defs, M1, U, K),
	decided(U,M1, P2,M2).


% MODE: unfold_cfacts_and_select_cfacts(+P1,+M1, -P2,-M2, -K)
% TYPE: unfold_cfacts_and_select_cfacts(list(def),list(def), list(def),list(def), bit)
% SEMANTICS: (P2,M2) is obtained by unfolding P1 wrt all literal which
% are defined by (possibly empty) lists of constrained facts
% occurring in M1
% K is 1 iff at least one clause is unfolded
unfold_cfacts_and_select_cfacts(P1,M1, P2,M2, K) :-
        rewrite_as_defs_with_selected_lit(P1,Defs),
        incremental_unfold_all_defs(Defs, M1, U, K),
        select_cfacts(U, P2,M2).


% MODE: rewrite_as_defs_with_selected_lit(Defs1,Defs2)
% TYPE: rewrite_as_defs_with_selected_lit(list(def),list(def_sel))
% SEMANTICS: Defs2 is obtained from Defs1 by rewriting each clause (H,bd(C,G))
% as (H,bd(C,[],G), indicating that the first literal of G
% is selected for unfolding

rewrite_as_defs_with_selected_lit([],[]).
rewrite_as_defs_with_selected_lit([(P,Def1)|Defs1],[(P,Def2)|Defs2]) :-
	rewrite_as_clauses_with_selected_lit(Def1,Def2),
	rewrite_as_defs_with_selected_lit(Defs1,Defs2).


% MODE: rewrite_as_clauses_with_selected_lit(+Cls1,-Cls2)
% TYPE: rewrite_as_clauses_with_selected_lit(list(clause),list(clause_sel))
% SEMANTICS: Cls2 is obtained from Cls1 by rewriting each clause (H,bd(C,G))
% as (H,bd(C,[],G), indicating that the first literal of G
% is selected for unfolding

rewrite_as_clauses_with_selected_lit([],[]).
rewrite_as_clauses_with_selected_lit([(H,bd(C,G))|Cs],[(H,bd(C,[],G))|Ds]) :-
	rewrite_as_clauses_with_selected_lit(Cs,Ds).


% MODE: unfold_all_defs(+Defs1, +M, -Defs2, -K)
% TYPE: unfold_all_defs(list(def_sel),list(def),list(def),bit)
% SEMANTICS: Defs2 is obtained by unfolding all definitions in Defs1 wrt
% the selected literal, if this literal is defined in M.
% K is 1 iff at least one clause is unfolded

unfold_all_defs([], _M, [], 0).
unfold_all_defs([(P,Def1)|Defs1], M, [(P,Def2)|Defs2], K) :-
	unfold_all_cl(Def1, M, Def2, K1),
	unfold_all_defs(Defs1, M, Defs2, K2),
	K is max(K1,K2).


% MODE: incremental_unfold_all_defs(+Defs1, +M, -Defs2, -K)
% TYPE: incremental_unfold_all_defs(list(def_sel),list(def),list(def),bit)
% SEMANTICS: Defs2 is obtained by unfolding all definitions in Defs1 wrt
% the selected literal, if this literal is defined in M.
% K is 1 iff at least one clause is unfolded

incremental_unfold_all_defs([], _M, [], 0).
incremental_unfold_all_defs([(P,Def1)|Defs1], M, [(P,Def2)|Defs2], K) :-
        incremental_unfold_all_cl(Def1, M, Def2, K1),
        incremental_unfold_all_defs(Defs1, M, Defs2, K2),
        K is max(K1,K2).


% MODE: unfold_all_cl(+Cls1, +M, -Cls2, -K)
% TYPE: unfold_all_cl(list(clause_sel),list(def),list(clause),bit)
% SEMANTICS: Cls2 is obtained by unfolding every clause in Cls1 wrt
% the selected literal, if this literal is defined in M.
% K is 1 iff at least one clause is unfolded

unfold_all_cl([], _M, [], 0).
unfold_all_cl([(H,bd(C,G,Ls))|Cls], M, [(H,bd(C,G))|P_out1], K) :-
	Ls=[], !,
	unfold_all_cl(Cls, M, P_out1, K).
unfold_all_cl([(H,bd(C,G,[L|Ls]))|Cls], M, P_out, 1) :-
	unfoldable_lit(L,M, DefL), !,
	unfold_cl((H,bd(C,G,[L|Ls])), DefL, Ds),
	append(Ds,Cls,Cls1),
	unfold_all_cl(Cls1, M, P_out, _K).
unfold_all_cl([(H,bd(C,G,[L|Ls]))|Cls], M, P_out, K) :-
	append(G,[L],GL),
	unfold_all_cl([(H,bd(C,GL,Ls))|Cls], M, P_out, K).


% MODE: incremental_unfold_all_cl(+Cls1, +M, -Cls2, -K)
% TYPE: incremental_unfold_all_cl(list(clause_sel),list(def),list(clause),bit)
% SEMANTICS: Cls2 is the union of Cls1 and the clauses obtained by
% unfolding every clause in Cls1 wrt the selected literal,
% if this literal is defined in M.
% K is 1 iff at least one clause is unfolded

incremental_unfold_all_cl([], _M, [], 0).
incremental_unfold_all_cl([(H,bd(C,G,Ls))|Cls], M, P_out, K) :-
        Ls=[],
        !,
        P_out=[(H,bd(C,G))|P_out1],
        incremental_unfold_all_cl(Cls, M, P_out1, K).
% note that P_out1 also includes the clause selected for unfolding
incremental_unfold_all_cl([Cl|Cls], M, P_out1, K) :-
        Cl=(H,bd(C,G,[L|Ls])),
        unfoldable_lit(L,M, DefL),
        !,
        % unfold Cl wrt the selected literal
        unfold_cl(Cl, DefL, Ds),
        append(Ds,Cls,Cls1),
        % add Cl (with no selection) to the clauses obtained by unfolding
        append(G,[L|Ls],GL),
        P_out1=[(H,bd(C,GL))|P_out],
        % set the K bit to 1
        K=1,
        incremental_unfold_all_cl(Cls1, M, P_out, _K).
incremental_unfold_all_cl([(H,bd(C,G,[L|Ls]))|Cls], M, P_out, K) :-
        append(G,[L],GL),
        incremental_unfold_all_cl([(H,bd(C,GL,Ls))|Cls], M, P_out, K).


% MODE: unfoldable_lit(+L,+M, -DefL)
% TYPE: unfoldable_lit(literal,list(def),list(clause))
% SEMANTICS: Literal L is defined in M by the list of clauses DefL,
% that is, the predicate of L is P/N and there exists a definition
% (P/N,DefL) in M.

unfoldable_lit(L,M, DefL) :-
	L=(\+ A),
        ground(A), !,
	atom_pred(A,P/N),
	def(P/N,M, DefL).
unfoldable_lit(L,M, DefL) :-
	L=(\+ A), !,
	atom_pred(A,P/N),
	def(P/N,M, DefL),
	pure_cfacts(DefL).        % does not compute witnesses
%	cfacts(DefL).
unfoldable_lit(A,M, DefL) :-
	atom_pred(A,P/N),
	def(P/N,M, DefL).


% MODE: unfold_cl(+Cl, +DefL, -Ds)
% TYPE: unfold_cl(clause_sel, list(clause), list(clause_sel))
% SEMANTICS: Ds is the list of clauses obtained by unfolding Cl wrt
% a selected literal, which is defined by the list of clauses DefL

unfold_cl((H,bd(C,G,[L|Ls])), DefL, Ds) :-
	L=(\+ _A), !,
	unfold_neg_lit((H,bd(C,G,[L|Ls])), DefL, Ds).
unfold_cl((H,bd(C,G,[L|Ls])), DefL, Ds) :-
	unfold_pos_lit((H,bd(C,G,[L|Ls])), DefL, Ds).

unfold_neg_lit(Cl,DefA,Ds) :-
	copy_term(Cl,(H,bd(C,G,[(\+ A)|Ls]))),
	negated_def(A,DefA,NDefA),
	resolvents_wrt_cfacts((H,bd(C,G,[(\+ A)|Ls])),NDefA,Ds).


% MODE: negated_def(+A,+Cls,-NDef)
% TYPE: negated_def(atom,list(clause),list(clause))
% SEMANTICS: Cls is a list of clauses of the form (A,D) and NDef is a
% list of 'clauses' of the form (\+ A,E) representing the negation
% of the only if part of Cls. Thus, if Cls represents the clauses
% (A <- D1), ..., (A <- Dm), then NDef represents the implications
% (\+ A <- E1), ..., (\+ A <- En) such that (E1 or ... or En)
% is equivalent to not(D1 or ... or Dm)

negated_def(A, [], [((\+ A),bd([],[]))]).
negated_def(A, [(A,bd(C,[]))|Cls], NDef) :-
	negated_def(A, Cls, NDef1),
	distribute_neg_cs(C,NDef1,NDef).


% MODE: distribute_neg_cs(+Cs,+NDef1,-NDef2)
% TYPE: distribute_neg_cs(list(constraint),list(neg_clause),list(neg_clause))
% SEMANTICS: the negations of the constraints Cs=[C1,...,Cn] are
% distributed over the bodies of the negative clauses NDef1=[D1,...,Dn],
% thereby getting NDef2

distribute_neg_cs([],_NDef,[]).
distribute_neg_cs([C1|Cs],NDef1,NDef2) :-
	distribute_neg_c(C1,NDef1,NDef11),
	append(NDef11,NDef12,NDef2),
	distribute_neg_cs(Cs,NDef1,NDef12).


% MODE: distribute_neg_c(+C,+NDef1,-NDef2)
% TYPE: distribute_neg_c(constraint,list(neg_clause),list(neg_clause))
% SEMANTICS: the negation of the constraint C is
% distributed over the bodies of the negative clauses NDef1=[D1,...,Dn],
% thereby getting NDef2

distribute_neg_c(_C,[],[]).
distribute_neg_c(C,[(L,bd(C1,[]))|Cls1],Ds) :-
	negated_c(C,NC),
	term_variables([NC|C1],Vars),
	constr_solve([NC|C1],Vars,Cns),
	\+ constr_ff(Cns),
	!,
	Ds=[(L,bd(Cns,[]))|Cls2],
	distribute_neg_c(C,Cls1,Cls2).
distribute_neg_c(C,[_|Cls1],Ds) :-
	Ds=Cls2,
	distribute_neg_c(C,Cls1,Cls2).


% MODE: negated_c(+C1,-C2)
% TYPE: negated_c(constraint,constraint)
% SEMANTICS: C2 is the negation of constraint C1

negated_c(N1=<N2,N1>N2) :- !.
negated_c(N1>=N2,N1<N2) :- !.
negated_c(N1>N2,N1=<N2) :- !.
negated_c(N1<N2,N1>=N2) :- !.
negated_c(C1,C2) :- C1=.. [=,  N1,N2], C2=.. [=\=,N1,N2].
negated_c(C1,C2) :- C1=.. [=\=,N1,N2], C2=.. [=,  N1,N2].


% MODE: resolvents_wrt_cfacts(+Cl,+Cls1,-Cls2)
% TYPE: resolvents_wrt_cfacts(clause_sel,list(clause),list(clause))
% SEMANTICS: Cls2 is the list of resolvents of Cl and Cls1 wrt the
% selected literal

resolvents_wrt_cfacts(_Cl,[],[]).
resolvents_wrt_cfacts(Cl1,[Cl2|Cls],Res) :-
	copy_term(Cl1,(H1,bd(C1,G1,[A1|Ls1]))),
	copy_term(Cl2,(H2,bd(C2,[]))),
	A1=H2,
  constr_and(C1,C2,C3),
	term_variables((H1,G1,Ls1),V),
	constr_solve(C3,V,C4),
	\+ constr_ff(C4),
	!,
	Res=[(H1,bd(C4,G1,Ls1))|Res1],
	resolvents_wrt_cfacts(Cl1,Cls,Res1).
resolvents_wrt_cfacts(Cl1,[_Cl2|Cls],Res) :-
	resolvents_wrt_cfacts(Cl1,Cls,Res).


% MODE: unfold_pos_lit(+Cl,+DefA,-Ds)
% TYPE: unfold_pos_lit(clause_sel,list(clause),list(clause))
% SEMANTICS: Ds is the list of clauses derived by unfolding Cl wrt
% a selected literal using the clauses in DefA

unfold_pos_lit(Cl,DefA,Ds) :-
	copy_term(Cl,(H,bd(C,G,[A|Ls]))),
	resolvents_wrt_cfacts((H,bd(C,G,[A|Ls])),DefA,Ds).


% MODE: pure_cfacts(+Cls)
% TYPE: pure_cfacts(list(clause))
% SEMANTICS: Cls is a list of constrained facts of the form (p(X1,...,Xk),Body)
% where X1,...,Xk are distinct variables

pure_cfacts([]).
pure_cfacts([(H,bd(_C,[]))|Cls]) :-
	H=..[_P|Args],
	distinct_vars(Args), !,
	pure_cfacts(Cls).
pure_cfacts([(pcf(X),bd(_C,[]))|Cls]) :-		% used for parameter synthesis
	functor(X,p,_),
	pure_cfacts(Cls).


% MODE: distinct_vars(+Vars)
% TYPE: distinct_vars(list(any))
% SEMANTICS: Vars is a list of distinct variables


% commented out by EMA
%The procedure distinct_vars/1 is being redefined.
%    Old file: /home/emanuele/MAPline_swi/src_sics/basic_op.pl
%    New file: /home/emanuele/MAPline_swi/src_sics/remove_unfold.pl
%distinct_vars([]).
%distinct_vars([V|Vs]) :-
%	var(V),
%	\+ member_chk(V,Vs),
%	distinct_vars(Vs).



% MODE: remove_useless_subsumed_clauses(+Pin, -Pout)
% TYPE: remove_useless_subsumed_clauses(list(def),list(def))
% SEMANTICS: Pin is the input program and Pout is the program obtained
% from Pin by removing useless clauses and subsumed clauses.
remove_useless_subsumed_clauses(Pin, Pout) :-
    map_log(fine,(write(' -removal of useless and subsumed clauses- '), nl, nl,
                  write(' -initial program- '), nl, show_prog(Pin), nl)),
    Min=[],
    remove_cl(Pin,Min, Pout,Mout, K),
    map_log(fine,(K==1 ->
                   (write(' -final program- '), nl,
                    show_prog(Pout), nl,
                    write(' -decided predicates- '), nl,
                    empty_defs(DPreds,Min,Mout), write(DPreds), nl)
                 ;
                   (write(' -no clause removed- '), nl))).


% -----------------------------------------------------------------------------

query_cfacts(Pin,QPred, QFacts,PredSMTVars) :-
        select_cfacts(Pin, Rules,Facts), nl,
        map_log(finest,(write(' -initial constrained facts- '),nl,
                        show_prog(Facts),nl)),
        % initialize Mem
        findall(((P/N),1),member(((P/N),_Def),Facts),UnfMem),
        UnfCycles=2,
        repeat_unfold_cfacts_and_select_cfacts(Rules,Facts,Facts,UnfMem,UnfCycles, _Rules1,AccFacts,_UnfMem),
        ( member((QPred,QFacts),AccFacts) ->
          map_log(finest,(write(' -query facts- '),nl,show_cls(QFacts),nl))
        ;
          map_log(info,(write('No facts for '),write(QPred),nl,nl))
        ),
        member((pred_smtvars_types/1,PredSMTVars),AccFacts).


% MODE: repeat_unfold_cfacts_and_select_cfacts(+RulesIn,+FactsIn,+AccFactsIn,+UnfMem,+UnfCycles,
%                                              -RulesOut,-FactsOut,-AccFactsOut,-UnfMem)
repeat_unfold_cfacts_and_select_cfacts(Rules,[],AccFacts,UnfMem,_UnfCycles, Rules,AccFacts,UnfMem).
repeat_unfold_cfacts_and_select_cfacts(RulesIn,FactsIn,AccFactsIn,UnfMemIn,UnfCycles,
                                       RulesOut,AccFactsOut,UnfMemOut) :-
        % unfold rules w.r.t. constrained facts
        unfold_cfacts_and_select_cfacts(RulesIn,FactsIn, RulesIn1,NewFacts, _K),
        map_log(finest,(write(' -new constrained facts- '),nl,
                        show_prog(NewFacts),nl)),
        % select facts for the next unfolding step
        remove_already_unfolded_predicate_definitions(NewFacts,AccFactsIn ,UnfMemIn,UnfCycles,
                                                      FactsIn1,AccFactsIn1,UnfMemIn1),
        map_log(finest,(write(' -new constrained facts to be used for unfolding- '),nl,
                        show_prog(FactsIn1),nl)),
        repeat_unfold_cfacts_and_select_cfacts(RulesIn1,FactsIn1,AccFactsIn1,UnfMemIn1,UnfCycles,
                                               RulesOut,AccFactsOut,UnfMemOut).


select_cfacts([], [],[]).
select_cfacts([((P/N),Def)|Defs], NDef,CDef) :-
        select_cfacts_cls(Def, NDef1,CDef2),
        !,
        ( NDef1=[] ->
          NDef=NDefs
        ;
          NDef=[((P/N),NDef1)|NDefs]
        ),
        ( CDef2=[] ->
          CDef=CDefs
        ;
          CDef=[((P/N),CDef2)|CDefs]
        ),
        select_cfacts(Defs, NDefs,CDefs).


select_cfacts_cls([], [],[]).
select_cfacts_cls([Cl|Cls], NCls,CCls) :-
        cfact(Cl),
        !,
        CCls=[Cl|CCls1],
        select_cfacts_cls(Cls, NCls,CCls1).
select_cfacts_cls([Cl|Cls], [Cl|NCls],CCls) :-
        select_cfacts_cls(Cls, NCls,CCls).


% MODE: remove_already_unfolded_predicate_definitions(+FactsIn,+AccFactsIn, -FactsOut,-AccFactsOut)
remove_already_unfolded_predicate_definitions([],AccFacts,UnfMem,_Depth, [],AccFacts,UnfMem).
% if the predicate symbol P/N of new facts occurs in the accumulated facts and
%    its facts have been unfolded UnfCycles times,
% then add new facts in FactsIn to those occurring in AccFactsIn
remove_already_unfolded_predicate_definitions([NewFacts|FactsIn],AccFactsIn,UnfMemIn,UnfCycles,
                                              FactsOut,[Fact|AccFactsOut],[PUnfCounter|UnfMemOut]) :-
        NewFacts=((P/N),Def1),
        % Note that for all facts in FactsIn there is an entry in UnfMemIn
        select(((P/N),Counter),UnfMemIn,UnfMemIn1),
        Counter>=UnfCycles,
        !,
        OldFacts=((P/N),Def2),
        select(OldFacts,AccFactsIn,AccFactsIn1),
        append(Def1,Def2,Def3),
        Fact=((P/N),Def3),
        Counter1 is Counter + 1,
        PUnfCounter=((P/N),Counter1),
        remove_already_unfolded_predicate_definitions(FactsIn,AccFactsIn1,UnfMemIn1,UnfCycles,
                                                      FactsOut,AccFactsOut,UnfMemOut).
% if the predicate symbol P/N of new facts occurs in the accumulated facts and
%    its facts have been unfolded less than UnfCycles times,
% then add new facts in FactsIn to those occurring in AccFactsIn
remove_already_unfolded_predicate_definitions([NewFacts|FactsIn],AccFactsIn,UnfMemIn,UnfCycles,
                                              [Fact|FactsOut],[Fact|AccFactsOut],[PUnfCounter|UnfMemOut]) :-
        NewFacts=((P/N),Def1),
        select(((P/N),Counter),UnfMemIn,UnfMemIn1),
        Counter<UnfCycles,
        !,
        OldFacts=((P/N),Def2),
        select(OldFacts,AccFactsIn,AccFactsIn1),
        append(Def1,Def2,Def3),
        Fact=((P/N),Def3),
        Counter1 is Counter + 1,
        PUnfCounter=((P/N),Counter1),
        remove_already_unfolded_predicate_definitions(FactsIn,AccFactsIn1,UnfMemIn1,UnfCycles,
                                                      FactsOut,AccFactsOut,UnfMemOut).
% if the predicate symbol P/N of new facts DOES NOT occur in UnfMemIn
% then add new facts to FactsOut and AccFactsOut, and set its counter for unfolding in UnfMemIn to 1
remove_already_unfolded_predicate_definitions([Fact|FactsIn],AccFactsIn,UnfMemIn,UnfCycles,
                                              [Fact|FactsOut],[Fact|AccFactsOut],[((P/N),1)|UnfMemOut]) :-
        Fact=((P/N),_),
        remove_already_unfolded_predicate_definitions(FactsIn,AccFactsIn,UnfMemIn,UnfCycles,
                                                      FactsOut,AccFactsOut,UnfMemOut).
