
% MODE: rule(+RuleName)
% TYPE: rule(term)
% SEMANTICS: rule(X) holds iff X belongs to the array theory

rule(R) :- vs(theory(array,_,(_,Rs),_)), member(R,Rs).


solve(array,Cn,_Vars,Cn).


entails(array,CL,DL) :-
  subsumes_chk_conj(DL,CL,CLSub,_),
  DL=CLSub.


true_write_constraint(array,Cn,Cn1) :-
  select((write/4,_),Cn,Rest),
  append(Rest,[(write/4,[])],Cn1).


%-------------------------------------------------------------------------------
gen_array(D,CD,GD) :-

    clause_bd_cns(D, Cns1),
    memberchk((array,Arr1),Cns1), memberchk((read/3,R1),Arr1), length(R1,N),
    clause_bd_cns(CD,Cns2),
    memberchk((array,Arr2),Cns2), memberchk((read/3,R2),Arr2), length(R2,N),


    % temporary ancestor
    % (add the elements of the theory to the literals)
    cl_from_cns_to_lits(D,rat,TempAncestor),

    % temporary candidate
    % (add the elements of the theory to the literals)
    cl_from_cns_to_lits(CD,rat,TempCandidate),

    !,

    % standard generalization between constraints over rationals
	  copy_term(TempAncestor,(_H1,bd(C1,B1))),
	  copy_term(TempCandidate,(H2,bd(C2,B2))),
	  B1=B2,
	  primitives(C1,I1),
	  plain_cns_widening(I1,C2,C3),
	  TempGDef=(H2,bd(C3,B2)),

    % new definitionplain_widening
    cl_from_lits_to_cns(TempGDef,CD,GD),

    show_genres_cls(D,CD,GD).


%-------------------------------------------------------------------------------
% merge array
merge_array(chull,D,CD,GD) :-

    clause_bd_cns(D, Cns1),
    memberchk((array,Arr1),Cns1), memberchk((read/3,R1),Arr1), length(R1,N),
    clause_bd_cns(CD,Cns2),
    memberchk((array,Arr2),Cns2), memberchk((read/3,R2),Arr2), length(R2,N),

    % temporary ancestor
    % (add the elements of the theory to the literals)
    cl_from_cns_to_lits(D,rat,TempAncestor),

    % temporary candidate
    % (add the elements of the theory to the literals)
    cl_from_cns_to_lits(CD,rat,TempCandidate),

    !,

    % standard convex hull between constraints over rationals
    copy_term(TempAncestor,(_H1,bd(C1,B1))),
    copy_term(TempCandidate,(H2,bd(C2,B2))),
    term_variables(B1,V1),
    term_variables(B2,V2),
    convex_hull(V1,C1,V2,C2,V3,C3),
    int_coeff_transf(C3,C4),
    V3=V2,
    TempGDef=(H2,bd(C4,B2)),

    % new definition
    cl_from_lits_to_cns(TempGDef,CD,GD).


%-------------------------------------------------------------------------------
% move all constraints except SavedCn to the list of literals
cl_from_cns_to_lits(Cl1,SavedCn,Cl2) :-
  Cl1=(H1,bd(Cn1,Lits1)),
  selectchk((SavedCn,RatCn),Cn1,Rest),
  Cl2=(H1,bd(RatCn,[cns(Rest)|Lits1])).

% move all constraints except SavedCn and DeletedCn to the list of literals
cl_from_cns_to_lits(Cl1,SavedCn,DeletedCn,Cl2) :-
  Cl1=(H1,bd(Cn1,Lits1)),
  selectchk((SavedCn,RatCn),Cn1,Rest),
  selectchk((DeletedCn,_),Rest,Rest1),
  Cl2=(H1,bd(RatCn,[cns(Rest1)|Lits1])).


cl_from_lits_to_cns(Gen1,Cand,Gen2) :-
     ( Gen1=(H1,bd(RatCn,[cns(Rest)|Lits])),
       Gen2Cn=[(rat,RatCn)|Rest],
       ( vs(theory(symtab,_,_,_)) ->
         % using array and val constraints
         (% make a copy of the candidate definition (with val's)
          copy_term(Cand,(_,bd(Cand2Cn,Cand2Lits))),
          % retrieve the symtab constraint
          selectchk((symtab,Cand2Vals),Cand2Cn,Cand2Rest),
          % retrieve the array constraint
          memberchk((array,Cand2Array),Cand2Rest),
          % unify literals and the array constraint of the (copy of)
          % the candidate definition and the literals and the array
          % constraint occurring in the generalized definition
          Cand2Lits=Lits,
          [(array,Cand2Array)]=Rest,
          % add the symtab constraint to the rational and array constraints
          append(Gen2Cn,[(symtab,Cand2Vals)],Gen2Cn1),
          % construct a generalized definition (with val's)
          Gen2=(H1,bd(Gen2Cn1,Lits))
         );
          Gen2=(H1,bd(Gen2Cn,Lits))
        )
      ).

%-------------------------------------------------------------------------------
% annotated_vcs
%-------------------------------------------------------------------------------
% annotated_vcs is called by exec(udf) in transformer.pl

:- multifile callable/2, unfoldable/2, foldable/2.

annotated_vcs(Prog,AProg) :-
    pprog(Prog,PProg),
    defs(Defs),
    penv(Defs,EnvCls),
    findall_v_clause(Int),
    append(EnvCls,Int,Cls),
    preds_in_cls(Cls,[],Preds),
    cls_to_defs(Preds,Cls,P0),
    annotate_vcs(PProg,P0,[],AProg).


annotate_vcs([],_,Prog,Prog).
annotate_vcs([Cl|Cls],P0,Prog_in,Prog_out) :-
    inv_unfold(Cl,P0,ACls),
    append(Prog_in,ACls,Prog_in1),
    annotate_vcs(Cls,P0,Prog_in1,Prog_out).


pprog(Prog,PProg) :-
  findall(Cl1,
    ( member(Cl,Prog),
      %(Cl=(H,bd(C,[A])) ->
      (Cl=(H,bd(C,L)) ->
        (term_variables(H,HVars),
         %term_variables(A,AVars),
         %commonvars(HVars,AVars,CVars),
         %delete_commonvars(AVars,CVars,AVars1),
         %Cl1=(H,bd(C,[bindings(H,HVars),bindings(A,AVars1)|[A]]))
         bindings_list(L,HVars,List),
         append(List,L,L1),
         Cl1=(H,bd(C,[bindings(H,HVars)|L1]))
        );
      (Cl=(H,bd(C,[])), term_variables(H,Vars), Cl1=(H,bd(C,[bindings(H,Vars)])) )
      )
    ),
    PProg).


bindings_list([],_,[]).
bindings_list([A|As],HVars,[bindings(A,AVars1)|BAs]) :-
    map_term_variables(A,AVars),
    commonvars(HVars,AVars,CVars),
    delete_commonvars(AVars,CVars,AVars1),
    bindings_list(As,HVars,BAs).


delete_commonvars(AVars,[],AVars).
delete_commonvars(AVars,[Var|Vars],AVars2) :-
    delete_var(AVars,Var,AVars1),
    delete_commonvars(AVars1,Vars,AVars2).


delete_var([Var|Vars],Var1,Vars) :- Var==Var1, !.
delete_var([Var|Vars],Var1,[Var|Vars1]) :- delete_var(Vars,Var1,Vars1).


penv(Defs,EnvCls) :-
  findall((denv(H,e(Env)),bd(Cns,[])),
    (member(Def,Defs),
     def_env(Def,H,Cns,Env)),
    EnvCls).


v_clause(bindings(\+A,Vars),  [ denv(A,e([H|T])), lookup_vals(Vars,[H|T]) ]).
v_clause(bindings(A,Vars),    [ denv(A,e([H|T])), lookup_vals(Vars,[H|T]) ]).
v_clause(bindings(A,_Vars),   [ denv(A,e([])) ]).
v_clause(bindings(\+A,_Vars), [ denv(A,e([])) ]).


v_clause(lookup_vals([],_E), []).
v_clause(lookup_vals([VCVar|Vars],E), [ lookup_progvar(VCVar,E,ProgVar,_), val(ProgVar,VCVar), lookup_vals(Vars,E) ]).


lookup_progvar(VCVar,[Elem|_],ProgVar,Attr) :-
   env_elem_components(Elem,ProgVar,VCVar1,Attr),
   VCVar==VCVar1,
   !.
lookup_progvar(VCVar,[Elem|_],ProgVar,Attr) :-
   env_elem_components(Elem,ProgVar,(VCVar1,_),Attr),
   VCVar==VCVar1,
   !.
lookup_progvar(VCVar,[_|Vars],ProgVar,Attr) :-
   lookup_progvar(VCVar,Vars,ProgVar,Attr).
lookup_progvar(_,[],_,_) :-
   map_error(write('Cannot resolve the val of a logic variable. Please, check the specification.')).


findall_v_clause(Cls) :-
  findall((H2,bd(Cns2,Lits2)), ( v_clause(H2,B2), constr(B2,Cns2,Lits2) ), Cls).


def_env(Def,H,Cns,EnvList1) :-
    Def=(H,bd(Cns,Lits)),
    ((Lits=[Reach], env_to_list(Reach,EnvList)) -> EnvList1=EnvList; EnvList1=[]).


unfoldable(smc,bindings(_,_)).
unfoldable(smc,denv(_,_)).
unfoldable(smc,lookup_vals(_,_)).
callable(smc,lookup_progvar(_,_,_,_)).
callable(smc,term_variables(_,_)).
callable(smc,nothing_to_be_annotated(_,_,_)).
callable(smc,a(_)).


% MODE: lits_to_buckets(+Preds,+Lits, -Buckets,-Res)
% TYPE: lits_to_buckets(list(predicate/arity),list(literal),
%                       list((predicate/arity),list(literal)),list(literal))
% SEMANTICS: the list Lits of literals is transformed into the list Buckets
% of pairs (P/N,L), where L is the list of literals whose head is P of arity N,
% Res is the list of literals whose predicate symbols do not belong to Preds

lits_to_buckets([],OutOfBuckets,[],OutOfBuckets).
lits_to_buckets([(P/N)|Preds],Lits,[(P/N,Def)|Defs],OutOfBuckets) :-
	select_literal_pred((P/N),Lits,Def,Res),
	lits_to_buckets(Preds,Res,Defs,OutOfBuckets).


% MODE: select_hd_pred(+Pred,+Cl, -Def,-Res)
% TYPE: select_hd_pred(predicate/arity,list(clause),def,list(clause))
% SEMANTICS: Def is (Pred,D) where D is the list of literals
% occurring in Cl whose head predicate is Pred, Res is the list of
% literals whose head is different from Pred.

select_literal_pred(_,[],[],[]).
select_literal_pred((P/N),[Lit|Lits],Def,Res) :-
    (literal_pred(Lit,P/N) ->
		(Def=[Lit|Def1], select_literal_pred((P/N),Lits,Def1,Res));
		(Res=[Lit|Res1], select_literal_pred((P/N),Lits,Def,Res1))
    ).

%
rw_basic_variables([],[],[]).
rw_basic_variables([],[write(_,I,V,_)|WriteLst],[I,V|RWVars]) :-
  rw_basic_variables([],WriteLst,RWVars).
rw_basic_variables([read(_,I,V)|ReadLst],WriteLst,[I,V|RWVars]) :-
  rw_basic_variables(ReadLst,WriteLst,RWVars).
