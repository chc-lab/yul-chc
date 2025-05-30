% ==============================================================================
%
%          FILE: types.pl
%
%   DESCRIPTION: type inference system for prolog
%         USAGE: see transform
%
%  REQUIREMENTS: ---
%       LICENSE: See the file LICENSE.txt for license and copyright details.
%         NOTES: this modules may throw the following exceptions:
%                cannot_infer_type/1
%                type_mismatch/3
%                wrong_pred_sign/1
%                already_def_pred/1
%                already_def_type/1
%
% ==============================================================================

:- module(types,
    [ cata_on/2
    , show_cata/0
    , term_variables_types/2
    , typed_term/2
    , typed_term/3
    , user_defined_type/1
    , user_defined_pred/1
    , user_defined_pred_has_mode/1
    , user_defined_pred_has_mode/3 % fails if mode is undef
    , user_defined_pred_mode/3     % throws an exception if mode is undef
    , show_types/1            % show_types(+list(cls))
    , is_type/1
    , is_cata/1
    , type_constructors_def/2
    , type_constructor_def/2
    , type_constructors/2
    , type_constructor/2
    , var_type/3
    , arg_type/3
    , show_signatures/1
    , show_modes/1
    , bnbvars/3
    , is_basic_type/1
    , fix_equalities/3
    , add_hd_pred_sign/1
    , add_pred_sign/1
    , add_hd_pred_mode/1
    , add_pred_mode/1
    , add_pred_mode/3
    , catamorphic_abstraction/2
    % progspec manipulation interface
    , prog_spec/3
    , prog_spec/5
    , assert_prog_spec/3
    , assert_prog_spec/5
    , retract_prog_spec/1
    , update_prog_spec/1
    , update_prog_spec/5
    , show_prog_spec/0
    , show_prog_spec/1
    , show_prog_spec/5
    , updated_prog_spec/0
    % map directives 
    , op(1150, fx, type)
    , op(1150, fx, pred)
    , op(1150, fx, mode)
    , op(1150, fx, cata)
    , op(1150, fx, spec)
    , op(1150, fx, fun)
    , op(1150, fx, cata_abs)
    % map operators -- the higher the priority the lower the binding power
    , op(1140, xfx, ==>)
    , op(1130, xfx, --->)
    , op(1105, xfx, =>)   % implication
    , op(1105, xfx, &)    % and
    , op(1105, xfx, v)    % or
    % op(300, _, ~)       % negation (*)
    % op(700, _, R)       % comparison relations R in {>,>=,=,=<,<} (**)
    , op(100,  yfx, ::)
 	  ]).
% (*) negation (~) does not need to be defined - provided by clpb
% ?- current_op(A,B,~). A = 300, B = fy.  % use_module(library(clpb)).
% (**) comparison relations R in {>, >=, =, =<, <}
% ?- current_op(A,B,R). A = 700, B = xfx. % use_module(library(clpq)).
% ite/3 does not need to be defined - relation defined in this module

:- multifile types:functor_signature/4,
             types:user_defined_type/1,
             types:user_defined_pred/1,
             user:map_term_expansion/2.


:- dynamic types:functor_signature/4,
           types:functor_mode/3,
           types:functor_mode/1,
           types:functor_fun/5,
           types:user_defined_type/1,
           types:user_defined_pred/1,
           user:map_term_expansion/2,
           types:catamorphism/2,
           types:cata_abs_def/2.

% MODE: term_variables_types(+Term::Type, -VarsTypes).
% SEMANTICS: Term is a term of type Type and VarsTypes is a list of elements of
% the form V::T, where T is the type of variable V
term_variables_types(Term::Type, VarsTypes) :-
  nonvar(VarsTypes), % types of variables in Term are known
  infer_term_variables_types(Term::Type,VarsTypes).
term_variables_types(Term::Type, VarsTypes) :-
  var(VarsTypes),    % types of variables in Term have to be deduced
  term_variables(Term,Vars),
  initial_types(Vars,VarsTypes),
  user_defined_pred_first(Term,STerm), % optimization: user_defined_pred first
  infer_term_variables_types(STerm::Type,VarsTypes).
% cannot recognize Term and Type
term_variables_types(Term::Type,VarsTypes) :-
  var(VarsTypes),
  \+ can_infer_term_variables_types(Term::Type),
  throw(cannot_infer_type(Term::Type)).

% MODE: can_infer_term_variables_types(+Term::Type).
% SEMANTICS: Term is a term of type Type.
can_infer_term_variables_types(Term::Type) :-
  term_variables(Term,Vars),
  initial_types(Vars,VarsTypes),
  infer_term_variables_types(Term::Type,VarsTypes),
  !.

% MODE: typed_term(?Term,?TypedTerm).
% SEMANTICS: TypedTerm is of the form Term::Type, where Type is the type of
% Term and all its subterms have been annotated with the corresponding types
%typed_term(constr(C),constr(C)::bool):- ! .

typed_term(Term, TypedTerm) :-
  typed_term(Term, TypedTerm,_VarsTypes).

% MODE: typed_term(?Term,?TypedTerm,?VarsTypes).
% SEMANTICS: TypedTerm is of the form Term::Type, where Type is the type of
% Term and all its subterms have been annotated with the corresponding types
% and VarsTypes is a list of elements of the form V::T, where T is the type
% of variable V
typed_term(Term, TypedTerm,VarsTypes) :-
  nonvar(Term),
  term_variables(Term,Vars),
  initial_types(Vars,VarsTypes),
  term_typedTerm(Term,VarsTypes, TypedTerm).
typed_term(Term, _TypedTerm,_VarsTypes) :-
  nonvar(Term),
  \+ can_infer_term_type(Term),
  throw(cannot_infer_type(Term)).
typed_term(Term, TypedTerm,_VarsTypes) :-
  nonvar(TypedTerm),
  typedTerm_term(TypedTerm, Term).

% MODE: can_infer_term_type(+Term).
% SEMANTICS: There exists a TypedTerm for Term
can_infer_term_type(Term) :-
  term_variables(Term,Vars),
  initial_types(Vars,VarsTypes),
  term_typedTerm(Term,VarsTypes, _TypedTerm).


% MODE: unify_types(?T1,?T2)
% SEMANTICS: T1 and T2 are either the same type (e.g. list(int)=list(int))
% or their types are compatible   (e.g. list(int)=list(type(X))
unify_types(T1,T2) :-
  nonvar(T1),
  T1=maptype(T3),
  !,
  unify_types(T3,T2).
unify_types(T1,T2) :-
  nonvar(T2),
  T2=maptype(T3),
  !,
  unify_types(T1,T3).
unify_types(T1,T2) :-
  T1=T2,
  !.
unify_types(T1,T2) :-
  functor(T1,F,Arity),
  functor(T2,F,Arity),
  T1 =.. [F|Args1],
  T2 =.. [F|Args2],
  maplist(unify_types,Args1,Args2).

% MODE: infer_term_variables_types(+Term::Type,+VarsTypesIn).
% SEMANTICS: Term is a term of type Type and VarsTypesIn is a set of
% elements of the form V::T, where T is the type of variable V.
infer_term_variables_types(Term::Type,VarsTypes) :-
  var(Term),
  lists:member(Var::VarType,VarsTypes), Var==Term, % find Var
  ( unify_types(VarType,Type) ->
    % unification may fail: inconsistences may arise from wrong guesses done
    % by the type inference system, e.g., in guessing types of =/2 arguments)
    true
  ;
    fail
  ).
% atom, constant
infer_term_variables_types(Term::Type,_VarsTypes) :-
  nonvar(Term),
  functor(Term,Symb,0),
  functor_signature(Symb,0,[],Type1),
  unify_types(Type,Type1).
% tuple of Terms (tuple represented as map___terms_tuple with a list)
infer_term_variables_types(Term::Type,VarsTypes) :-
  nonvar(Term),
  Term=map___terms_tuple([A|As]), Type=map___types_tuple([T|Ts]),
  infer_term_variables_types(A::T,VarsTypes),
  infer_term_variables_types(map___terms_tuple(As)::map___types_tuple(Ts),VarsTypes).
infer_term_variables_types(Term::Type,_VarsTypes) :-
  nonvar(Term),
  Term=map___terms_tuple([]), Type=map___types_tuple([]).
% compound term representing a type
infer_term_variables_types(Term::Type,_VarsTypes) :-
  compound(Term),
  is_type(Term),
  Type=maptype(Term).
% functor (function or predicate) symbol applied to N>=1 terms
% Note: for lists [Funct|Args] instanciates to [[|],H,Tail]
infer_term_variables_types(Term::Type,VarsTypes) :-
  compound(Term),
  functor(Term,Symb,Arity),
  Term=..[Symb|Args],
  functor_signature(Symb,Arity,List,Type1),
  unify_types(Type1,Type),
  ArgsT=map___terms_tuple(Args), SignT=map___types_tuple(List),
  infer_term_variables_types(ArgsT::SignT,VarsTypes).

% MODE: term_typedTerm(+Term,+VarsTypes, -TypedTerm).
% SEMANTICS: TypedTerm is a term of the form Term::Type, where Type is the type
% of Term and all subterms of Term have been annotated with the corresponding
% types. VarsTypesIn is a set of elements of the form V::T, where T is the type
% of variable V occurring in Term
term_typedTerm(Term,VarsTypes, Term::Type) :-
  var(Term),
  lists:member(Var::VarType,VarsTypes), Var == Term, % find Var
  VarType = Type. % unify VarType with Type
  % unification may fail: inconsistences may arise from wrong guesses done
  % by the type inference system, e.g., in guessing types of =/2 arguments)
% atom, constant
term_typedTerm(Term,_VarsTypes, Term::Type) :-
  nonvar(Term),
  functor(Term,Symb,0),
  functor_signature(Symb,0,[],Type).
% functor (function or predicate) symbol applied to N>=1 terms
% Note: for lists [Funct|Args] instantiates to [[|],H|Tail]
term_typedTerm(Term,VarsTypes, TTerm::Type) :-
  compound(Term),
  functor(Term,Symb,Arity),
  Term =.. [Symb|Args],
  functor_signature(Symb,Arity,Sign,Type),
  typedTerms(Sign,TTerms),
  term_typedTermLst(Args,VarsTypes, TTerms),
  TTerm =..[Symb|TTerms].
%
typedLst(Type,[_::Type]).
typedLst(Type,[_::Type|TTerms]) :-
  typedLst(Type,TTerms).
%
typedTerms([Type],[_::Type]).
typedTerms([Type|Types],[_::Type|TTerms]) :-
  typedTerms(Types,TTerms).
%
term_typedTermLst([Term],VarsTypes,[TTerm]) :-
  term_typedTerm(Term,VarsTypes, TTerm).
term_typedTermLst([Term|Terms],VarsTypes,[TTerm|TTerms]) :-
  term_typedTerm(Term,VarsTypes, TTerm),
  term_typedTermLst(Terms,VarsTypes,TTerms).

% MODE: typedTerm_term(+TypedTerm, -Term).
% SEMANTICS: Term is the untyped version of TypedTerm
typedTerm_term(Term::_Type, Term) :-
  ( var(Term) ; ground(Term) ), !.
typedTerm_term([],[]).
typedTerm_term([TTerm|TTerms],[Term|Terms]) :-
  typedTerm_term(TTerm,Term),
  typedTerm_term(TTerms,Terms).
typedTerm_term(TTerm::_Type, Term) :-
  compound(TTerm),
  TTerm =.. [Pred|TArgs],
  typedTerm_term(TArgs, Args),
  Term =.. [Pred|Args].

% MODE: initial_VarsTypes(+Vars,-VarsTypes)
% SEMANTICS: VarsTypes is a list of elements of the form Var::Type where:
% Var is a variable occurring in Vars and Type is an anonymous variable.
initial_types([],[]).
initial_types([Var|Vars],[Var::_Type|VarsTypes]) :-
  initial_types(Vars,VarsTypes).

% MODE: user_defined_pred_first(+TermLstIn, TermLstOut)
% SEMANTICS: TermLstOut is a permutation of TermLstIn where all the N terms with
% a user defined predicate occur in the first N positions.
user_defined_pred_first(TermLst, [Term|STermLst]) :-
  select(Term,TermLst,TermLst1),
  functor(Term, Name,Arity),
  functor(Term1,Name,Arity),
  user_defined_pred(Term1),
  !,
  user_defined_pred_first(TermLst1, STermLst).
user_defined_pred_first(TermLst, TermLst).

% MODE: args_tuple(D,L)
% SEMANTICS: D is the disjunction of elements in the list L
disj_list((X;Xs),[X|Ys]) :-
  !,
  disj_list(Xs,Ys).
disj_list(X,[X]).

% MODE: sign_tuple(X,Y)
% SEMANTICS: Y is the tuple of types occurring in Y (without selectors)
sign_tuple([X],Y) :-
  normalize_sign(X,Y).
sign_tuple([X|Xs],(Y,Ys)) :-
  normalize_sign(X,Y),
  sign_tuple(Xs,Ys).

% Y is X without (if any) selector functor
normalize_sign(X,Y) :-
  is_type(X), !, X=Y.
normalize_sign(X,Y) :-
  arg(1,X,Y).

% MODE: var_type(+Var,+VarsTypes, Type)
% SEMANTICS: Type is the type of variable Var occurring in VarsTypes
% var_type(A,[B::T|_], T) :-  A==B.
var_type(A,[B::T|_], T1) :-
  A==B,
  unify_types(T,T1).
var_type(A,[_|V], T) :-
  var_type(A,V, T).

% MODE: arg_type(+N,+Atom, -Type)
% SEMANTICS: Type is the type of the N-th argument of Atom
arg_type(N,P,T) :-
  functor(P,Funct,Arity),
  functor_signature(Funct,Arity,Sign,bool),
  map_nth1(N,Sign,T).

%
user_defined_pred_mode(P,I,O1) :-
  functor_mode(P,I,O),
  ( O == [] -> O1=[true] ; O1=O ),
  !.
user_defined_pred_mode(P,_,_) :-
  functor(P,F,N),
  throw(undefined_mode(F/N)).

%
user_defined_pred_has_mode(P) :-
  functor_mode(P,_,_).

%
user_defined_pred_has_mode(P,I,O1) :-
  functor_mode(P,I,O),
  ( O == [] -> O1=[true] ; O1=O ).

% ------------------------------------------------------------------------------
%user:term_expansion((:- pred Signature), Clauses) :-
user:map_term_expansion((:- pred Signature), Clauses) :-
  ( ground(Signature) ->
    ( Signature =.. [Func|Sign], length(Sign,Arity) )
  ;
    throw(wrong_pred_sign(Signature))
  ),
  ( functor_signature(Func,Arity,Sign,bool) ->
    % throw(already_def_pred(Signature))
    % 2022-01-19: do not throw an exception if :- pred P occurs multiple times
    Clauses = []
  ;
    Clauses = [ types:functor_signature(Func,Arity,Sign,bool)
              , types:user_defined_pred(Signature)      ]
  ).

%
%user:term_expansion((:- type Name ---> Constructors), [ Clause|Clauses ]) :-
user:map_term_expansion((:- type Name ---> Constructors), [ Clause|Clauses ]) :-
  ( ( nonvar(Name), \+ \+ ( numbervars(Name, 0, _), ground(Constructors) ) ) ->
    % TODO: replace functor_signature(_Func,_Arity,_Sign,Name) with is_type(Name) ?
    ( functor_signature(_Func,_Arity,_Sign,Name) ->
      throw(already_def_type(Name))
    ;
      ( disj_list(Constructors,ConstructorList)
      , constructor_clauses(ConstructorList,Name,Clauses)
      , Clause = ( types:user_defined_type(Name) ) )
    )
  ;
    twrow(not_range_restricted(Name))
  ).
% utility predicate for map_term_expansion of ':- type'
constructor_clauses([],_Type, []).
constructor_clauses([Constructor|Constructors],Type, [Clause|Clauses]) :-
  Constructor=..[Name|Sign], length(Sign,Arity),
  Clause = ( types:functor_signature(Name,Arity,Sign,Type) ),
  constructor_clauses(Constructors,Type,Clauses).

%user:term_expansion((:- mode FuncSpec), Clauses) :-
user:map_term_expansion((:- mode FuncSpec), Clauses) :-
  ( ( compound(FuncSpec), FuncSpec =.. [Name|Spec], func_io(Spec,Args,I,O) ) ->
      % Spec is a list of 'in'/'out' terms; Args, I and O are lists of variables
      ( FuncArgs =.. [Name|Args],
        Clauses = [ types:functor_mode(FuncArgs,I,O) % e.g., functor_mode(p(I1,I2,O),[I1,I2],[O])
                  , types:functor_mode(FuncSpec) ] ) % e.g., functor_mode(p(in,out,in))
  ;
    throw(wrong_func_decl(FuncSpec))
  ).

user:map_term_expansion((:- fun FuncSpec), Clauses) :-
  ( ( compound(FuncSpec), FuncSpec =.. [Name|Spec], func_io(Spec,Args,I,O) ) ->
      ( FuncArgs =.. [Name|Args],

      %%% ASSUME: :- pred  Name  directive already  processed, thus functor_signature available
      functor_signature(Name,_Arity,FSignL,_Type),
      func_io(Spec,FSignL,_InTypes,OutTypes),

      length(OutTypes,OL),
      (OL > 1 ->
        (
          functor_output_type_name(Name,TName),
          Constructors =.. [TName|OutTypes],
          %%% TODO: refactor with code called in type directive
          disj_list(Constructors,ConstructorList)
        , constructor_clauses(ConstructorList,TName,Cls)
        , C = ( types:user_defined_type(TName) )
        , TypeClauses = [C|Cls]
         )
      ;
        TypeClauses = []
      ),

      Clauses = [ types:functor_fun(Name, FuncSpec, FuncArgs,I,O) | TypeClauses]

      )
  ;
    throw(wrong_func_fun(FuncSpec))
  ).

functor_output_type_name(Name,TName) :-
  atom_concat(Name,'outtype',TName).



functor_signature_io(F,InTypes,OutTypes) :-
  types:functor_signature(F,_Arity,FSignL,_Type),
  !,
  types:functor_fun(F, FMode, _,_,_),
  FMode =.. [F|FModeL],
  func_io(FModeL,FSignL,InTypes,OutTypes).


% MODE: type_constructors_def(+Type,-Defs)
% SEMANTICS: Defs is the list of constructors definitions of Type
type_constructors_def(Type,Defs) :-
  findall(functor_signature(Func,Arity,Sign,Type),
    functor_signature(Func,Arity,Sign,Type), Sigs),
  type_constructors_def_(Type,Sigs, Defs).
%
type_constructors_def_(_Type,[],[]).
type_constructors_def_(Type,[Def|Defs],[Atom|Atoms]) :-
  Def = functor_signature(Func,Arity,Sign,Type),
  functor(Atom,Func,Arity),
  Atom =.. [Func|Sign],
  type_constructors_def_(Type,Defs,Atoms).

% MODE: type_constructor_def(+Type,-Def)
% SEMANTICS: Def is a constructor definition of Type
type_constructor_def(Type,Def) :-
  functor_signature(Func,Arity,Sign,Type),
  functor(Def,Func,Arity),
  Def =.. [Func|Sign].

% MODE: type_constructors(+Type,-ConsLst)
% SEMANTICS: Defs is the list of constructors (Name/Arity) of Type
type_constructors(Type,ConsLst) :-
  findall(Name/Arity, type_constructor(Type,Name/Arity), ConsLst).

% MODE: type_constructor(+Type,-Cons)
% SEMANTICS: Defs is a constructor (Name/Arity) of Type
type_constructor(Type,Name/Arity) :-
  functor_signature(Name,Arity,_Sign,Type).

%
func_io([],[],[],[]).
func_io([IO|Spec],[Arg|Args],[Arg|InArgs],OutArgs) :-
  IO == in,
  !,
  func_io(Spec,Args,InArgs,OutArgs).
func_io([IO|Spec],[Arg|Args],InArgs,[Arg|OutArgs]) :-
  IO == out,
  func_io(Spec,Args,InArgs,OutArgs).


% P is a catamorphism on the N-th argument (P/A-N)
user:map_term_expansion((:- cata P/A-N), [ types:catamorphism(P/A,N) ]).

% catamorphic abstractions
user:map_term_expansion((:- cata_abs Type ==> Abs), [ types:cata_abs_def(Type,AbsL) ]) :-
  ( is_type(Type) ->
    ( catamorphic_abstraction(Type,Abs1) -> 
      throw(already_defined(:- cata_abs Type ==> Abs1))
    ; 
      conj_to_list(Abs,AbsL)
    )
  ; 
    throw(unknown_type(:- cata_abs Type ==> Abs))
  ).

catamorphic_abstraction(Type,Abs) :-
  cata_abs_def(Type,Abs).

user:map_term_expansion((:- spec Lhs ==> Rhs), [ types:progspec(Lhs,PL,QL) ]) :-
  ( Rhs = ( P => Q ) ->
    conj_to_list(Q,QL)
  ;
    ( Rhs = P, QL = [] )
  ),
  conj_to_list(P,PL).

% SEMANTICS: print a pred directive for each predicate occurring in the head of
% clauses in Cls and a type directive for each datatype used in those clauses
% show_types(Cls) :-
%   % signatures from Definitions
%   defs(NewDefs),
%   preds_in_hd_cls(NewDefs,[],DefPreds),
%   signs_preds_defs(DefPreds, Signs,Modes),
%   signs_dts(Signs,[], Datatypes),
%   show_datatypes(Datatypes),
%   ( Datatypes == [] -> true; nl ),
%   % signatures from the specialized program
%   preds_in_cls(Cls,[],Preds),
%   delete_chk(DefPreds,Preds,Preds1),
%   signs_preds_dts(Preds1, ISigns,IModes),
%   %%
%   show_signatures(ISigns), show_signatures(Signs),
%   nl,
%   show_modes(IModes), show_modes(Modes),
%   nl.
show_types(Cls) :-
  preds_in_cls(Cls,[],Preds),
  signs_preds_dts(Preds, Signs,Modes),
  signs_dts(Signs,[], Datatypes),
  ( Datatypes == [] -> true; (show_datatypes(Datatypes), nl) ),
  show_signatures(Signs), nl,
  show_modes(Modes), nl.

% MODE: signs_preds_dts(+Preds, -Signs,-Modes)
% SEMANTICS: collect signatures Signs from the initial program
signs_preds_dts([],[],[]).
signs_preds_dts([Pred|Preds],[Sign|Signs],Modes) :-
  Pred = Symb/Arity,
  Arity == 0,
  types:functor_signature(Symb,Arity,List,bool),
  !,
  Sign =.. [Symb|List],
  signs_preds_dts(Preds,Signs,Modes).
signs_preds_dts([Pred|Preds],[Sign|Signs],M) :-
  Pred = Symb/Arity,
  Arity >= 1,
  types:functor_signature(Symb,Arity,List,bool),
  !,
  Sign =.. [Symb|List],
  functor(Mode,Symb,Arity),
  % TODO: check if all functors have a mode
  ( types:functor_mode(Mode) -> M=[Mode|Modes] ; M=Modes ),
  % ----
  signs_preds_dts(Preds,Signs,Modes).
signs_preds_dts([Pred|_Preds],_Signs,_Modes) :-
  throw(unknown_signature(Pred)).

% MODE: signs_preds_defs(+Preds, -Signs,-Modes)
% SEMANTICS: collect signatures Signs from definitions
signs_preds_defs([],[],[]).
signs_preds_defs([Pred|Preds],[Sign|Signs],[Mode|Modes]) :-
  Pred = Symb/Arity,
  Arity >= 1,
  !,
  types:functor_signature(Symb,Arity,List,bool),
  Sign =.. [Symb|List],
  functor(Mode,Symb,Arity),
  types:functor_mode(Mode),
  signs_preds_defs(Preds,Signs,Modes).
signs_preds_defs([Pred|Preds],[Sign|Signs],Modes) :-
  Pred = Symb/Arity,
  Arity == 0,
  !,
  types:functor_signature(Symb,Arity,List,bool),
  Sign =.. [Symb|List],
  signs_preds_defs(Preds,Signs,Modes).
signs_preds_defs([_Pred|Preds],Signs,Modes) :-
  signs_preds_defs(Preds,Signs,Modes).

% MODE: signs_dts(+Signs,+DtIn, -DtOut)
% SEMANTICS: collect user-defined datatypes DtOut occurring
% in Signs (DtIn is the accumulator for DtOut)
signs_dts([],DtIn, DtIn).
signs_dts([Sign|Signs],DtIn, DtOut) :-
  dt(Sign,DtIn, DtIn1),
  signs_dts(Signs,DtIn1, DtOut).

% SEMANTICS: Sign is the signature of Cl
sign(Cl, Sign) :-
  clause_hd(Cl, H),
  functor(H,Pred,0),
  !,
  Sign=Pred.
sign(Cl, Sign) :-
  vs(smc_lang(cil)),
  !,
  clause_components(Cl, H,_,G),
  H =.. [Pred|A],
  copy_term((A,G),(CpyA,CpyG)),
  cil_term_variables_types(CpyG,VarsTypes),
  unify_args_with_types(CpyA,VarsTypes),
  Sign =.. [Pred|CpyA]. 
sign(Cl, Sign) :-
  vs(smc_lang(yul)),
  !,
  clause_components(Cl, H,_,_),
  H =.. [Pred|A],
  copy_term(A,CpyA),
  term_variables(CpyA,Vars),
  maplist(=(int),Vars),
  Sign =.. [Pred|CpyA].   
sign(Cl, Sign) :-
  clause_components(Cl, H,_,G),
  H =.. [Pred|A],
  copy_term((A,G),(CpyA,CpyG)),
  term_variables_types(CpyG::list(bool),VarsTypes),
  unify_args_with_types(CpyA,VarsTypes),
  Sign =.. [Pred|CpyA].
/*
% version that also considers constraints to deduce datatypes
sign(Cl, Sign) :-
  clause_components(Cl, H,C,G),
  H =.. [Pred|A],
  copy_term((A,C,G),(CpyA,CpyC,CpyG)),
  constr(CpyL,CpyC),
  append(CpyG,CpyL,CpyB),
  term_variables_types(CpyB::list(bool),VarsTypes),
  unify_args_with_types(CpyA,VarsTypes),
  Sign =.. [Pred|CpyA].
*/

% SEMANTICS: unify the variables in As with their types in V
unify_args_with_types([],_V).
unify_args_with_types([A|As],V) :-
  var(A),
  var_type(A,V,T),
  A=T,
  unify_args_with_types(As,V).
unify_args_with_types([A|As],V) :-
  nonvar(A),
  unify_args_with_types(As,V).
unify_args_with_types(_,_) :-
  map_error(write('Error while executing sign/2.')).


% SEMANTICS: remove constraints from the goals of CpyCl,
% thereby deriving a new clause whose boby consists of variables only
def_inputs([], Vars,Vars).
def_inputs([Goal|Goals],VarsIn, VarsOut) :-
  user_defined_pred_has_mode(Goal,_IArgs,OArgs),
  !,
  delete_chk(OArgs,VarsIn, VarsIn1),
  def_inputs(Goals,VarsIn1, VarsOut).
% NOTE: if user_defined_pred_has_mode fails, we assume that Goal has only inputs
def_inputs([_Goal|Goals],VarsIn, VarsOut) :-
  def_inputs(Goals,VarsIn, VarsOut).

% SEMANTICS: unify Goal with its mode
unify_args_with_modes([],[]).
unify_args_with_modes([],[out|O]) :-
  unify_args_with_modes([],O).
unify_args_with_modes([in|I],O) :-
  unify_args_with_modes(I,O).


% SEMANTICS: DtOut is the list of user-defined datatypes DtIn with the dataypes
% the signature Sign and not included in DtIn
dt(Sign,DtIn, DtOut) :-
  Sign =.. [_|Types],
  dt_(Types, DtIn, DtOut).

% SEMANTICS: dt ancillary perdicate that goes through the arguments of Sign
dt_([], DtIn, DtIn).
dt_([Type1|Types], DtIn, DtOut) :-
  user_defined_type(Type2), subsumes_chk(Type2,Type1),
  ( member(Type2,DtIn) -> DtIn1=DtIn ; DtIn1=[Type2|DtIn] ),
  !,
  dt_(Types, DtIn1, DtOut).
dt_([_Type|Types], DtIn, DtOut) :-
  dt_(Types, DtIn, DtOut).

% SEMANTICS: print type directives for user-defined datatypes
show_datatypes([]).
show_datatypes([Datatype|Datatypes]) :-
  type_constructors_def(Datatype,DatatypeDef),
  copy_term((Datatype,DatatypeDef),(CpyDatatype,CpyDatatypeDef)),
  numbervars((CpyDatatype,CpyDatatypeDef),0,_),
  write(':- type '), write(CpyDatatype),
  write(' ---> '), show_datatype_def(CpyDatatypeDef),
  write('.'), nl,
  show_datatypes(Datatypes).

% SEMANTICS: show_datatypes ancillary predicate
show_datatype_def([D]) :- !,
  write(D).
show_datatype_def([D|Ds]) :-
  write(D), write(' ; '),
  show_datatype_def(Ds).

% SEMANTICS: print pred directives for signatures
show_signatures([]).
show_signatures([Sign|Signs]) :-
  write(':- pred '), write(Sign), write('.'), nl,
  show_signatures(Signs).

% SEMANTICS: print mode directives for modes
show_modes([]).
show_modes([Mode|Modes]) :-
  write(':- mode '), write(Mode), write('.'), nl,
  show_modes(Modes).

% ------------------------------------------------------------------------------
% types
is_type(int).
is_type(bool).
is_type(real).
is_type(list(_)).
is_type(array(_)).
is_type(pair(_,_)).
is_type(tree(_)). % already def by user_defined_type ?
is_type(heap(_)). % already def by user_defined_type ?
is_type(X) :- nonvar(X), X=maptype(Y), is_type(Y).
is_type(X) :- user_defined_type(X).
% numbers
functor_signature(Num, 0, [ ], Type) :-
  number(Num), (Type = 'int';Type = 'real').
%
functor_signature('+', 2, [ Type, Type ], Type) :-
  member(Type, ['int','real','bool']). % Expr + Expr CLP(B) logical OR
functor_signature('*', 2, [ Type, Type ], Type) :-
  member(Type, ['int','real','bool']). % Expr * Expr CLP(B)	logical AND
functor_signature('-', 2, [ Type, Type ], Type) :-
  member(Type, ['int','real']).
functor_signature('/', 2, [ Type, Type ], Type) :-
  Type = 'real'.
functor_signature('div', 2, [ Type, Type ], Type) :-
  Type = 'int'.
functor_signature('mod', 2, [ Type, Type ], Type) :-
  Type = 'int'.
%
functor_signature('-', 1, [ Type ], Type) :-
  member(Type, ['int','real']).
%
functor_signature('=\\=', 2, [ Type, Type ], bool) :-
  member(Type, ['int','real','bool']).
functor_signature('=:=',  2, [ Type, Type ], bool) :-
  member(Type, ['int','real','bool']).
functor_signature('=<' ,  2, [ Type, Type ], bool) :-
  member(Type, ['int','real','bool']).
functor_signature('>=' ,  2, [ Type, Type ], bool) :-
  member(Type, ['int','real','bool']).
functor_signature('>'  ,  2, [ Type, Type ], bool) :-
  member(Type, ['int','real','bool']).
functor_signature('<'  ,  2, [ Type, Type ], bool) :-
  member(Type, ['int','real','bool']).
%
functor_signature('='  ,  2, [ Type, Type ], bool) :-
  is_type(Type).
functor_signature('#'  ,  2, [ Type, Type ], bool) :-
  is_type(Type).
% lists
functor_signature([],    0, [ ], list(_)).
functor_signature('[|]', 2, [ T, list(T) ], list(T)).  % '[|]' SWI Prolog syntax
% functor_signature('.',   2, [ T, list(T) ], list(T)). % '.' traditional lists
% arrays (array(TypeOfElements,Dimension))
functor_signature(read,  3, [ pair(array(A),int), int, A ], bool).
functor_signature(write, 4, [ pair(array(A),int), int, A,
                              pair(array(A),int)         ], bool).
% arrays SMTLIBv2
% functor_signature(select, 2, [ array(Type), int ], Type) :-
%   is_type(Type).
% functor_signature(store,  3, [ array(Type), int, Type], array(Type)) :-
%   is_type(Type).
% pairs
functor_signature(',', 2, [ A, B ], pair(A,B)).
% boolean constants
functor_signature(false, 0, [ ], bool). functor_signature(0, 0, [ ], bool).
functor_signature(true,  0, [ ], bool). functor_signature(1, 0, [ ], bool).
% boolean connectives
functor_signature('~', 1, [ Type ], Type) :-
  Type = 'bool'.
  functor_signature('not', 1, [ Type], Type) :-
  Type = 'bool'.
functor_signature('&', 2, [ Type, Type ], Type) :-
  Type = 'bool'.
  functor_signature('and', 2, [ Type, Type ], Type) :-
  Type = 'bool'.
    functor_signature('or', 2, [ Type, Type ], Type) :-
  Type = 'bool'.
functor_signature('v', 2, [ Type, Type ], Type) :-
  Type = 'bool'.
functor_signature('=>', 2, [ Type, Type ], Type) :-
  Type = 'bool'.
functor_signature(',', 2, [ Type1, Type2 ], bool) :-
  is_type(Type1), is_type(Type2).
functor_signature(';', 2, [ Type1, Type2 ], bool) :-
  is_type(Type1), is_type(Type2).
%
functor_signature('ite', 3, [ bool, Type, Type ], Type) :-
  member(Type, ['int','real','bool']).

% FF - for generating more readable examples using min/max instead of ite (if-then-else)
%functor_signature('min', 2, [ Type, Type ], Type) :-
%  member(Type, ['int','real']).
%functor_signature('max', 2, [ Type, Type ], Type) :-
%  member(Type, ['int','real']).

% atoms
functor_signature(Type, 0, [], maptype(Type)) :-
  is_type(Type).
functor_signature(Type, N, ListOfTypes, maptype(Type)) :-
  N >= 1,
  length(ListOfTypes,N),
  functor(PredType,Type,N),
  is_type(PredType),
  findall(X,(member(X,[maptype]),member(X,ListOfTypes)),ListOfTypes).

% SEMANTICS: is_cata(+Atom) holds if Atom is a catamorphism
is_cata(Atom) :-
  nonvar(Atom),
  functor(Atom,Name,Arity),
  catamorphism(Name/Arity,_).

% SEMANTICS: cata_on(+Atom,?Arg) holds if Atom is a catamorphism on Arg
cata_on(Atom,Arg) :-
  nonvar(Atom),
  functor(Atom,Name,Arity),
  catamorphism(Name/Arity,N),
  arg(N,Atom,Arg).

% SEMANTICS: show cata directive
show_cata :-
  catamorphism(Name/Arity,N),
  ( write(':- cata '), write(Name/Arity-N), write('.'), nl ),
  fail.
show_cata :-
  nl.  

% MODE: bnbvars(+VarType, -BVars,-NbVars)
% TYPE: bnbvars(list(var::type), list(var),list(var))
% SEMANTICS: -BVars,-NbVars are the list of variables of basic and nonbasic
% types, respectively, occurring in VarType
bnbvars([], [],[]).
%
bnbvars([Var::Type|VarTypes], [Var|BVars],NbVars) :-
  is_basic_type(Type),
  !,
  bnbvars(VarTypes, BVars,NbVars).
%
bnbvars([Var::_Type|VarTypes], BVars,[Var|NbVars]) :-
  bnbvars(VarTypes, BVars,NbVars).

% MODE: basic_type(?Type)
% TYPE: basic_type(atom)
% SEMANTICS: Type is a basic type
is_basic_type(int).
is_basic_type(bool).

% TODO: temporary solution to let constr to distinguish equalities of bool type
% from those of int/real type.
% fix_equalities([],_VarsTypes, []).
% fix_equalities([X=Y|Terms],VarsTypes, [X=:=Y|Terms1]) :-
%   var_type(X,VarsTypes,Type),
%   Type == bool,
%   !,
%   fix_equalities(Terms,VarsTypes, Terms1).
% fix_equalities([X=Y|Terms],VarsTypes, [X=:=Y|Terms1]) :-
%   var_type(Y,VarsTypes,Type),
%   Type == bool,
%   !,
%   fix_equalities(Terms,VarsTypes, Terms1).
% fix_equalities([Term|Terms],VarsTypes, [Term|Terms1]) :-
%   fix_equalities(Terms,VarsTypes, Terms1).

%
fix_equalities([],_VarsTypes,[]).
fix_equalities([X=Y|Eqs],VarsTypes,[X=:=Y|Esq1]) :-
  var_type(X,VarsTypes,Type),
  Type == bool,
  !,
  fix_equalities(Eqs,VarsTypes,Esq1).
fix_equalities([X=Y|Eqs],VarsTypes,[X=:=Y|Esq1]) :-
  var_type(Y,VarsTypes,Type),
  Type == bool,
  !,
  fix_equalities(Eqs,VarsTypes,Esq1).
fix_equalities([X=Y|Eqs],VarsTypes,[X=:=Y|Esq1]) :-
  ( X == true ; X == false ; Y == true ; Y ==false ),
  !,
  fix_equalities(Eqs,VarsTypes,Esq1).
fix_equalities([Eq|Eqs],VarsTypes,[Eq|Esq1]) :-
  fix_equalities(Eqs,VarsTypes,Esq1).

% MODE: add_hd_pred_sign(+Cl)
% SEMANTICS: derive the signature of the head predicate of Cl and
% add it to the database
add_hd_pred_sign(Cl) :-
  types:sign(Cl, Sign),
  add_pred_sign(Sign).
% MODE: add_pred_sign(+Sign)
% SEMANTICS: add the signature to the database
add_pred_sign(Sign) :-
  Sign =..[F|Args], length(Args,N),
  assertz(types:functor_signature(F,N,Args,bool)),
  assertz(types:user_defined_pred(Sign)).
% MODE: add_hd_pred_mode(+Cl)
% SEMANTICS: derive the mode of the head predicate of Cl and
% add it to the database
add_hd_pred_mode(Cl) :-
  clause_hd(Cl, Head),
  copy_term(Head,CpyHead),
  ( types:functor_mode(CpyHead) ->
    true
  ;
    ( types:mode(Cl, Mode), add_pred_mode(Mode) )
  ).
% MODE: mode(+Cl)
% SEMANTICS: Mode is the mode of Cl's head
mode(Cl, Mode) :-
  copy_cl(Cl, CpyCl),
  clause_components(CpyCl, Mode,_C,Goal),
  term_variables(Mode,Vars),
  def_inputs(Goal,Vars,In),
  delete_chk(In,Vars,Out),
  unify_args_with_modes(In,Out).

% MODE: add_pred_mode(+FuncSpec)
% SEMANTICS: FuncSpec is a compound term whose arguments are in/out terms
% add_pred_mode asserts functor_mode(FuncSpec) and functor_mode(FuncArgs,I,O)
% where FuncArgs is the nonground version of FuncArgs where in and out terms
% have been replaced by variables in I and O
add_pred_mode(FuncSpec) :-
  ground(FuncSpec),
  FuncSpec =.. [Name|Spec],
  func_io(Spec,Args,I,O),
  !,
  FuncArgs =.. [Name|Args],
  assertz(types:functor_mode(FuncSpec)),
  assertz(types:functor_mode(FuncArgs,I,O)).
add_pred_mode(FuncSpec) :-
  throw(wrong_func_mode(FuncSpec)).
% MODE: add_pred_mode(+Pred,+I,+O)
% SEMANTICS: Pred is a predicate of arity N applied to N variables;
% each variable in Pred occurs either in I or in O
% add_pred_mode/3 asserts functor_mode(Pred,I,O) and functor_mode(FuncSpec),
% where 
add_pred_mode(Pred,I,O) :-
  Pred=..[_|Args],
  distinct_vars(Args), % Args is a list of distinct variables
  vars_subset(I,Args),
  vars_subset(O,Args),
  intersection_vars_empty(I,O),
  !,
  assertz(types:functor_mode(Pred,I,O)),
  copy((Pred,I,O),(CpyPred,CpyI,CpyO)),
  unify_args_with_modes(CpyI,CpyO),
  assertz(types:functor_mode(CpyPred)).
add_pred_mode(Pred,I,O) :-
  throw(wrong_func_mode(Pred,I,O)).

% --- progspec/[3,5] manipulation predicates ---

% SEMANTICS: Prog ==> Pre => Post
:- dynamic progspec/3.
prog_spec(Prog, Pre,Post) :-
  progspec(Prog, Pre,Post).

% SEMANTICS: Prog ==> (PreConstr,PreAtoms) => (PostConstr,PostAtoms)
:- dynamic progspec/5.
prog_spec(Prog, PreConstr,PreAtoms,PostConstr,PostAtoms) :-
  progspec(Prog, PreConstr,PreAtoms,PostConstr,PostAtoms).

% SEMANTICS: assert/retract program specifications
:- dynamic updated_prog_spec/1.
assert_prog_spec(Prog, Pre,Post) :-
  % take not of the update
  functor(Prog,F,N), 
  ( updated_prog_spec(F/N) -> 
    true
  ; 
    assert(updated_prog_spec(F/N)) 
  ),
  assert(progspec(Prog, Pre,Post)).
assert_prog_spec(Prog, PreConstr,PreAtoms,PostConstr,PostAtoms) :-
  % take not of the update
  functor(Prog,F,N), 
  ( updated_prog_spec(F/N) -> 
    true
  ; 
    assert(updated_prog_spec(F/N)) 
  ),
  assert(progspec(Prog, PreConstr,PreAtoms,PostConstr,PostAtoms)).
%
retract_prog_spec(Prog) :-
  retractall(progspec(Prog, _,_)),
  retractall(progspec(Prog, _,_,_,_)).

% SEMANTICS: update the program contract of Prog
update_prog_spec(Prog, PreConstr,PreAtoms,PostConstr,PostAtoms) :-
  PostAtoms == [],
  constr_tt(PostConstr),
  !,
  map_log(finest,write('update_prog_spec: ')),
  ( prog_spec(Prog, OldPreConstr,OldPreAtoms,OldPostConstr,OldPostAtoms) ->
    ( % diff_catas(+G1,+G2, -G1Only,-G2Only),
      % G1Only = catas in G1 not in G2; G2Only = catas in G2 not in G1
      diff_catas(PreAtoms,OldPreAtoms, PreAtomsOnly,_OldPreAtomsOnly),
      ( PreAtomsOnly == [] ->
        map_log(finest,(write('Nothing new on '), atom_pred(Prog,Pred), write(Pred), nl, nl))
      ; 
        ( map_log(finest,(write('Updating spec of '), atom_pred(Prog,Pred), write(Pred), nl, nl)),
          show_spec('Old-spec',progspec(Prog, OldPreConstr,OldPreAtoms,OldPostConstr,OldPostAtoms)),
          % retract old contract
          retract_prog_spec(Prog),
          % update PreConstr
          term_variables((OldPreConstr,OldPreAtoms,OldPostConstr,OldPostAtoms),OldSpecVars),
          constr_solve(PreConstr,OldSpecVars,PreConstrProj),
          ( constr_imp(PreConstrProj,OldPreConstr) ->
            constr_and(OldPreConstr,PreConstr,NewPreConstr)
          ;
            NewPreConstr = OldPreConstr
          ),
          % update PreAtoms
          append(OldPreAtoms,PreAtomsOnly,NewPreAtoms),
          propagate_cata_interpreted_atom(Prog,NewPreAtoms, AddPreConstr,ExtPreAtoms,AddPostConstr),
          constr_and(NewPreConstr,AddPreConstr,ExtPreConstr),
          constr_and(OldPostConstr,AddPostConstr,ExtPostConstr),
          % assert updated Pre
          assert_prog_spec(Prog, ExtPreConstr,ExtPreAtoms,ExtPostConstr,OldPostAtoms),
          show_spec('NEW-spec',progspec(Prog, ExtPreConstr,ExtPreAtoms,ExtPostConstr,OldPostAtoms))
        )
      )
    )    
  ; % no contract
    ( map_log(finest,write('No spec found. ')),
      ( ( constr_tt(PreConstr), PreAtoms==[] ) -> % nothing new on this spec
          map_log(finest,(write('Nothing new on '), atom_pred(Prog,Pred), write(Pred), nl, nl))
      ; % asserting new computed Pre and Post (true) 
        ( map_log(finest,(write('Adding spec of '), atom_pred(Prog,Pred), write(Pred), nl, nl)),
          propagate_cata_interpreted_atom(Prog,PreAtoms, AddPreConstr,ExtPreAtoms,AddPostConstr),
          constr_and(PreConstr,AddPreConstr,ExtPreConstr),
          constr_and(PostConstr,AddPostConstr,ExtPostConstr),
          assert_prog_spec(Prog, ExtPreConstr,ExtPreAtoms,ExtPostConstr,PostAtoms),
          show_spec('NEW-spec',progspec(Prog, ExtPreConstr,ExtPreAtoms,ExtPostConstr,PostAtoms))
        )
      )
    )
  ).  
update_prog_spec(Prog, _PreConstr,_PreAtoms,_PostConstr,_PostAtoms) :-
  map_warning((write('update_prog_spec: unsupported Post Constr/Atoms'),
               atom_pred(Prog,Pred), write(Pred), nl, nl)).

% SEMANTICS: update program contracts of program atoms occurring in Cl
update_prog_spec(Cl) :-
  clause_components(Cl, _,C,G),
  program_functions_blocks(G, Blocks), % predicates annotated with ignore are placed in a block
  update_prog_spec_aux(C,Blocks).
%
update_prog_spec_aux(_,[]).
update_prog_spec_aux(C,[Blk|Blks]) :-
  progfun_catas(Blk, Prog,Catas),
  functor(Prog,F,N),
  \+ vs(ignore_pred(F/N)),
  !,
  constr_vars(C,CVars),
  copy_term((Prog,Catas,CVars),(CpyProg,CpyCatas,CpyCVars)),
  constr_copy(C,CpyC),
  % unify CpyCVars with those of CpyC
  constr_vars(CpyC,CpyCVars), 
  % PreConstr
  %term_variables(CpyCatas,Vars),
  io_vars(CpyCatas,IVars,_OVars), IVars=Vars,
  constr_solve(CpyC,Vars,PreConstr),
  % PreAtoms
  PreAtoms = CpyCatas,
  % PostConstr
  constr_tt(PostConstr),
  % PostAtoms
  PostAtoms = [],
  update_prog_spec(CpyProg, PreConstr,PreAtoms,PostConstr,PostAtoms),
  update_prog_spec_aux(C,Blks).
update_prog_spec_aux(C,[_Blk|Blks]) :-  
  % _Blk is either a block including a predicate annotated with ignore
  % or a block that consists of catamorphisms only 
  update_prog_spec_aux(C,Blks).

%
io_vars(Goal,IVars,OVars) :-
  io_vars(Goal,[],[],IVars,OVars).
%
io_vars([],IVars,OVars,SIVars,SOVars) :-
  sort(IVars,SIVars),
  sort(OVars,SOVars).
io_vars([A|Gs],IVarsIn,OVarsIn,IVarsOut,OVarsOut) :-
  user_defined_pred_mode(A,I,O),
  term_variables(I,IVars), append(IVarsIn,IVars,IVarsIn1),
  term_variables(O,OVars), append(OVarsIn,OVars,OVarsIn1),
  io_vars(Gs,IVarsIn1,OVarsIn1,IVarsOut,OVarsOut).

% SEMANTICS: write spec of Prog
show_prog_spec(Prog) :-
  prog_spec(Prog, PreConstr,PreAtoms,PostConstr,PostAtoms),
  show_prog_spec(Prog,PreConstr,PreAtoms,PostConstr,PostAtoms).
%
show_prog_spec(Prog,PreConstr,PreAtoms,PostConstr,PostAtoms) :-
  constr(PreConstrTerm,PreConstr),
  constr(PostConstrTerm,PostConstr),
  copy_term( (Prog,PreConstrTerm,PreAtoms,PostConstrTerm,PostAtoms),
             (CpyProg, CpyPreConstrTerm,CpyPreAtoms,CpyPostConstrTerm,CpyPostAtoms)),
  numbervars((CpyProg, CpyPreConstrTerm,CpyPreAtoms,CpyPostConstrTerm,CpyPostAtoms)),
  write(':- spec '), 
  write(CpyProg),
  write(' ==>'), nl,
  append(CpyPreConstrTerm,CpyPreAtoms,PreLst),
  list_to_conj(PreLst,Pre),
  write('        '), write(Pre), nl,
  write('          => '),
  append(CpyPostConstrTerm,CpyPostAtoms,PostLst),
  ( PostLst == [] ->
    write(constr(true))
  ;
    ( list_to_conj(PostLst,Post), write(Post) )
  ),
  write('.'), nl.

% SEMANTICS: write all spec(s)
show_prog_spec :-
  prog_spec(Prog, PreConstr,PreAtoms,PostConstr,PostAtoms),
  show_prog_spec(Prog,PreConstr,PreAtoms,PostConstr,PostAtoms),
  nl,
  fail.
show_prog_spec.   

updated_prog_spec :-
  updated_prog_spec(_).

%
propagate_cata_interpreted_atom(Atom,Catas, PreConstr,NewCatas,PostConstr) :-
  Atom=eq(X,Y),
  !,
  map_log(finest,(write('propagate_cata_interpreted_atom: extending spec of eq/2'), nl, nl)),
  propagate_cata_interpreted_atom(Catas,Catas,[X,Y],Catas,[],[], NewCatas,PreEqs,PostEqs),
  constr(PreEqs,PreConstr),
  constr(PostEqs,PostConstr).
propagate_cata_interpreted_atom(_Atom,Catas, PreConstr,Catas,PostConstr) :-
  constr_tt(PreConstr),
  constr_tt(PostConstr).

%
propagate_cata_interpreted_atom([],_AllCatas,_Vars,NewCatas,PreEqs,PostEqs, NewCatas,PreEqs,PostEqs).
propagate_cata_interpreted_atom([Cata|Catas],AllCatas,Vars,NewCatas1,PreEqs1,PostEqs1, NewCatas,PreEqs,PostEqs) :-
  cata_on(Cata,CataVar),
  user_defined_pred_mode(Cata, I1,O1),
  propagate_cata_interpreted_atom_aux(Vars,AllCatas,Cata,CataVar,NewCatas1,I1,O1, NewCatas2,I2,O2),
  term_variables_types(Cata::bool, VarsTypes),
  eq_lst(I2,IEqs), fix_equalities(IEqs,VarsTypes,NewPreEqs), append(PreEqs1,NewPreEqs,PreEqs2),
  eq_lst(O2,OEqs), fix_equalities(OEqs,VarsTypes,NewPostEqs), append(PostEqs1,NewPostEqs,PostEqs2), 
  propagate_cata_interpreted_atom(Catas,AllCatas,Vars,NewCatas2,PreEqs2,PostEqs2, NewCatas,PreEqs,PostEqs).

%
propagate_cata_interpreted_atom_aux([],_AllCatas,_Cata,_CataVar,NewCatas,I,O, NewCatas,I,O).
propagate_cata_interpreted_atom_aux([V|Vs],AllCatas,Cata,CataVar,NewCatas1,CI1,CO1, NewCatas,CI,CO) :-
  copy_term((Cata,CataVar), (CpyCata,CpyCataVar)),
  ( exists_cata_on(CpyCata,CpyCataVar,V,AllCatas) ->
    ( 
      I=[], O=[], 
      NewCatas2 = NewCatas1 
    )
  ;
    ( V=CpyCataVar, % making Cata and its copy working on the same nonbasic var
      user_defined_pred_mode(CpyCata, IwV,O), select_chk(V,IwV,I),
      NewCatas2 = [CpyCata|NewCatas1]
    )
  ),
  append(I,CI1,CI2), append(O,CO1,CO2),
  propagate_cata_interpreted_atom_aux(Vs,AllCatas,Cata,CataVar,NewCatas2,CI2,CO2, NewCatas,CI,CO).

%
exists_cata_on(CpyCata,CpyCataVar,V,AllCatas) :-
  member(CpyCata,AllCatas),
  V == CpyCataVar.  

%
eq_lst([],[]).
eq_lst([_],[]).
eq_lst([V1,V2|Vs],[V1=V2|Eqs]) :-
  eq_lst(Vs,Eqs).