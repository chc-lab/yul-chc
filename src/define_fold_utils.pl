:- module(define_fold_utils,
    [ define_fold/4
    , def/1
    , defs/1
    , ancestor_def/2
    , ancestor_defs/2
    , parent_def/2
    , source_def/2
    , num_defs/1
    , add_def/2
    , add_defs/2
    , rem_def/1
    , more_general_def/3
    , reinitialize_definitions_DB/0
    ]).

%===============================================================================
% DEFINE_FOLD SUBSIDIARY STRATEGY
%-------------------------------------------------------------------------------

% MODE: define_fold(+ClsSel2,+Defs_in, -FoldedCls,-Defs_out,-NewDefs_out)
% TYPE: define_fold(list(clause2),clause_tree,list(clause),clause_tree,list(clause))
% SEMANTICS:
% - FoldedCls is the list of clauses obtained by folding all clauses in Cls wrt
%   foldable literals by using definition clauses in Defs_in or
%   by introducing the new definition clauses NewDefs_out
% - Defs_out = Defs_in U NewDefs_out
define_fold([],NewDefs, [],NewDefs).
% there exists some atom to be folded
define_fold([Cl|Cls],NewDefsIn, [FCl|FCls],NewDefsOut) :-
  % partition Cl's goal into blocks
  folding_selection(Cl,ClSel2),
  !,
  map_log(finest,
    ( write(' -running repeat define & fold on: '), nl, show_clsel2(ClSel2), nl )),
  % fold each block
  repeat_define_fold(ClSel2,NewDefsIn, FClSel2,NewDefsIn1),
  map_log(finest, ( write(' -repeat define & fold completed-'), nl )),
  csel2_to_clause(FClSel2,FCl),
  define_fold(Cls,NewDefsIn1, FCls,NewDefsOut).
% there is no atom to be folded (e.g. Cl is a constrained fact)
define_fold([Cl|Cls],NewDefsIn, [Cl|FCls],NewDefsOut) :-
  map_log(finest,
    ( write(' - nothing to be folded here - '), nl, show_cl(Cl), nl,nl)),
  define_fold(Cls,NewDefsIn, FCls,NewDefsOut).

% MODE: repeat_define_fold(+Cls,+Defs_in,+NewDefs_in, -FoldedCls,-Defs_out,-NewDefs_out)
% TYPE: repeat_define_fold(list((clsel2,clause)), clause_tree, list(clause),clause_tree,list(clause))
% SEMANTICS:
% - Cls is a list of pairs of the form (ClSel,Cl), where Cl is the candidate
%   definition for folding ClSel wrt the literals selected via Fselection
% - FoldedCls is the list of clauses obtained by folding all ClSel using a
%   definition clauses in Defs_in or by introducing a list, say NewDefs,
%   of new definition clauses
% - NewDefs_out = NewDefs U NewDefs_in
% - Defs_out = Defs_in U NewDefs_out
% if there is no partition of atoms to be folded
repeat_define_fold(ClSel2,NewDefs, ClSel2,NewDefs) :-
  clsel2_bd_2nd_goal(ClSel2,[]).
% else define & fold
repeat_define_fold(ClSel2In,NewDefsIn, FClSel2,NewDefsOut) :-
  % get a definition for folding
  candidate_def(ClSel2In, CDef),
  define_clause(ClSel2In,NewDefsIn,CDef, ClSel2In1,NewDefsIn1,Def),
  % apply folding
  fold_clause(ClSel2In1,Def, ClSel2In2),
  repeat_define_fold(ClSel2In2,NewDefsIn1, FClSel2,NewDefsOut).


% MODE: define_clause(+ClSel2,+DefsIn, -Def,-DefsOut)
% SEMANTICS: Given
%  - ClSel2In is the clause to be folded
%  - DefsIn is the set of definitions introduced so far by the transformation
% define_clause produces
% - ClSel2Out is the clause to be folded possibly changed by more_general_def
% - DefsOut = DefsIn U NewDefsOut
% - NewDefsOut = NewDefsIn U {Def} if Def is a new definition
% - Def is the definition for folding
%% (-OLDDEF-)
define_clause(ClSel2In,NewDefsIn,CDef, ClSel2Out,NewDefsOut,DefP) :-
  map_log(finest,(write('[Looking for a MORE GENERAL definition]'), nl, nl)),
  def(Def),
  map_log(debugging,(write(' -testing folding- '), nl, show_cl(Def), nl)),
  more_general_def(Def,CDef, DefP),
  !,
  ClSel2In = ClSel2Out,
  NewDefsIn = NewDefsOut.
%% (-NEWDEF-)
define_clause(ClSel2In,NewDefsIn,CDef, ClSel2Out,NewDefsOut,Def) :-
  map_log(finest,(write(' -useful definition NOT found- '),         nl, nl)),
  newdef_from_tbf_def(ClSel2In,CDef, ClSel2Out,Def,NewDefs),
  append(NewDefs,NewDefsIn,NewDefsOut).
%  NewDefsOut = [NewDef|NewDefsIn].
%% (-NEWDEF-)
define_clause(ClSel2In,NewDefsIn,CDef, ClSel2In,NewDefsOut,Def) :-
  Def = CDef,
  source_def(ClSel2In,ParDef),
  add_def(Def,ParDef),
  map_log(finest,(write(' -useful ancestor NOT found- '), nl, nl,
                  write('[Introducting NEW definition]'), nl, nl,
                  write(' -newdef- '), nl, show_cl(Def),      nl)),
  !,
  NewDefsOut = [Def|NewDefsIn].
%
define_clause(ClSel2In,_NewDefsIn,_CDef, _ClSel2Out,_NewDefsOut,_Def) :-
  map_error((write('Failure in generating a definition from '), nl,
           write(' '), show_clsel2(ClSel2In))).


% MODE: fold_clause(+ClSel2,+Def, -FClSel2)
% TYPE: fold_clause(clause_sel,clause,clause_sel)
% SEMANTICS: FClSel2 is the result of folding ClSel2 using Def
fold_clause(ClSel2,Def, FClSel2) :-
  map_log(finest,(write('[Folding]'),  nl, nl,
                  show_clsel2(ClSel2), nl,
                  write('using:'),     nl,
                  show_cl(Def),        nl)),
  % get a copy CpyClSel2 of ClSel2
  copy_clsel2(ClSel2,CpyClSel2), clsel2_components(CpyClSel2, H,C1,Ls,[Tbf|Rs]),
  % get a copy CpyDef of Def and unify its atoms with Tfb (atoms to be folded)
  copy_cl(Def,CpyDef),           clause_components(CpyDef,    A,_C,Tbf),
  % append the head A of CpyDef to Ls (atoms no longer considered for folding)
  append(Ls,[A],LsA),            clsel2_components(FClSel2,   H,C1,LsA,    Rs ),
  !,
  map_log(finest,(write(' -result- '), nl, show_clsel2(FClSel2), nl, nl)).
%
fold_clause(_Cl,_Def,_FoldedCl) :-
  map_error(write('Something went wrong while folding.')).

% ------------------------------------------------------------------------------
% MODE: max_def_ID(?ID)
% SEMANTICS: ID is the identifier of the last introduced definition clause
:- dynamic max_def_ID/1.
max_def_ID(0).


root(Cl) :-
  constr_tt(C),
  clause_components(Cl, root,C,[]).


% MODE: def(?ID,?Cl)
% SEMANTICS: Cl is a clause definition idenfied by ID
:- dynamic def/2.


% MODE: def(Cl)
% SEMANTICS: Cl is a clause definition
def(Cl) :- def(_,Cl).


%
defs(Defs) :- findall(Cl,def(Cl),Defs).


% MODE: source_def(?Cl, ?Def)
% SEMANTICS: Def is a clause definition having the same head predicate of Cl
source_def(Cl, Par) :-
  hd_pred(Cl, P/N),
  hd_pred(Par,P/N),
  def(_,Par),
  !.
source_def(_Cl, Par) :-
  root(Par).


% MODE: ancestor_def(?Des,?Anc)
% SEMANTICS: Anc and Des be two clause definition and Anc is an ancestor of Des
ancestor_def(Des,Anc) :-
  def(DesID,Des),
  ancestorID(DesID,Anc).
%
ancestorID(DesID,Cl) :-
  parentID(DesID,ParID),
  def(ParID,Cl).
ancestorID(DesID,Cl) :-
  parentID(DesID,ParID),
  ancestorID(ParID,Cl).


% MODE: ancestor_defs(?Def,?Ancs)
% SEMANTICS: Ancs is the list of ancestors of Def
ancestor_defs(Def,[Anc|Ancs]) :-
  ancestor_def(Def,Anc),
  !,
  ancestor_defs(Anc,Ancs).
ancestor_defs(_Def,[]).


% MODE: parent_def(?Def1,?Def2)
% SEMANTICS: Def2 is the parent definition of Def1
parent_def(Def1,Def2) :-
  def(ID1,Def1),
  def(ID2,Def2),
  parentID(ID1,ID2).


% MODE: num_defs(?N)
% SEMANTICS: N is the number of definitions in the database
num_defs(N) :-
  max_def_ID(N).


% MODE: add_def(+NewDef,+ParDef)
% SEMANTICS: add the new definition NewDef as a children of ParDef
:- dynamic parentID/2.
add_def(NewDef,ParDef) :-
  retract(max_def_ID(OldID)),
  NewID is OldID + 1,
  assertz(max_def_ID(NewID)),

  assertz(def(NewID,NewDef)),

  ( def(ParID,ParDef) -> true ; ParID = 0 ),
  assertz(parentID(NewID,ParID)),
  % sign and type
  ( vs(many_sorted_CHCs) ->
    ( add_hd_pred_sign(NewDef), add_hd_pred_mode(NewDef) )
  ;
    true
  ).
%
add_defs([],_ParDef).
add_defs([NewDef|NewDefs],ParDef) :-
  add_def(NewDef,ParDef),
  add_defs(NewDefs,ParDef).

rem_def(DefHd) :-
  copy_term(DefHd,CpyDefHd),
  clause_hd(Def,CpyDefHd),
  retract(def(_,Def)).

% ------------------------------------------------------------------------------
% from transformation_strategy.pl
%more_general_def((H1,bd(Cns1,A1)),(H2,bd(Cns2,A2))) :-
%    variant(A1,A2),
%    A1=A2,
%    entails(Cns2,Cns1),
%    term_variables(H1,Vars1),
%    term_variables(H2,Vars2),
%    subset_chk(Vars2,Vars1).


% MODE: more_general_def(+Gen,+Spe, -GenP)
% TYPE: more_general_def(clause,clause, clause)
% SEMANTICS: Let Gen be a definition of the form H1(X) :- c1, G1. and Spe be
% a definition of the form H2(Y) :- c2, G2. without variables in common and
% where X (Y) is a tuple of distinct variables occurring in G1 (G2).
% GenP is a clause of the form H1 :- c1, P1. where:
% - there exists a permutation P1 of G1 s.t. G2 = (P1)theta
% - theta does not bound the existential variables of Generic
% - the variables in H2 are a subset of those in (H1)theta
% - the constraint c2 -> (c1)theta

more_general_def(Gen,Spe, GenP) :-

  clause_components(Gen, H1,C1,G1),
  clause_components(Spe, H2,C2,G2),

  % there exists a permutation P1 of G1 (Generic) s.t. exists theta. P1 theta = G2
  more_general_goal(G1,G2, P1),

  copy_term((H1,P1),(CpyH1,CpyP1)),
  % apply theta to CpyH1 and P1
  CpyH1 = H1,
  P1 = G2,

  ( vs(folding(iff,_)) ->
    (P1 =@= CpyP1) % theta does not bound the existentials of Generic
  ;
    true
  ),

  % vars(H2) theta \subseteq vars(H1)
  term_variables(H1, Vars1), % H1 = CpyH1 theta
  term_variables(H2, Vars2),
  subset_chk(Vars2,Vars1),

  % C2 -> C1 theta
  constr_imp(C2,C1),

  clause_components(GenP, H1,C1,P1).

%
reinitialize_definitions_DB :-
  map_log(finest,(write('  *** Reinitializing definitions database ***  '), nl, nl)),
  max_def_ID(N),
  map_log(finest,(write('Removing the '), write(N), write(' definitions generated so far:'), nl)),
  defs(Defs), 
  show_cls(Defs), 
  retractall(def(_,_)),
  retractall(parentID(_,_)).
