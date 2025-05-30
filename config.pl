:- dynamic vs/1.
:- discontiguous v_setting/1.

%===============================================================================
:- ( is_set_env('MAP_DIR') ->
     true
   ;
     map_warning(write('\'MAP_DIR\' environment variable is not set.'))
   ).

:- multifile file_search_path/2.
:- discontiguous file_search_path/2.

file_search_path(solver,'lib/solvers').
file_search_path(solver,Abs) :-
  map_getenv('MAP_DIR',Base),
  atom_concat(Base,'/bin/solvers',Abs).

% search paths for load_files used to load the theory of arrays
file_search_path(theories,'lib/solvers/theories').
file_search_path(theories,'bin/solvers/theories').

file_search_path(transformer,Abs) :-
  map_getenv('MAP_DIR',Base),
  atom_concat(Base,'/src',Abs).

file_search_path(library,Abs) :-
  map_getenv('MAP_DIR',Base),
  atom_concat(Base,'/ext',Abs).
file_search_path(library,'/usr/local/lib/ppl').
file_search_path(library,'/usr/lib/x86_64-linux-gnu/ppl').

% basic strategies
file_search_path(strategy,   'lib/').
% % yul
file_search_path(interpreter,'lib/yul/interpreters/').
file_search_path(strategy,   'lib/yul/strategies/').
% map2other
file_search_path(strategy,   'lib/map2other/strategies/').

%===============================================================================

vs_msg :-
    default_settings, nl,
    write('current verification settings:'), nl,
    svs, nl,
    write('cvs to change settings.'), nl,
    write('svs to show current settings.'), nl, nl.


default_settings :-
    retractall(vs(_)),

    v_setting(csvfile('invchkspec_stats.csv')),
    v_setting(log_stream(user_output)),

    %assert(get_transformer_option(inprog_invokable,_N1/_A1:false)),
    %assert(get_transformer_option(inprog_canonical_conversion,_N2/_A2:true)),

    %assert(get_transformer_option(inprog_invokable,_N1/_A1:true)),
    %assert(get_transformer_option(inprog_canonical_conversion,_N2/_A2:false)),

    % unfolfing
    v_setting(unfolding(depth)),

    % definition
    v_setting(new_name_functor_basenames(std)),
    v_setting(use_deftree(yes)),

    % new definition ------------------------------
    % candidate
    v_setting(candidate_def_head(var)),
    v_setting(candidate_def_cns(projection)),
    % generalization
    v_setting(widen(plain)),
    v_setting(delayed_generalization(0,plain)),
    v_setting(def_variants(polyvariant)),
    % differential predicates
    v_setting(diffpred(on)),

    % post_unfolding
    v_setting(post_unfolding_lits(plain)),

    % folding
    v_setting(folding(iff,variant)),

    v_setting(spec(svcomp)),

    % output verbosity and format default settings
    v_setting(verbosity(3)),  % be quite silent
    v_setting(print(pretty)), % print clauses without rat terms

    v_setting(csv_usrdef),

    v_setting(solver(paqr)),

    %v_setting(observables(all,intersection)),
    v_setting(observables(indices,intersection)),

    apply_sig.  % standard post generalization operations


cvs :-
    write('choose among the following settings:'),
    findall(A,clause(v_setting(A),_),Settings),
    nl,write(Settings),nl,
    read(S),
    v_setting(S).


print_vs([]).
print_vs([Setting|T]) :-
    nl, write(Setting),
    print_vs(T).


svs :-
    findall(A,vs(A),Settings),
    %nl,write(Settings),nl.
    write('Verification settings:'), nl,
    print_vs(Settings), nl.


svsf :-
    default_settings, nl,
    v_setting(solver('rat_solver')),
    (yesno('Would you like to select a configuration file', n) ->
      (msg_enter_name_configuration(File), compile(File))
    ;
      (nl, write('* Loading the default solver: '), vs(solver(X)), write(X), write(' *'), nl, nl)
    ),
    flush_output(user_output),
    load_solver.


%===============================================================================
% Configuration options (v_setting)

/*
 --- 1.  prog_maxcoeff
 --- 2.  less_cl
 --- 3.  gen
 4.  widen
 --- 5.  gen_prologue
 6.  candidate_def_head
 7.  candidate_def_cns
 --- 8.  candidate_def_lits
 --- 9.  partition
 --- 10. partition_foldable
 --- 11. candidate_partition
 --- 12. post_folding
 --- 13. post_unfolding
 14. specialize
 --- 15. specmode
 --- 16. keep_regions
 17. delayed_generalization
 --- 18. undfold_wqo
 19. smc_lang
 20. use_deftree
 21. input_filename
 22. output_filename
 23. prop
 --- 24. interpreter
 --- 25. spec_straty
 26. theories
 --- 27. folding
 28. verbosity
 29. print
 30. unf
 --- 31. skip_generalization
 --- 32. branching_preserving
 --- 33. region_source
 34. goal_replacement
 35. annotated_vcs
 36. observables
 37. post_spec
 --- 38. reachability_rel
 39. max_UDF_iterations
 40. solver
 --- 41. interactive_gen
 --- 42. interactive_def
 --- 43. interactive_mgd
 --- 44. specmap2dot
 --- 45. deftree2dot
 --- 46. candidate_def_array
 47. halt_on_cfact
 --- 48. split_ids
 49. unfolding
 --- 50. vcs_stats
 51. do_not_auto_set_global_vars
 52. new_name_functor_basenames
 53. specfile
 54. speclang
 55. keep_progvars_attributes
 --- 56. add_smtvars_types
 --- 57. remove_clauses
 58. spec
 59. unfoldable_funs
 60. hidden_funs
 61. side_effect_free_funs
 62. cannot_abort_funs
 --- 63. far
 64. csv_usrdef
 --- 65. generate_canonical_program
 66. rep
 67. split
 68. post_unfolding_lits
 --- 69. add_initialProg_to_transformedProg
 70. split_ineq
 71. clause_reversal
 72. start_with_new_definition
 73. config
*/

%-------------------------------------------------------------------------------
% 3. generalize

% --

%-------------------------------------------------------------------------------
% 4. widening

v_setting(widen(X)) :-
    member(X,[plain,cp-h79,cp-bhrz03,os,bds,boxes]),
    retractall(vs(widen(_))),
    assert(vs(widen(X))).

%-------------------------------------------------------------------------------
% 6. candidate definition head
:- multifile candidate_def_head/2.
:- dynamic candidate_def_head/2.
:- volatile candidate_def_head/2.

v_setting(candidate_def_head(var)) :-
  retractall(vs(candidate_def_head(_))),
  assert(vs(candidate_def_head(var))),
  retractall(candidate_def_head(_,_)),
  assert((
    candidate_def_head(ClSel2, NewH) :-
      clsel2_bd_2nd_goal(ClSel2, [Tbf|_]),
      gen_new_name(Tbf, Pred),
      map_term_variables(Tbf, Args),
      NewH =.. [Pred|Args]
    )
  ).
%
v_setting(candidate_def_head(linkvar)) :-
  retractall(vs(candidate_def_head(_))),
  assert(vs(candidate_def_head(linkvar))),
  retractall(candidate_def_head(_,_)),
  assert((
    candidate_def_head(ClSel2, NewH) :-
      clsel2_components(ClSel2, H,C,L,[Tbf|R]),
      gen_new_name(Tbf, Pred), Ctx = (H,C,L,R),
      map_term_variables(Tbf, TbfVars),
      map_term_variables(Ctx, CtxVars),
      linking_vars(CtxVars,TbfVars, Args),
      NewH =.. [Pred|Args]
    )
  ).
%
% TODO: move the following directive to a top level transformer file
:- use_module(transformer(types)).

v_setting(candidate_def_head(basicvar)) :-
  retractall(vs(candidate_def_head(_))),
  assert(vs(candidate_def_head(basicvar))),
  retractall(candidate_def_head(_,_)),
  assert((
    candidate_def_head(ClSel2, NewH) :-
      clsel2_bd_2nd_goal(ClSel2, [Tbf|_]),
      gen_new_name(Tbf, Pred),
      term_variables_types(Tbf::list(bool), Vars),
      bnbvars(Vars,BVars,_NBVars),
      NewH =.. [Pred|BVars]
    )
  ).
%
v_setting(candidate_def_head(usrdef)) :-
  retractall(vs(candidate_def_head(_))),
  assert(vs(candidate_def_head(usrdef))),
  retractall(candidate_def_head(_,_)).

%-------------------------------------------------------------------------------
% 7. candidate definition constraint
:- multifile candidate_def_cns/3.
:- dynamic candidate_def_cns/3.
:- volatile candidate_def_cns/3.

v_setting(candidate_def_cns(true)) :-
    retractall(vs(candidate_def_cns(_))),
    assert(vs(candidate_def_cns(true))),
    retractall(candidate_def_cns(_,_,_)),
    assert((candidate_def_cns(_C,_L,C1):- constr_tt(C1))
    ).
%
v_setting(candidate_def_cns(projection)) :-
    retractall(vs(candidate_def_cns(_))),
    assert(vs(candidate_def_cns(projection))),
    retractall(candidate_def_cns(_,_,_)),
    assert((
      candidate_def_cns(C,V,C1):-
        constr_solve(C,V,C1))
    ).
%
v_setting(candidate_def_cns(e_eq)) :-
    retractall(vs(candidate_def_cns(_))),
    assert(vs(candidate_def_cns(e_eq))),
    retractall(candidate_def_cns(_,_,_)),
    assert((
      candidate_def_cns(Cns,V,Cns1):-
        vars_pairs(V,[],VP),
        gen_eq_vp(Cns,VP,Cns1)            % REVIEW: gen_eq_vp from pairs
      )
    ).
%
/*
v_setting(candidate_def_cns(e_eq)) :-
    retractall(vs(candidate_def_cns(_))),
    assert(vs(candidate_def_cns(e_eq))),
    retractall(candidate_def_cns(_,_,_)),
    assert((
      candidate_def_cns(Cns,V1,Cns1):-
        map_term_variables(Cns,V2),
        intersection_vars(V1,V2,V),
        cns_eq(Cns,V,Cns1)
      )
    ).
*/

%-------------------------------------------------------------------------------
% 14. specialize

v_setting(specialize(none)) :-
  retractall(vs(specialize(_))),
  assert(vs(specialize(none))).

%-------------------------------------------------------------------------------
% 17. delayed_generalization

v_setting(delayed_generalization(Skip,Mode)) :-
  map_check((number(Skip),Skip>=0),
              (write(' v_setting(delayed_generalization(Skip,Mode)) @ config.pl: \''),
               write(Skip),
               write('\' is not a valid value for Skip'))),
  map_check(ground(Mode),
              write(' v_setting(delayed_generalization(Skip,Mode)) @ config.pl: Mode is not ground')),
  map_check((member(Mode,[chull,plain,candidate,precandidate]);is_list(Mode)),
              (write(' v_setting(delayed_generalization(Skip,Mode)) @ config.pl: \''),
               write(Mode),
               write('\' is not a valid value for Mode'))),
  retractall(vs(delayed_generalization(_,_))),
  assert(vs(delayed_generalization(Skip,Mode))).

%-------------------------------------------------------------------------------
% 19. software model checking language

v_setting(smc_lang(X)) :-
    ( X==cil ; X==yul ),
    retractall(vs(smc_lang(_))),
    assert(vs(smc_lang(X))).


%-------------------------------------------------------------------------------
% 20. use definition tree
/*
v_setting(use_deftree(no)) :-
    map_error(write('monovariant transformation not available')),
    retractall(vs(use_deftree(_))),
    assert(vs(use_deftree(no))),
    retractall(definitions_to_be_processed(_,_,_)),
    % definitions_to_be_processed/3 is called after inv_define_fold,
    % it removes from Cls (the definitions introduced so far) all definitions in
    % Cls that are more specific than those in NewDefs
    % see transformation_strategy.pl
    assert((definitions_to_be_processed(NewDefs,Cls,Cls1) :-
               remove_morespecific_siblings(NewDefs,NewDefs1),
               remove_morespecific_ancestors(NewDefs1,Cls,Cls1))).
*/
v_setting(use_deftree(no)) :-
  retractall(vs(use_deftree(_))),
  assert(vs(use_deftree(no))).

v_setting(use_deftree(yes)) :-
  retractall(vs(use_deftree(_))),
  assert(vs(use_deftree(yes))).

%-------------------------------------------------------------------------------
% 21. input filename

v_setting(input_filename(X)) :-
    atomic(X),
    !,
    retractall(vs(input_filename(_))),
    assert(vs(input_filename(X))).

%-------------------------------------------------------------------------------
% 22. output filename

v_setting(output_filename(X)) :-
    atomic(X),
    !,
    retractall(vs(output_filename(_))),
    assert(vs(output_filename(X))).

%-------------------------------------------------------------------------------
% 23. property
% NOTE: the argument of prop is a predicate name (no arity!)

v_setting(prop(X)) :-
    atomic(X),
    !,
    retractall(vs(prop(_))),
    atom_pred(X,Pred),
    assert(vs(prop(Pred))).

%-------------------------------------------------------------------------------
% 26. theories

:- multifile map_deep_copy_term/2, generalization/4, merging/4.
:- dynamic   map_deep_copy_term/2, generalization/4, merging/4.

v_setting(theories(T)) :-
  ground(T),
  !,
  retractall(vs(theory(_,_,_,_))),
  ( member(theory(array,_,_,_),T) -> (
    retractall(map_deep_copy_term(_,_)),
    assert( (map_deep_copy_term(Term,Term1) :- map_deep_copy_term_(Term,[],Term1,_)) )
    )
  ;
    true
  ),
  v_setting_list(T).

%-------------------------------------------------------------------------------
% 28. set the verbosity level of the system log files
v_setting(verbosity(X)) :-
    atomic(X),
    retractall(vs(verbosity(_))),
    assert(vs(verbosity(X))).

%-------------------------------------------------------------------------------
% 29. clause output format settings

v_setting(print(T)) :-
    ( T = pretty ; T = raw ),
    retractall(vs(print(_))),
    assert(vs(print(T))).

%-------------------------------------------------------------------------------
% 30. define a list of commands to be unfolded
% to be used in the strategy
v_setting(unf(X)) :-
    is_list(X),
    ground(X),
    retractall(vs(unf(_))),
    assert_unf_atoms(X).

% v_setting(unf(X)) ancillary predicate
assert_unf_atoms([]).
assert_unf_atoms([H|T]) :-
    member(H,[ite,fun,undef_fun]),
    assert(vs(unf(H))),
    assert_unf_atoms(T).


%-------------------------------------------------------------------------------
% 31. skip generalization

% ---

%-------------------------------------------------------------------------------
% 34. goal replacement

v_setting(goal_replacement(G,E)) :-
    ground(G), ground(E),
    memberchk(G,[array,uf,bp]),
    memberchk(E,[engine(chr),engine(native),engine(funct),engine(totfunct),engine(bsat),engine(scc),engine(cgr)]),
    retractall(vs(goal_replacement(_,_))),
    assert(vs(goal_replacement(G,E))).


%-------------------------------------------------------------------------------
% 35. annotated vcs

v_setting(annotated_vcs) :-
    retractall(vs(annotated_vcs)),
    assert(vs(annotated_vcs)).

%-------------------------------------------------------------------------------
% 36. observables

v_setting(observables(X,Y)) :-
    nonvar(X), nonvar(Y),
    member(X,[values,indices,all]),
    member(Y,[intersection,subset,revsubset,equality,neintersection,fe_or_neintersection]),
    retractall(vs(observables(_,_))),
    assert(vs(observables(X,Y))).

%-------------------------------------------------------------------------------
% 37. post_spec

v_setting(post_spec(remove_useless_subsumed)) :-
    retractall(vs(post_spec(_))),
    assert(vs(post_spec(remove_useless_subsumed))).

%-------------------------------------------------------------------------------
% 39. maximun number of UDF iterations

v_setting(max_UDF_iterations(N)) :-
    number(N),
    !,
    retractall(vs(max_UDF_iterations(_))),
    ( ( N > 0 ) ->
      assert(vs(max_UDF_iterations(N)))
    ;
      true
    ).


%-------------------------------------------------------------------------------
% 40. solver

v_setting(solver(X)) :-
    nonvar(X),
    retractall(vs(solver(_))),
    assert(vs(solver(X))).

%-------------------------------------------------------------------------------
% 47. halt on constrained fact

v_setting(halt_on_cfact) :-
	assert(vs(halt_on_cfact)).


%-------------------------------------------------------------------------------
% 48. split ids

v_setting(split_ids(Ids)) :-
    retractall(vs(split_ids(_))),
	assert(vs(split_ids(Ids))).


%-------------------------------------------------------------------------------
% 49. unfolding strategy

v_setting(unfolding(USM)) :-
    ground(USM),
    member(USM,[depth,breadth]),
    retractall(vs(unfolding(_))),
    assert(vs(unfolding(USM))),
    true.%unfold:assert_unfold(USM).

%-------------------------------------------------------------------------------
% 51. do not initialize global variables

v_setting(do_not_auto_set_global_vars) :-
    retractall(vs(do_not_auto_set_global_vars)),
    assert(vs(do_not_auto_set_global_vars)).


%-------------------------------------------------------------------------------
% 52. new_name_functor_basenames

v_setting(new_name_functor_basenames(X)) :-
  retractall(vs(new_name_functor_basename(_))),
  retractall(user:new_name_functor_basenames(_)),
  retractall(user:term_pred_basename(_,_)),
  retractall(user:pred_basename_suffix(_,_)),
  v_setting(new_name_functor_basenames_(X)).

% default basename
v_setting(new_name_functor_basenames_(std)) :-
  assert(vs(new_name_functor_basename(std))),
  assert(user:new_name_functor_basenames(['new'])),
  assert(user:term_pred_basename(_AnyTerm,'new')),
  assert(user:(pred_basename_suffix(_,Suffix) :- std_basename_suffix(Suffix)) ).
% basename from the filename
v_setting(new_name_functor_basenames_(filename)) :-
  assert(vs(new_name_functor_basename(filename))),
  vs(input_filename(Filename)),
  map_filename_basedir_basename(Filename,_Dirname,Basename),
  atom_codes(Basename,BasenameChars),
  strip_suffixes(BasenameChars,BasenameChars1),
  filename_to_pred(BasenameChars1,BasenameChars2),
  atom_codes(Basename2,BasenameChars2),
  assert(user:new_name_functor_basenames([Basename2])),
  assert(user:term_pred_basename(_AnyTerm,Basename2)),
  assert(user:(pred_basename_suffix(_,Suffix) :- std_basename_suffix(Suffix)) ).
% specifies a basename for the predicate symbol of new definitions
v_setting(new_name_functor_basenames_(userdef)) :-
  assert(vs(new_name_functor_basename(userdef))).

%-------------------------------------------------------------------------------
% 53. specification file

v_setting(specfile(SpecFile)) :-
    retractall(vs(specfile(_))),
    assert(vs(specfile(SpecFile))).

%-------------------------------------------------------------------------------
% 54. specification language

v_setting(speclang(SpecLang)) :-
    retractall(vs(speclang(_))),
    member(SpecLang,[horn,vsl]),
    assert(vs(speclang(SpecLang))).

% default environment structure
:-  assert(env_elem_pvar_component((P,_),P)),
    assert(env_elem_lvar_component((_,L),L)),
    assert(env_elem_attr_component((_,_),_)),
    assert(env_elem_components((P,L),P,L,_)).

%-------------------------------------------------------------------------------
% 55. keep program variables attributes during the removal of the interpreter

v_setting(keep_progvars_attributes) :-
    retractall(vs(keep_progvars_attributes)),
    retractall(env_elem_pvar_component(_,_)),
    retractall(env_elem_lvar_component(_,_)),
    retractall(env_elem_attr_component(_,_)),
    retractall(env_elem_components(_,_,_,_)),
    assert(env_elem_pvar_component((P,_,attr(_)),P)),
    assert(env_elem_lvar_component((_,L,attr(_)),L)),
    assert(env_elem_attr_component((_,_,attr(A)),A)),
    assert(env_elem_components((P,L,attr(A)),P,L,A)),
    assert(vs(keep_progvars_attributes)).

%-------------------------------------------------------------------------------
% 56. add types of smt variables

v_setting(many_sorted_CHCs) :-
  retractall(vs(many_sorted_CHCs)),
  assert(vs(many_sorted_CHCs)).

%-------------------------------------------------------------------------------
% 58. specification

v_setting(spec(svcomp)) :- retractall(vs(spec(_))), assert(vs(spec(svcomp))).
v_setting(spec(triple)) :- retractall(vs(spec(_))), assert(vs(spec(triple))).

%-------------------------------------------------------------------------------
% 59. unfoldable_funs
% define a list of unfoldable functions
% to be used in the strategy
v_setting(unfoldable_funs(X)) :-
    is_list(X),
    ground(X),
    retractall(vs(unfoldable_funs(_))),
    assert(vs(unfoldable_funs(X))).

%-------------------------------------------------------------------------------
% 60. hidden_funs
% define a list of functions that must be interpreted as undefined functions
% to be used in the interpreter

v_setting(hidden_funs(X)) :-
    is_list(X),
    ground(X),
    retractall(vs(hidden_funs(X))),
    assert(vs(hidden_funs(X))).

% ------------------------------------------------------------------------------
% 61. side_effect_free_funs
% define a list of side-effect-free functions
% to be used in the interpreter

v_setting(side_effect_free_funs(X)) :-
    is_list(X),
    ground(X),
    retractall(vs(side_effect_free_funs(_))),
    assert(vs(side_effect_free_funs(X))).

% ------------------------------------------------------------------------------
% 62. cannot_abort_funs
% define a list of functions that cannot abort
% to be used in the interpreter

v_setting(cannot_abort_funs(X)) :-
    is_list(X),
    ground(X),
    retractall(vs(cannot_abort_funs(_))),
    assert(vs(cannot_abort_funs(X))).

% ------------------------------------------------------------------------------
% 63. far
% apply FAR analysis

% TODO: get the code from MAPline_swi and check the porting status (SICS-> SWI)
%v_setting(far) :-
%    retractall(vs(far)),
%    assert(vs(far)).

% ------------------------------------------------------------------------------
% 64. csv_usrdef

v_setting(csv_usrdef) :-
    retractall(vs(csv_usrdef)),
    assert(vs(csv_usrdef)).

% ------------------------------------------------------------------------------
% 66. rep
% apply REP analysis

v_setting(rep) :-
    retractall(vs(rep)),
    assert(vs(rep)).

% ------------------------------------------------------------------------------
% 67. split

% ---

% ------------------------------------------------------------------------------
% 68. post_unfolding_lits

v_setting(post_unfolding_lits(X)) :-
    member(X,[plain,labelled]),
    !,
    retractall(vs(post_unfolding_lits(_))),
    assert(vs(post_unfolding_lits(X))),
    retractall(labelled_literal(_,_,_)),
    retractall(labelled_literals(_,_,_)),
    retractall(labelled_initial_def(_,_)),
    assert_post_unfolding_lits(X).

assert_post_unfolding_lits(plain) :-
    assert((labelled_literal(L,_,L))),
    assert((labelled_literals(L,_,L))),
    assert(labelled_initial_def(C,C)).

assert_post_unfolding_lits(labelled) :-
    assert((labelled_literal(LabAtm,Lab,Atm) :-
      LabAtm=ll(Lab,Atm), positive_literal(Atm), positive_literal(LabAtm))),
    assert((labelled_literal(LabLit,Lab,Lit) :-
      LabLit=(\+ LabAtm),  Lit=(\+ Atm), LabAtm=ll(Lab,Atm))),
    assert((labelled_literals([],_,[]))),
    assert((labelled_literals([Lit|Ls],Lab,[LabLit|PLs]) :-
      (nonvar(Lit); nonvar(LabLit)), labelled_literal(LabLit,Lab,Lit), !, labelled_literals(Ls,Lab,PLs))),
    assert((labelled_literals([Lit|Ls],Lab,[Lit|PLs]) :-
      nonvar(Lit), labelled_literals(Ls,Lab,PLs))),
    assert(init_lit_lab([],_,[])),
    assert((init_lit_lab([E|Es],P,[PE|PEs]) :-
      P1 is P+1, labelled_literal(PE,P,E), init_lit_lab(Es,P1,PEs))),
    assert(labelled_initial_def([],[])),
    assert((labelled_initial_def([C1|Cls1],[C2|Cls2]) :-
      clause_components(C1,H,Cn,G),
      init_lit_lab(G,1,PG),
      clause_components(C2,H,Cn,PG),
      labelled_initial_def(Cls1,Cls2)
    )).
% ------------------------------------------------------------------------------
% 69. add_initialProg_to_transformedProg

% ---

% ------------------------------------------------------------------------------
% 70. split_ineq

v_setting(split_ineq) :-
    retractall(vs(split_ineq)),
    assert(vs(split_ineq)).

% ------------------------------------------------------------------------------
% 71. clause_reversal
v_setting(clause_reversal) :-
    retractall(vs(clause_reversal)),
    assert(vs(clause_reversal)).

% ------------------------------------------------------------------------------
% 72. start_with_new_definition

% ---

% ------------------------------------------------------------------------------
% 73. bounded width proof tree check
v_setting(vs(bw_pt_chk)) :-
  retractall(vs(bw_pt_chk)),
  assert(vs(bw_pt_chk)).

% ------------------------------------------------------------------------------
% 74. outprog_format

% ---

% ------------------------------------------------------------------------------
% 75. folding
v_setting(folding(X,Y)) :-
  retractall(vs(folding(_,_))),
  assert(vs(folding(X,Y))),
  folding(Y).
%%%
folding(X) :-
  X == variant,
  !,
  retractall(more_general_goal(_,_,_)),
  assert((more_general_goal(L1,L2, L3) :-
    permutation_variant(L1,L2, L3))
  ).
%
folding(X) :-
  X == subsumes_term,
  !,
  retractall(more_general_goal(_,_,_)),
  assert((more_general_goal(L1,L2, L3) :-
    permutation_subsumes_term(L1,L2, L3))
  ).

% ------------------------------------------------------------------------------
% differential predicates options
v_setting(diffpred_triggering(X)) :-
  (X == subsumes ; X == variant),
  !,
  retractall(vs(diffpred_triggering(_))),
  assert(vs(diffpred_triggering(X))).

v_setting(diffpred(X)) :-
  (X == on ; X == off),
  !,
  retractall(vs(diffpred(_))),
  assert(vs(diffpred(X))).

% ------------------------------------------------------------------------------
% specification options
v_setting(spec_as(Use)) :-
  (Use == abstr ; Use == lemma),
  !,
  retractall(vs(spec_as(Use))),
  assert(vs(spec_as(Use))).


% ------------------------------------------------------------------------------
% CSV file
v_setting(csvfile(F)) :-
    retractall(vs(csvfile(_))),
    assert(vs(csvfile(F))).

%-------------------------------------------------------------------------------
% specialized program

v_setting(tranf_config(X)) :-
    atomic(X),
    !,
    retractall(vs(tranf_config(_))),
    assert(vs(tranf_config(X))).

%-------------------------------------------------------------------------------
v_setting(timestamp(Label,Timestamp)) :-
    nonvar(Label),
    nonvar(Timestamp),
    !,
    retractall(vs(timestamp(_,_))),
    assert(vs(timestamp(Label,Timestamp))).

%-------------------------------------------------------------------------------
v_setting(def_variants(polyvariant)) :-
    retractall(vs(def_variants(_))),
    assert(vs(def_variants(polyvariant))).
v_setting(def_variants(monovariant)) :-
    retractall(vs(def_variants(_))),
    assert(vs(def_variants(monovariant))).

%-------------------------------------------------------------------------------
v_setting(log_stream(X)) :-
    atomic(X),
    !,
    retractall(vs(log_stream(_))),
    assert(vs(log_stream(X))).

v_setting(log_filename) :-
    !,
    vs(input_filename(InFileName)),
    ( atom_concat(BaseName,'.pl',InFileName) ->
      atom_concat(BaseName,'.log',LogFileName)
    ;
      atom_concat(InFileName,'.log',LogFileName)
    ),
    v_setting(log_filename(LogFileName)).
%
v_setting(log_filename(LogFileName)) :-
    !,
    retractall(vs(log_filename(_))),
    assert(vs(log_filename(LogFileName))),
    open(LogFileName, append, Stream),
    v_setting(log_stream(Stream)).
%-------------------------------------------------------------------------------
%-------------------------------------------------------------------------------
% default - wrong v_setting argument
v_setting(X) :-
    map_error((write('wrong option for v_setting: '),write(X))).

%-------------------------------------------------------------------------------

v_setting_list([]).
v_setting_list([H|T]) :-
    assert(vs(H)),
    v_setting_list(T).


v_setting_list(_,[]).
v_setting_list(P,[H|T]) :-
    (is_list(H) -> A=..[P|H]; A=..[P,H]),
    assert(vs(A)),
    v_setting_list(P,T).


% ------------------------------------------------------------------------------

% standard identity generalization
apply_sig :-
    retractall(generalization_epilogue(_,_,_,_,_,_,_,_,_)),
    assert( (generalization_epilogue(A,CD,Def1,As,Defs_in,NewDefs_in, Def,Defs_out,NewDefs_out) :-
              idgen(A,CD,Def1,As,Defs_in,NewDefs_in, Def,Defs_out,NewDefs_out) ) ).
