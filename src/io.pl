% MODULE: input_output_common
:- module(io,
    [ show_prog/1
    , show_cls/1
    , show_cl/1
    , show_deftree/1
    , show_UDF_iteration_info/1
    , show_genres_cls/3
    , show_ignore/1
    , show_query/0
    , map_load_inprog/1
    , map_inprog/1
    , map_read_file/2
		, map_log/2
    , map_error/1
    , map_warning/1
    , map_check/2
    , map_assert_list/1
    , wsf/4
    , map_write_outprog/1
    , map_write_outprog/2
    , signal_handler/1
    , op(1150, fx, logic)
    , op(1150, fx, query)
    , op(1150, fx, ignore)
 	  ]).

:- use_module(types).

% MODE: show_prog(+Defs)
% TYPE: show_prog(list(def))
% SEMANTICS: displays the list Defs of definitions

show_prog([]).
show_prog([(_,Def)|Defs]) :-
	show_cls(Def),
	show_prog(Defs).


show_inprog :-
  nl, write('Initial program:'), nl,
  show_inprog_.
show_inprog_ :-
  cc_inprog:cc(_/_,Cl),
  show_cl(Cl),
  fail.
show_inprog_.


% MODE: show_cls(+Cls)
% TYPE: show_cls(list(clause))
% SEMANTICS: displays the list Cls of clauses

show_cls([]).
show_cls([Cl|Cls]) :-
  show_cl(0,Cl),
	nl,
	show_cls(Cls).


% MODE: show_cl(+Cl)
% TYPE: show_cl(clause)
% SEMANTICS: displays the clause Cl

show_cl(Cl) :-
	show_cl(0,Cl),
	nl.
%
show_cl(I,(Head,bd(Cns,Lits))) :-
  constr(FCns,Cns), pp_eqs(FCns,FCns1),
	append(FCns1,Lits,Bd),
  show_clause(I,(Head,Bd)).


% MODE: show_deftree(+DefTree)
% TYPE: show_deftree(clause_tree)
% SEMANTICS: displays the tree DefTree of clauses (grouped by body atoms)

show_deftree([]).
show_deftree([Def|Defs]) :-
  write('definition:'), nl,
  show_cl(Def),
  write('ancestors: '), nl,
  ancestor_defs(Def,Ancs),
  show_cls(Ancs), nl,
  show_deftree(Defs).


% MODE: show_clstree(+ClsTree)
% TYPE: show_clstree(list(list(clause)))
% SEMANTICS: displays the tree ClsTree of clauses (represented as
% a list of lists of clauses)

show_clstree([]).
show_clstree([[Cl|Cls]|Clss]) :-
	write('definition:'), nl,
	show_cls([Cl]),
	(Cls=[] -> (write('no ancestor'), nl); (write('ancestors:'), nl)),
	show_cls(Cls), nl,
	show_clstree(Clss).


% MODE: show_clsel2(+CSel)
% TYPE: show_clsel2(list(def))
% SEMANTICS: displays the clause selection

show_clsel2((H,bd(Cns,Lhs,Rhs))) :-
  append(Lhs,Rhs,Lits),
  show_cl(0,(H,bd(Cns,Lits))).


show_clsel((H,bd(Cns,Lhs,Rhs))) :-
  show_clsel2((H,bd(Cns,Lhs,Rhs))).


% TODO: update the name and its call into src_sics/transformation_meta_strategy_poly.pl
show_clsel2s([]).
show_clsel2s([ClSel|ClSels]) :-
  show_clsel2(ClSel),
  nl,
  show_clsel2s(ClSels).


% MODE: show_UDF_iteration_results(+N,+SCls,+NewDefs,+FoldedCls)
% TYPE: show_UDF_iteration_results(nat,list(clauses),lists(clauses),list(clauses))
% SEMANTICS: displays the result of the Nth iteration of the udf cycle
show_UDF_iteration_results(_N,SCls,_GCls,_NewDefs,_FoldedCls) :-
  length(SCls,0),
  !.
%
show_UDF_iteration_results(N,SCls,GCls,NewDefs,FoldedCls) :-
  map_log(
    finer,
    (
      ddashedline,
      write(' RESULTS of UDF-cycle #'), write(N), nl, nl,
      write(' -unfold- '), nl, show_cls(SCls), nl,
      ( vs(goal_replacement(Theory,_)) ->
          ( write(' -goal replacement ('), write(Theory), write(')-'), nl,
            show_cls(GCls), nl );
          true
      ),
      write(' -define- '), nl, show_cls(NewDefs), nl,
      write(' -fold-   '), nl, show_cls(FoldedCls), nl
    )
  ).

%
user:show_iteration_results(_N,Res) :-
	member((unfold,Cls),Res),
	length(Cls,0),
	!.
%
user:show_iteration_results(N,Res) :-
  map_log(
    finer,
    (
      ddashedline,
	  	write(' RESULTS of UDF-cycle #'), write(N), nl, nl,
      show_iteration_results_(Res)
    )
  ).

%
show_iteration_results_([]).
show_iteration_results_([(Rule,Results)|Others]) :-
	show_rule_results(Rule,Results),
  show_iteration_results_(Others).

%
show_rule_results(unfold,Cls) :-
  write(' -unfold- '), nl,
	show_cls(Cls), nl.
%
show_rule_results(remove,Cls) :-
  write(' -remove useless- '), nl,
	show_cls(Cls), nl.
%
show_rule_results(goal_repl,Cls) :-
	( vs(goal_replacement(Th,_)) ->
	  ( write(' -goal replacement ('), write(Th), write(')-'), nl, show_cls(Cls), nl)
  ;
    true
  ).
%
show_rule_results(define,Cls) :-
  write(' -define- '), nl, show_cls(Cls), nl.
%
show_rule_results(fold,Cls) :-
	write(' -fold-   '), nl, show_cls(Cls), nl.


% MODE: show_UDF_iteration_info(+N)
% TYPE: show_UDF_iteration_info(nat)
% SEMANTICS: displays iteration number

show_UDF_iteration_info(N) :-
  map_log(
    finest,
    (
      starredline,
      write(' UDF-cycle #'),
      write(N), nl,
      starredline,
      nl
    )
  ).


% MODE: show_UDF_iteration_info(+Cls,+Max_UDF_iterations)
user:show_UDF_interruption_message(Cls,Max_UDF_iterations) :-
  map_log(
    info,
    (
      dashedline,
      write(' The maximum number of UDF-cycle has been reached ('),
      write(Max_UDF_iterations),
      write(').'),
      ( Cls=[] ->
        ( nl, write(' No clauses to be processed are left :-)') );
        ( nl, write(' WARNING: some clauses to be processed are left :-(') )
      ), nl,
      dashedline
    )
  ).


user:show_transf_seq_epilogue(C,TransfClsOut) :-
    map_log(fine,(nl, write('Transformation result:'), nl, nl)),
    % --------------------------------------------------------------------------
    defs(Defs),
    length(Defs,N),
    map_log(info, (nl, write(' Definitions: '), write(N), nl) ),
    vs(output_filename(SpecProg)),
    ( N\==0 ->
      ( % print definitions to console
        map_log(finer,(nl, show_cls(Defs), nl) ),
        map_log(finest,(nl,
          ( (vs(use_deftree(yes)), vs(def_variants(polyvariant))) ->
            (write(' -definition tree- '), nl, nl, show_deftree(Defs))
          ;
            true
          )
        )),
        % write definitions to file
        atom_concat(SpecProg,'-defs.txt',DefsFile),
        map_log(info,(write(' Definitions written to: '), write(DefsFile), nl)),
        tell(DefsFile), % open DefsFile
        show_cls(Defs),
        told            % close DefsFile
      )
    ;
      true
    ),
    % --------------------------------------------------------------------------
    I is C-1,
    map_log(info,(write(' Transformation cycles: '), write(I), nl) ),
    map_log(fine,(nl, write('Transformed program: '), nl, show_cls(TransfClsOut), nl )),
    map_log(info,(write(' Output written to: '), write(SpecProg), nl)).



dashedline :-
   write('--------------------------------------------------------------------------------'),
   nl.

ddashedline :-
   write('================================================================================'),
   nl.

starredline :-
   write('********************************************************************************'),
   nl.


show_preproc_anc(C1,C2) :-
   map_log(finest,( write(' ancestor:'),               nl, show_cl(C1),
                    write(' pre-processed ancestor:'), nl, show_cl(C2), nl ) ).

show_genres_cls(C1,C2,C3) :-
   map_log(finest,( write(' ancestor:'),  nl, show_cl(C1),
                    write(' candidate:'), nl, show_cl(C2),
                    write(' generalization:'), nl, show_cl(C3), nl )  ).

show_delres_cls(Mode,C1,C2,C3) :-
   map_log(finest,( write(' ancestor:'),  nl, show_cl(C1),
                    write(' candidate:'), nl, show_cl(C2),
                    write(' merge ('), write(Mode), write('):'), nl, show_cl(C3), nl )  ).

%-------------------------------------------------------------------------------
% show_clause
%-------------------------------------------------------------------------------
show_clause(InitPos, (H,B)) :-
  ( vs(theory(array,_,_,_)) ->
    map_deep_copy_term((H,B),(H1,B1)) % TODO: to be replaced by copy_term/3
  ;
    copy_term((H,B),(H1,B1))
  ),
  ( vs(print(raw)) ->
    B1=B2
  ;
    unify_vars_eqs(B1,B2)
  ),
  ( vs(theory(val,_,_,_)) ->
    bind_remove_val_cns(B2,B3)
  ;
    B2=B3
  ),
  numbervars((H1,B3),0,_),
  writeq(H1),
  (B3=[] ->
    write('.');
    ( print_length(write(H1),LH1),
      LH2 is LH1 + 4 + InitPos,
      write(' :- '),
      show_body_pp(B3,LH2)
    )
  ).

pp_eqs([],[]).
pp_eqs([X1=:=Y1|E1],[X2=Y2|E2]) :-
  pp_eqs(X1,Y1,X2,Y2),
  !,
  pp_eqs(E1,E2).
pp_eqs([E|E1],[E|E2]) :-
  pp_eqs(E1,E2).
%%
pp_eqs(X1,Y1,X2,Y2) :-
  var(X1), var(Y1),
  X1=X2, Y1=Y2.
pp_eqs(X1,Y1,X2,Y2) :-
  var(X1),
  bool_const(Y1,Y2),
  X1=X2.
pp_eqs(X1,Y1,X2,Y2) :-
  var(Y1),
  bool_const(X1,X2),
  Y1=Y2.
%%
bool_const(X,Y) :- X == 1, Y=true.
bool_const(X,Y) :- X == 0, Y=false.


show_body_pp(L,LH) :-
  show_body_lines_pp(L,10,LH,80).
show_body_lines_pp(bd(C,B), PosInitBody,PosLine, Max) :-
  !,
	append(C,B,L),
  show_body_lines_pp(L, PosInitBody,PosLine, Max).
show_body_lines_pp([H], PosInitBody,PosLine, Max) :-
  !,
	print_length(io:map_writeq(H),Length),
  NewPos is PosLine + Length + 1,
	(NewPos > Max -> nl, tab(PosInitBody); true),
  map_writeq(H),
  write('.').
show_body_lines_pp([H|T],PosInitBody,Pos,Max) :-
	print_length(io:map_writeq(H),Length),
  NewPos is Pos + Length + 2,
	(NewPos > Max ->
	  (	nl, tab(PosInitBody), Pos2 is PosInitBody +  Length + 2 )
	;
    Pos2=NewPos
  ),
  map_writeq(H),
  write(', '),
	show_body_lines_pp(T, PosInitBody,Pos2,Max).

%
map_writeq(R) :-
  map_rational(R,A,B),
  !,
  ( B==1 ->
    ( ( A<0 ->
        write(' ')
      ;
        true
      ),
      write(A)
    )
  ;
    write(A/B)
  ).
map_writeq(- A) :-
  !,
  write(' -'),
  map_writeq(A).
map_writeq(A * B) :-
  !,
  map_writeq(A),
  write('*'),
  map_writeq(B).
map_writeq(A + B) :-
  !,
  map_writeq(A),
  write('+'),
  map_writeq(B).
map_writeq(A - B) :-
  !,
  map_writeq(A),
  write('-'),
  map_writeq(B).
map_writeq(A > B) :-
  !,
  map_writeq(A),
  write('>'),
  map_writeq(B).
map_writeq(A >= B) :-
  !,
  map_writeq(A),
  write('>='),
  map_writeq(B).
map_writeq(A < B) :-
  !,
  map_writeq(A),
  write('<'),
  map_writeq(B).
map_writeq(A =< B) :-
  !,
  map_writeq(A),
  write('=<'),
  map_writeq(B).
map_writeq(A =:= B) :-
  !,
  map_writeq(A),
  write('='),
  map_writeq(B).
map_writeq(A =\= B) :-
  !,
  map_writeq(A),
  write(=\=),
  map_writeq(B).
map_writeq(A = B) :-
  !,
  map_writeq(A),
  write('='),
  map_writeq(B).
map_writeq(constr(X)) :-
  !,
  ( vs(print(raw)) ->
    ( write('constr(('), writeq(X), write('))') )
  ;
    ( write('('), writeq(X), write(')') )
  ).
map_writeq(X) :-
  writeq(X).


%
bind_remove_val_cns([],[]).
bind_remove_val_cns([val(A,B)|Cns],Cns1) :-
  member(val(A,_B),Cns),
  atom_concat(A,'_P',B),
  !,
  bind_remove_val_cns(Cns,Cns1).
bind_remove_val_cns([val(A,B)|Cns],Cns1) :-
  A=B,
  !,
  bind_remove_val_cns(Cns,Cns1).
bind_remove_val_cns([Cn|Cns],[Cn|Cns1]) :-
  bind_remove_val_cns(Cns,Cns1).

%-------------------------------------------------------------------------------
% MODE: wsf(+T,+Cls,+Answer)
% SEMANTICS: write statistics file

wsf(InProg,T,Cls,Answer) :-

  vs(input_filename(Example)),

    ( vs(csv_usrdef) ->
      (
       map_filename_basedir_basename(Example,_DirName,BaseName),
       atom_concat('invchkspec_stats_',BaseName,BaseName1),
       atom_concat(BaseName1,'.csv',CSVFileName)
      )
    ;
     (vs(csvfile(F)) ->
	      CSVFileName=F
		;
	      CSVFileName='invchkspec_stats.csv'
     )
    ),

    open(CSVFileName,append,Stream),

    % std parameters
    write(Stream,Example), write(Stream,','),
    vs(output_filename(SpecProg)), write(Stream,SpecProg),write(Stream,','),

    % #input cls
    length(InProg,InProgClsLen), write(Stream,InProgClsLen),write(Stream,','),
    % #defs
    num_defs(NumDefs), write(Stream,NumDefs),write(Stream,','),
    % #used_defs
    preds_in_cls(Cls,[],UsedPreds),length(UsedPreds,NumUsedPreds),write(Stream,NumUsedPreds),write(Stream,','),
    % #output cls
    length(Cls,NumCls),write(Stream,NumCls),write(Stream,','),
    write(Stream,Answer),write(Stream,','),
    % property
    write(Stream,'\'\\N\''),write(Stream,','),
    %vs(prop(Phi)), write(Stream,Phi),write(Stream,','),
    % linear input prog?
    %vs(prop(Phi)), atom_pred(Phi,P/N), del_def((P/N),InProg, _ClsDef,InProg1), prog_cls(InProg1,InProgCls1),
    %(linear_cls(InProgCls1) -> write(Stream,true); write(Stream,false)), write(Stream,','),
    % off,off,off | less,gen,widen
    vs(widen(Widen)), write(Stream,Widen),write(Stream,','),
    % delaygen
    ( vs(delayed_generalization(Skip,Mode)) ->
      ( write(Stream,Skip), write(Stream,'_'), write(Stream,Mode), write(Stream,',') )
       ; write(Stream,'off,')
    ),
    %deftree
    ( vs(use_deftree(X)) -> (write(Stream,X), write(Stream,',')) ; write(Stream,'\'\\N\',') ),

    % SICS/SWI time
    write(Stream,T),
    write(Stream,','),

    % configuration
    vs(tranf_config(Config)),
    write(Stream,Config),
    write(Stream,','),

    % timestamp: tranformation_started
    vs(timestamp(tranformation_started,TimestampTrStarted)),
    stamp_date_time(TimestampTrStarted,DT,'local'),
    format_time(atom(FDT),'%Y-%m-%d %T',DT,'posix'),
    write(Stream,FDT),

    close(Stream).


write_unfoldable(_,[]).
write_unfoldable(Stream,[H|T]) :-
    write(Stream,H),
    write(Stream,' '),
    write_unfoldable(Stream,T).


% SEMATICS: Pred is the list of predicates whose definitions have a
% clause with the maximum number Max of literals
compute_max_num_lits([],Max,Preds, Max,Preds).
compute_max_num_lits([Cl|Cls],CurrentMax,PredsIn, Max,PredsOut) :-
    clause_components(Cl,Head,_,Lits),
    length(Lits,N),
    functor(Head,P,A),
    ( N = CurrentMax ->
      % add the predicate to the list
      (PredsIn1=[P/A|PredsIn], CurrentMax1=CurrentMax)
    ;
      ( N > CurrentMax ->
        % replace the old list with the singleton {P/A}
        (PredsIn1=[P/A],   CurrentMax1=N)
      ;
        (PredsIn1=PredsIn, CurrentMax1=CurrentMax)
      )
    ),
    compute_max_num_lits(Cls,CurrentMax1,PredsIn1, Max,PredsOut).


% SEMATICS: Pred is the list of predicates of definitions using
% the maximum number Max of variables
compute_max_used_vars([],Max,Pred, Max,Pred).
compute_max_used_vars([Cl|Cls],CurrentMax,PredsIn, Max,PredOut) :-
    map_term_variables(Cl,Vars),
    length(Vars,N),
    hd_pred(Cl,Pred),
    ( N = CurrentMax ->
      (PredsIn1=[Pred|PredsIn], CurrentMax1=CurrentMax)
    ;
      ( N > CurrentMax ->
        (PredsIn1=[Pred],  CurrentMax1=N)
      ;
        (PredsIn1=PredsIn, CurrentMax1=CurrentMax)
      )
    ),
    compute_max_used_vars(Cls,CurrentMax1,PredsIn1, Max,PredOut).


print_list_without_commas(_Stream,[]).
print_list_without_commas(Stream,[Element]) :-
    write(Stream,Element).
print_list_without_commas(Stream,[Element|Elements]) :-
    write(Stream,Element),
    write(Stream,' '),
    !,
    print_list_without_commas(Stream,Elements).

%-------------------------------------------------------------------------------
% MODE: wvcs(+VCsStats,+Stream)
% SEMANTICS: write verification condition statistics

wvcs([],_).
wvcs([VCStat|VCsStats],Stream) :-
    VCStat=(Pred,Arity,N,PP,Type,Fun),
    write(Stream,Pred),  write(Stream,','),
    write(Stream,Arity), write(Stream,','),
    write(Stream,N),     write(Stream,','),
    write(Stream,PP),    write(Stream,','),
    write(Stream,Type),  write(Stream,','),
    write(Stream,Fun),   write(Stream,','),
    nl(Stream),
    wvcs(VCsStats,Stream).

% MODE: wvcsf(+SpecProgFileName,+VCsStats)
% SEMANTICS: write verification condition statistics file

wvcsf(SpecProg,VCsStats) :-
    atom_concat(SpecProg,".vcs_stats.csv",FileName),
    open(FileName,write,Stream),
    wvcs(VCsStats,Stream),
    close(Stream).

%-------------------------------------------------------------------------------

% map_exists(P): checks if P exists and exit if it does not.
map_file_exists_msg(P) :- nl, write('ERROR: \''), write(P), write('\' does not exist.'), nl, halt.
map_file_exists(P) :-
  ( exists_file(P) ->
    true
  ;
    map_file_exists_msg(P)
  ).


% SEMANTICS: Filename = Dirname/Basename
map_filename_basedir_basename(Filename,Dirname,Basename) :-
  absolute_file_name(Filename,AbsFileName),
  atom_codes(AbsFileName,AbsFileNameChars),
  append(DirnameChars,[47|BasenameChars],AbsFileNameChars),
  \+ member(47,BasenameChars), % 47='/'
  atom_codes(Dirname,DirnameChars),
  atom_codes(Basename,BasenameChars).


% ------------------------------------------------------------------------------
% MODE: verbosity_value(Level,Value)
% SEMANTICS: Possible log levels in descending order
% (lower levels include higher ones):

% 0) OFF:        no logs published
verbosity_value(off,0).
% 1) ERROR:      error messages
verbosity_value(error,1).
% 2) WARNING:    warnings
verbosity_value(warning,2).
% 3) INFO:       basic info messages
verbosity_value(info,3).
% 4) FINE:       logs on the transformation input and output
verbosity_value(fine,4).
% 5) FINER:      logs on main UDF cycle
verbosity_value(finer,5).
% 6) FINEST:     logs published by subsidiary UDF strategies
verbosity_value(finest,6).
% 7) DEBUGGING:  debugging information
verbosity_value(debugging,7).


% map_log/2
map_log(MsgLevel,G) :-
  vs(verbosity(Level)),
  ( verbosity_value(MsgLevel,MsgValue) ->
    ( (MsgValue =< Level) ->
      (
        current_output(OldStream), % save current output stream
        vs(log_stream(LogStream)), % retrieve log stream
        set_output(LogStream),     % set the current output to be the log stream
        call(G),                   % call the call that produces the log entry
        flush_output(LogStream),
        set_output(OldStream)      % restore the old output stream
      )
    ;
      true
    )
  ;
    map_error((write(Level), write(' is not a valid value for verbosity.')))
  ).

% map_error/1
map_error(Error) :-
  % close the current input stream
  told,
  tell(user_error),
  nl, write('[MAPSystem] ERROR: '), call(Error), nl, nl,
  told,
	halt(1).

% map_warning/1
map_warning(Warning) :-
  nl,
  current_output(OldStream), % save current output stream
  vs(log_stream(LogStream)), % retrieve log stream
  set_output(LogStream),     % set the current output to be the log stream  
  write('[MAPSystem] WARNING: '), call(Warning), nl,
  flush_output(LogStream),
  set_output(OldStream).      % restore the old output stream  


map_check(G,Error) :- (call(G) -> true; map_error(Error)).


map_runtime(G,RTime) :-
    statistics(runtime,[RTime1,_]),
    call(G),
    statistics(runtime,[RTime2,_]),
    RTime is RTime2-RTime1.


map_source(P,File) :-
    atom_concat(P,'.pl',File).


map_source_exists(P) :-
    atom_concat(P,'.pl',File),
    map_file_exists(File).

% ------------------------------------------------------------------------------
% load_vsl_translator/0
%
load_vsl_translator :-
    map_log(info,(write('Loading VSL translator'),nl)),
    load_files(vsl_translator('verimap-libutils')).

%-------------------------------------------------------------------------------
% vc_stats is called by exec(udf) in trasnformer.pl if vs(vcs_stats) is set

vc_stats(SpecProg,Pspec1) :-
    defs(Defs),
    vc_defs_stats(Pspec1,Defs,VCsStats),
    wvcsf(SpecProg,VCsStats).


vc_defs_stats([],_,[]).

vc_defs_stats([VC|VCs],Defs,[VCStat|VCsStats]) :-
    VC=(Pred/Arity,Cls),
    length(Cls,N),
    member(Def,Defs),
    clause_hd(Def,Def_hd),
    functor(Def_hd,Pred,Arity),
    def_pp_type(Def,PP,Type,Fun),
    VCStat=(Pred,Arity,N,PP,Type,Fun),
    vc_defs_stats(VCs,Defs,VCsStats).


% MS1 - right recursive
def_pp_type(Def,PP,Type1,Fun) :-
    clause_bd_goal(Def,L),
    L=[reachable(r,Cf1,_Cf2)],
    !,
    Cf1=cf(cmd(PP,Type,_PLab,_Cmd),_Env),
    (Type=ep(F) -> (Fun=F, Type1='ep'); (Fun='N/A', Type1=Type) ).

% SS1 - from initial
def_pp_type(Def,PP,Type,Fun) :-
    clause_bd_goal(Def,L),
    L=[backreachable(Cf,_Unsafe)],
    !,
    Cf=cf(cmd(lab(PP,Type,_PLab),Cmd),_Env),
    (Cmd=call(F,_,_,_) -> Fun=F; Fun='N/A').

def_pp_type(_Def,'N/A','N/A','N/A').


print_length(Command, Length) :-
  open_null_stream(Stream), 'print length'(Command, user, Stream),
  character_count(Stream, CharsWritten),
  line_count(Stream, 1),
  close(Stream),
	Length = CharsWritten.

'print length'(Module:Command, _, Stream) :- !, 'print length'(Command, Module, Stream).
'print length'(write(X), _, Stream) :- !, write(Stream, X).
'print length'(writeq(X), _, Stream) :- !, writeq(Stream, X).
'print length'(display(X), _, Stream) :- !, write_canonical(Stream, X).
'print length'(write_canonical(X), _, Stream) :- !, write_canonical(Stream, X).
'print length'(print(X), _, Stream) :- !, print(Stream, X).
'print length'(format(F,L), _, Stream) :- !, format(Stream, F, L).
'print length'(Command, Module, Stream) :-
   current_output(OldOutput), set_output(Stream),
   (   Module:Command -> true
   ;   set_output(OldOutput), close(Stream), fail ), set_output(OldOutput).

% ==============================================================================

:- multifile user:map_term_expansion/2.
:- dynamic   user:map_term_expansion/2.

% MODE: map_read_files(+Files)
% SEMANTICS: load a list of files
map_read_file(File, []) :-
  ( vs(smc_lang(cil)) ; vs(smc_lang(yul)) ),
  !,
  catch( inprog:compile(File), Catcher,
   map_error( (write(compile(File)), write(': '), write(Catcher)) )
  ).
map_read_file(File, Terms) :-
  catch( open(File, read, Stream), Catcher,
    map_error( (write(open(File, read, Stream)), write(': '), write(Catcher)))),
  map_read_terms(Stream,Terms).

% MODE: map_read_file(+Steam)
% SEMANTICS: read all terms from Stream and store them into the database
map_read_terms(Stream,TermsOut) :-
  read(Stream,Term),
  Term \== end_of_file,
	!,
  ( Term = (:- _) ->
    ( eval_directive(Term), TermsOut = TermsOut1 )
  ;
    ( process_term(Term, TermOut), TermsOut = [TermOut|TermsOut1] )
  ),
  map_read_terms(Stream, TermsOut1).
map_read_terms(Stream,[]) :-
  close(Stream).

% MODE: eval_directive(+TermIn)
% SEMANTICS: try to expand the TermIn and assert the result TermOut
eval_directive(TermIn) :-
  ( map_term_expansion(TermIn,TermOut) ->
		map_assert_list(TermOut)
	;
	  map_error((write('Cannot evaluate directive: '),write(TermIn)))
	).

%
user:map_term_expansion((:- assert(Term)),[user:Term]).

%
user:map_term_expansion((:- logic L),[user:vs(logic(L))]).

% ignore discontiguous
user:map_term_expansion((:- discontiguous _),[]).

% L is a predicate (Name/Arity)
%user:map_term_expansion((:- prop L),[user:vs(prop(L))]).
% L is a predicate (Name/Arity)
user:map_term_expansion((:- query L),[user:vs(query(L))]).

% L is a predicate (Name/Arity)
user:map_term_expansion((:- ignore P),[user:vs(ignore_pred(P))]).

% MODE: map_terms(+TermIn,-TermOut)
% SEMANTICS: convert TermIn into a pair of the form (Pred,(Head,Body))
% TermIn represent a clause of the form Head :- Body
process_term(TermIn, TermOut) :-
  TermIn  = (Head :- Body),
	!,
	functor(Head,Name,Arity),
	TermOut = (Name/Arity,(Head,Body)).
% TermIn represents a fact
process_term(TermIn, TermOut) :-
	functor(TermIn,Name,Arity),
	TermOut = (Name/Arity,(TermIn,true)).

% MODE: map_assert_list(+Clauses)
% SEMANTICS: assert the list of clauses Clauses into the database
map_assert_list([]).
map_assert_list([Cl|Cls]) :-
  asserta(Cl),
  map_assert_list(Cls).

% MODE: map_load_inprog
% SEMANTICS: load terms representing clauses into the database
map_load_inprog([]) :-
  % TODO: move this code in map_load_inprog_
  findall( Cl, (
    retract(inprog:r_clause(Head,Body)),
    canonical_cls(Head,Body, Cls), member(Cl,Cls),
    functor(Head,P,N),
    assert(cc_inprog:cc(P/N,Cl)) ),
    _ ),
  abolish(inprog:r_clause/2).
map_load_inprog([Term|Terms]) :-
  map_load_inprog_(Term),
	map_load_inprog(Terms).

% (for invoking) add a clause into the database within the 'inprog' module
map_load_inprog_(Term) :-
	Term = (Pred,(Head,Body)),
	get_transformer_option(inprog_invokable,Pred:true),
  ( Body == true ->
    assertz(inprog:Head)
  ; (
    conj_to_list(Body,BodyLst),
    constr(BodyLst,Constr,Atoms), % REVIEW
    ( list_to_rat_constraint(Constr,C) ->
      ( list_to_conj(Atoms,B) ->
        assertz(inprog:(Head :- (C,B)))
      ;
        assertz(inprog:(Head :- C))
      )
    ;
      ( list_to_conj(Atoms,B), assertz(inprog:(Head :- B)) )
    ))
  ),
	% if the following query fail,
	% then it forces backtracking for evaluating next clause
	\+ get_transformer_option(inprog_canonical_conversion,Pred:true).
% (for unfolding) convert clause into canonical form and add it into the
% database within the 'cc_inprog'
map_load_inprog_(Term) :-
	Term = (Pred,(Head,Body)),
	get_transformer_option(inprog_canonical_conversion,Pred:true),
	conj_to_list(Body,BodyLst),
  canonical_cls(Head,BodyLst, Cls),
	findall(_, (member(Cl,Cls), assertz(cc_inprog:cc(Pred,Cl))), _),
	!. % no more clauses for rule/3 to be evaluated
% display and warning if neither 'inprog_canonical_conversion' nor
% 'inprog_invokable' hold for the predicate of Term
map_load_inprog_(Term) :-
	Term = (_Pred,Cl),
  map_warning((write(Cl), write(': not added to the database'))).

%
map_inprog(Cls) :-
  findall(Cl, cc_inprog:cc(_,Cl), Cls).

% ------------------------------------------------------------------------------
map_write_outprog(Cls) :-
  vs(output_filename(SpecProg)),
  map_write_outprog(Cls,SpecProg).
%
map_write_outprog(Cls,FileName) :-
  tell(FileName), % open FileName
  ( vs(logic(L)) ->
    ( write(':- logic '), write(L), write('.'), nl, nl )
  ;
    true
  ),
  ( vs(many_sorted_CHCs) ->
    show_types(Cls)
  ;
    true
  ),
  % write ignore directive
  show_ignore(Cls),
  % write query directive
  show_query,
  % write spec directive
  %show_prog_spec,
  % write clauses
  show_cls(Cls),
  told.           % close FileName

show_ignore(Cls) :-
  preds_in_cls(Cls,[],Preds),
  show_ignore_aux(Preds).

show_ignore_aux([]).
show_ignore_aux([Pred|Preds]) :-
  vs(ignore_pred(Pred)),
  !,
  ( write(':- ignore '), write(Pred), write('.'), nl, nl ),
  show_ignore_aux(Preds).
show_ignore_aux([_|Preds]) :-
  show_ignore_aux(Preds).

show_query :-
  vs(query(L)),
  ( write(':- query '), write(L), write('.'), nl ),
  fail.
show_query :-
  nl.

% ---
signal_handler(SIGNAL) :-
  SIGNAL == alrm,
  write('Caught signal '), write(SIGNAL), write(' - I am going to terminate the transformation process.'), flush_output, halt.

signal_handler(_SIGNAL) :-
  true.
