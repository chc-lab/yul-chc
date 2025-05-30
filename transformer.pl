% TRANSFORMER

:- compile('src/io.pl').
:- compile('src/verimap_utils.pl').
:- compile('config.pl').
:- compile('src/transformation_strategy.pl').
:- compile('src/chc2smt.pl').
:- compile('src/chc2chc.pl').
:- compile('src/remove_unfold.pl').

:- use_module(library(clpq)).
:- use_module(library(clpb)).

:- use_module(transformer(types)).

:- use_module(library(shlib)).

:- discontiguous exec/1.

:- on_signal(alrm, _, signal_handler).

% WARNING clpb.pl throws (and catches) exceptions (e.g. tautology) for resetting attributes
% when performing standard (non-exceptional) actions
%
%user:prolog_exception_hook(  cannot_infer_type(_),  _, _, _) :- trace.
%user:prolog_exception_hook(  X,  _, _, _) :- X\==tautology, trace.

user:runtime_entry(start) :-
	debug,
    prolog_flag(argv,Argv),
    exec(Argv),
    halt.

exec(Argv) :-

    append(_,[udf,InFileName,Config],Argv),

    get_time(TimestampTrStarted),

    default_settings, % retract all vs/1

		v_setting(timestamp(tranformation_started,TimestampTrStarted)),

    map_log(fine, (
      stamp_date_time(TimestampTrStarted,DTTrStarted,'local'),
	    format_time(atom(A),'%a, %d %b %Y %T',DTTrStarted,'posix'),
			write('['),  write(A), write('] '),             nl, nl,
			write('> '), write(Config), write(' <'),        nl, nl,
			write('Let\'s get the transformation started'), nl, nl)
		),

    v_setting(input_filename(InFileName)),
    %%%
    catch( compile(Config), Catcher,
      map_error( (write(compile(Config)), write(': '), write(Catcher)) )
    ),
		v_setting(tranf_config(Config)),
    %%% temporary - consult default file w/ v_setting(output_filename(_)), v_setting(max_UDF_iterations(N)), v_setting(verbosity(Val)), v_setting(csvfile(CSVFile))
    catch( compile('other.v_setting.config'), Catcher, map_warning(write('other.v_setting.config does not exist!')) ), 
    catch( delete_file('other.v_setting.config'), Catcher, map_warning(write('cannot delete other.v_setting.config!')) ),
    %%%
    ( vs(output_filename(OutFileName)) -> true ; map_error( write('vs(output_filename/1 undefined!') ) ),
    map_log(fine, svs),

    % read the input file (as list of terms)
    map_read_file(InFileName,InCls),

    %%%%
    vs(solver(S)),
    map_log(fine,(write('Loading solver: '),write(S),nl)),
    use_module(solver(S)),
    % generate the initial (canonical) clauses from the input file
	  % and assert them (add them to the cc module)
    map_load_inprog(InCls),
    map_log(finest,show_inprog),
    !,

    statistics(runtime,[T1,_]),

    % bounded width proof tree
    ( vs(bw_pt_chk) , \+ bounded_width_proof_tree ->
      v_setting(specialize(none))
    ;
      true
    ),
    % ---

    ( vs(specialize(none)) ->
      Pspec = []
    ;
      ( initialize_current_new_def_functor(InCls), transform(Pspec) )
    ),

    (vs(post_spec(remove_useless_subsumed)) ->
      remove_useless_subsumed_clauses(Pspec,Pspec1)
    ;
      Pspec1=Pspec
    ),

    ( vs(far) ->
        far(Pspec1,Pspec3F)
    ;
      	Pspec3F=Pspec1
    ),

    ( vs(rep) ->
        replace_peqs_processing(Pspec3F,Pspec3)
    ;
      	Pspec3=Pspec3F
    ),

    statistics(runtime,[T2,_]),
    T is T2-T1,

    prog_cls(Pspec3,Cls),

    !,

    map_log(info,(write(' Elapsed time (ms): '), write(T), nl, nl)),

    wsf(InCls,T,Cls,unknown),

    % add val constraints
    (vs(annotated_vcs) ->
      ( annotated_vcs(Cls,Cls1), show_cls(Cls1) )
    ;
      Cls1=Cls
    ),

    % -- print output -----------------------------------------
    ( vs(specialize(none)) -> true ; map_write_outprog(Cls1) ),
    % ---------------------------------------------------------
    !,
    ( vs(specmap2dot) -> specmap2dot(Cls) ; true),
    ( vs(deftree2dot) -> deftree2dot ; true),
    ( vs(vcs_stats) -> vc_stats(OutFileName,Pspec3);  true ),

    map_log(fine,(write('-ETX-'), nl, nl)).

exec(Argv) :-
  append(_,[X,InFileName],Argv),
  member(X,[smt,cvc,z3]),
  !,
  % load default configuration
  default_settings,
  %%% temporary - consult default file w/ v_setting(output_filename(_))
  catch( compile('other.v_setting.config'), Catcher, map_warning(write('other.v_setting.config does not exist!')) ), 
  catch( delete_file('other.v_setting.config'), Catcher, map_warning(write('cannot delete other.v_setting.config!')) ),
  %%%
	use_module(strategy('t_loop_prologue-map2other')),
  % read the input file (as list of terms)
  map_read_file(InFileName,Terms),
  %%%%
  vs(solver(S)),
  map_log(fine,(write('Loading solver: '),write(S),nl)),
  use_module(solver(S)),
  % generate the initial (canonical) clauses from the input file
	% and assert them (add them to the cc module)
  map_load_inprog(Terms),
  map_inprog(Cls),
  map_log(finest,show_inprog),
  !,
  % write program to file
  ( vs(output_filename(OutFileName)) -> true ; map_error( write('vs(output_filename/1 undefined!') ) ),
  tell(OutFileName),
  map2(X,Cls),
  told.

exec(Argv) :-
  append(_,[mapnum,InFileName],Argv),
  !,
  % configuration
  default_settings,
  %%% temporary - consult default file w/ v_setting(output_filename(_))
  catch( compile('other.v_setting.config'), Catcher, map_warning(write('other.v_setting.config does not exist!')) ), 
  catch( delete_file('other.v_setting.config'), Catcher, map_warning(write('cannot delete other.v_setting.config!')) ),
  % read input
  map_read_file(InFileName,Terms),
  !,
  findall((H,B), member((_,(H,B)),Terms), Cls1),
  % write program to file
  ( vs(output_filename(OutFileName)) -> true ; map_error( write('vs(output_filename/1 undefined!') ) ),
  tell(OutFileName),
  map2(mapnum,Cls1),
  told.

% ------------------------------------------------------------------------------
exec(System) :-
    map_error((write('Unknown language/system: '),write(System))).
