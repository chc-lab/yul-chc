:- module(inprog,[]).

:- multifile r_clause/2.
:- dynamic r_clause/2.
:- discontiguous r_clause/2, tr/2, tr/3.

types:functor_signature('tr', 2, [ Type, Type ], Type).

initGLB(Env,C) :-
    evm_globals(EG),
    free_vars(EG, EnvFree),   % All evm variables are free
    globals(Gs),
    zero_init(Gs, EnvZero,C), % Set all user-defined variables to 0
    append(EnvFree,EnvZero, Env).
% empty stack
initSTK([]). 
% memory
initMEM(Env,C) :-
    memory(F),
    zero_init(F, Env,C).
freeMEM(Env) :-
    memory(F),
    free_vars(F, Env).      
% EVM
initEVM(Env,C) :-
    evm_globals(E),
    zero_init(E, Env,C).  
freeEVM(Env) :-
    evm_globals(E),
    free_vars(E, Env).
freeEVM(EnvI, EnvO) :-
    evm_globals(E),
    free_vars(E,EnvI, EnvO).          
% free_vars/2: environment of free variables   
free_vars([], []).
free_vars([Id|Ids], [(Id,_)|Gs]):-
    free_vars(Ids, Gs).
% free_vars/3: free variables in Ids    
free_vars([],[], []).
free_vars([I|_Ids],[(J,_)|EnvI], [(I,_)|EnvI]) :-
    I == J.   
free_vars([I|Ids],[(J,V)|EnvI], [(J,V)|EnvO]) :-
    I \== J,
    free_vars(Ids,EnvI, EnvO).    
% environment of zero-initialized variables
zero_init([], [],[]).
zero_init([Id|Ids], [(Id,V)|Gs],[V=0|Vs]):-
    zero_init(Ids, Gs,Vs).


% initial configuration
r_clause( 
    initConf( Cf0 ), [
        initConf_env1(Env1,_),
        %%% FROM start_contract
        startPP(L1),
        at(L1,C1),
        %%% TO   end of start_contract -- contract deployed on the blockchain
        nextlab(L1,L2), 
        at(L2,C2),
        initConf_env2(Env1, Env2),
        %%% deployed
        reachable(cf(cmd(L1,C1),Env1),cf(cmd(L2,C2),Env2)),
        prop(Env2, Cf0,_)
    ]
).
startPP('start_contract').
initConf_env1(Env1,C) :-
    initGLB(D,C1), 
    initMEM(M,C2),
    initSTK(S), 
    update((D,M,S),'msg.value',V,Env1), 
    append(C1,C2,C3),
    append(C3,[V=0],C).

%
initConf_env2(Env1, Env2) :-
    Env1 = (D,M,S),
    copy_term((D,M),(CpyD,CpyM)), 
    Env2 = (CpyD,CpyM,S). % Stack does not change (function w/o ret *)

% ----------------------
% error configuration  
r_clause(   
    errorConf(cf(cmd(_,_),Env1),cf(cmd('panic_error_0x01',abort),Env2)), [
        copy_term(Env1,Env2)  
    ]
).

%%%
enabled(L) :-
    fun('subO_panic_error_0x01',_,_,L),
    !,
    fail. 
enabled(L) :-
    fun('r_Auction_86_deployed',_,_,L),
    !,
    fail.   
enabled(_).   

% ==============================================================================
% Incorrectness and Reachability relation
% ==============================================================================
r_clause(incorrect, [   
    initConf(Cf1), 
    reachable(Cf1,Cf2),
    errorConf(Cf1,Cf2)
]).

% ------------------------------------------------------------------------------
% basis case
r_clause(
    reachable(Cfg,Cfg), [
]).
% recursive case
r_clause(
  reachable(Cfg1,Cfg3), [
    tr(Cfg1,Cfg2,_Cns),
    reachable(Cfg2,Cfg3)
]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LOOKUP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lookup_evm(K, (D,_,_), V) :- 
    is_evm(K), 
    lookup_list(K,D, V).

% lookup utility predicate
% lookup_list(+I,+L, -V,-L1) holds iff
% V is the value of I in L1, and
% L1 is L if I occurs in L, otherwise L1 is L extended with the pair (I,V).
lookup_list(I,[(J,V)|_], V) :-
    I == J.
lookup_list(I,[(J,_)|L], V) :-
    I \== J, 
    lookup_list(I,L, V).        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update for storage locations
update((D,M,S),off(K),NV, (D1,M,S)) :-
    update_list(D,K,NV, D1).

% update for memory locations
update((D,M,S),mem(K),NV, (D,M1,S)) :-
    update_list(M,K,NV, M1).    

% update per evm variables
update((D,M,S),K,NV, (D1,M,S)) :-
    is_evm(K),
    update_list(D,K,NV, D1).

% update for local variables
update((D,M,S),var(K),NV, (D,M,S1)) :-  
    update_list(S,K,NV, S1).

% update utility predicate
update_list([(I,_)|E],I,NV, [(I,NV)|E]).
update_list([(I,V)|E],J,NV, [(I,V)|E1]) :-
    I \= J,
    update_list(E,J,NV, E1).  

% lookup/update utility predicate
is_evm(K) :- 
    atom(K),
    evm_globals(E), 
    member(K,E).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% tr %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -----
% abort
tr( cf(cmd(L,_), Env),
    cf(cmd('panic_error_0x01',abort), Env), [] ) :-
        fun('subO_panic_error_0x01',_,_,L). % L is the entry point of 'subO_panic_error_0x01'

% ------------------
% unconditional jump
tr(cf(cmd(L,goto(L1)), Env), cf(cmd(L1,C), Env), []) :-
    enabled(L),
    at(L1,C).

% ----------------
% conditional jump 
% Il valore di X può essere ottenuto direttamente dalla memoria S
% So L1 ==>false, L2 ==>true
% è vero che V0 è 0? si quindi va in L1 
% è vero che V0 è 0? no quindi va in L2 
tr(cf(cmd(L, cj(V0,L1,_L2)), Env), cf(cmd(L1,C), Env), [X0=0|Cns]) :-
    enabled(L),
    eval_arg(V0,Env, X0,Cns), % TODO: sempre local, quindi lookup  
    at(L1,C).
tr(cf(cmd(L, cj(V0,_L1,L2)), Env), cf(cmd(L2,C), Env), [X0=1|Cns]) :-
    enabled(L), 
    eval_arg(V0,Env, X0,Cns),  
    at(L2,C).

% ----------
% assignment
% assignment and then specialise eval with as many clauses as necessary (lt, gt, etc.) 
% eval(name_op([input list]), (global_environment, memory, local_environment), output)
% also for functions that return precise values (address, gas, balance)
tr(cf(cmd(L, asgn(X,expr(E))), Env), cf(cmd(L1,C), Env1), Cns) :-
    enabled(L),
    eval(E,Env, V,Cns), 
    update(Env,X,V,Env1), 
    nextlab(L,L1),
    at(L1,C).

% --------------------------------
% sstore(p, v) ==> storage[p] := v
tr(cf(cmd(L, sstore([V0, var(V1)])), (D,M,F)), FinalConfig,Cns) :- 
    enabled(L),  
    lookup_list(V1,F, K2), 
    tr(cf(cmd(L, sstore([V0, K2])), (D,M,F)), FinalConfig,Cns).
% 
tr(cf(cmd(L, sstore([V0, off(V1)])), Env), cf(cmd(L1,C), Env1),Cns) :-
    enabled(L),
    eval_arg(V0,Env, X0,Cns), 
    update(Env,off(V1),X0, Env1),
    nextlab(L,L1),
    at(L1,C).

% -------------------------------------
% mstore(p, v) ==> mem[p...(p+32)) := v 
% mstore(v, p)
tr(cf(cmd(L, mstore([V0,var(V1)])), (D,M,F)), FinalConfig,Cns) :-  
    enabled(L),
    lookup_list(V1,F, K2), 
    tr(cf(cmd(L, mstore([V0, mem(K2)])), (D,M,F)), FinalConfig,Cns).
%
tr(cf(cmd(L, mstore([V0,mem(V1)])), Env), cf(cmd(L1,C), Env2), Cns) :-
    enabled(L),
    eval_arg(V0,Env, X0,Cns),
    update(Env, mem(V1), X0, Env2),
    nextlab(L, L1),
    at(L1,C).    

% mstore8(p, v) ==> mem[p] := v & 0xff (only modifies a single byte)
% mstore(v, p)
tr(cf(cmd(L, mstore8([V0, V1])), Env), cf(cmd(L1, C), Env1), []) :-
    enabled(L),
    eval_arg(V0,Env, V),    % V = valore da memorizzare
    pl_ops((V2 is 0xff, NewByte is V /\ V2)),     
    update(Env,V1, NewByte,Env1),    
    nextlab(L, L1),
    at(L1, C).

% -------------
% function call
r_clause(
    tr(cf(cmd(L, fun_call(F, InputList, OutputList)), Env), Cf3,[]), [
        enabled(L),
        call( ( write(' *** fun_call: '), write(F), nl, nl ) ),
        map_log(finest,( write(' *** fun_call: '), write(F), nl, nl) ),
        % fun_call_prologue also prepares env. of (final callee environment)
        fun_call_prologue(F,InputList,Env, Cf1,Cf2,_Cs1), 
        reachable(Cf1, Cf2),
        fun_call_epilogue(F,L,OutputList,Cf2,Env, Cf3,_Cs2)
        ]
).
% function call prologue
fun_call_prologue(F,InputList,Env, cf(cmd(FL,C),Env1),Cf2,Cns) :-
    % Evaluate function inputs
    eval_list(InputList,Env,[], Vs,Cs1),
    % Build frame for parameters and local variables
    build_funenv_invert(F,Vs, Frame,Cs2), append(Cs1,Cs2,Cns),
    Env = (D,M,_S), Env1 = (D,M,Frame),
    % Function entry point
    firstlab(F, FL), at(FL, C),
    % final callee environment (a copy of the initial env)
    copy_term((D,M,Frame),(CpyD,CpyM,CpyFrame)), 
    Env2 = (CpyD,CpyM,CpyFrame),
    Cf2 = cf(_Cmd, Env2). 
% function call epilogue
% regular
fun_call_epilogue(F,L,OutputList,Cf1,Env2, Cf2, Cs) :-
    % retrieve F ret instruction
    atom_concat(F,'_ret',LR), at(LR,ret(ReturnVars)), 
    Cf1 = cf(cmd(LR, ret(ReturnVars)), Env1),
    % Evaluate function ret 
    eval_outputs(ReturnVars,Env1,[], EvaluatedOutputs,Cs),
    % Update callee environment
    assign_outputs(OutputList, EvaluatedOutputs, Env2, Env3),
    % command to be extecuted after function return
    nextlab(L, L2), 
    at(L2, C2),
    Env1 = (D,M,_),
    Env3 = (_,_,Loc),
    Env4 = (D,M,Loc),
    Cf2 = cf(cmd(L2,C2), Env4).
% revert
fun_call_epilogue(F,L,_OutputList,Cf1,_Env0, Cf2,Cns) :- 
    % retrieve any revert of F
    at(L1, revert(R)), atom_concat(F,_,L1),  
    Cf1 = cf(cmd(L1, revert(R)), _Env),
    %%
    initGLB(D0,Cns), % User-def set to 0; EVM var: free
    %%
    freeMEM(M0), % MEM var: free
    %%
    initSTK(S0),
    nextlab(L, L2), % NOTE: re-using the label of the command at L2
    Cf2 = cf(cmd(L2, revert(R)), (D0,M0,S0)).
% return
fun_call_epilogue(F,L,_OutputList,Cf1,_Env0, Cf2,[]) :-
    % retrieve any return of F
    at(L1,return(R)), atom_concat(F,_,L1),  
    Cf1 = cf(cmd(L1, return(R)), Env),
    %%
    freeEVM(Env,(D0,_,_)), % User-def: unaltered; EVM var: free
    %%
    freeMEM(M0), % MEM var: free
    %%
    initSTK(S0),
    nextlab(L, L2), % WARNNOTEING: re-using the label of the command at L2
    Cf2 = cf(cmd(L2, return(R)), (D0,M0,S0)).
% panic
fun_call_epilogue(_F,_L,_OutputList,Cf1,Env0, Cf2, []) :-
    Cf1 = cf(cmd(panic_error_0x01, abort), Env1),
    Env0 = (_,_,Rest),
    Env1 = (D,M,_), Env2 = (D,M,Rest),
    Cf2 = cf(cmd(panic_error_0x01, abort), Env2).
% function prologue auxiliary predicates
%
eval_list([],_Env,Cs, [],Cs).
eval_list([off(K)|Es],Env,CsI, [off(K)|Vs],CsO):- 
    eval_list(Es,Env,CsI, Vs,CsO).
eval_list([E|Es],Env,CsI, [V|Vs],CsO):-
    E \= off(_),
    eval_arg(E, Env, V,C),
    append(CsI,C,CsI1), % TODO: add accumulator
    eval_list(Es,Env,CsI1, Vs,CsO).
% 
build_funenv(F, Vs, Frame) :- 
    fun(F, Params, Locals, _Entry),
    build_params_frame(Params, Vs, FrameParams),
    initialize_locals(Locals, FrameLocals),
    append(FrameParams, FrameLocals, Frame).
%
pair_params_values([], [], []).
pair_params_values([var(K)|Ps], [V|Vs], [(K, V)|Rest]) :-
    pair_params_values(Ps, Vs, Rest).
%
build_params_frame_invert(Params, Vs, Frame) :-
    inverti_lst(Params, ParamsInv),
    pair_params_values(ParamsInv, Vs, Frame).
%
build_funenv_invert(F,Vs, Frame,Cns) :-
    fun(F, Params, Locals, _Entry),
    build_params_frame_invert(Params, Vs, FrameParams),
    initialize_locals(Locals, FrameLocals,Cns),
    append(FrameParams, FrameLocals, Frame).
%
build_params_frame([], [], []).
build_params_frame([var(K)|Ps], [V|Vs], [(K, V)|FrameParams]) :- 
    build_params_frame(Ps, Vs, FrameParams).
% 
initialize_locals([], [],[]).
initialize_locals([var(K)|Ls], [(K,V)|FrameLocals],[V=0|Vs]) :- 
    initialize_locals(Ls, FrameLocals,Vs).
% retrieve F's entry point
firstlab(F, FL) :- 
    fun(F, _Params, _Locals, FL).
%
% function epilogue auxiliary predicates
eval_outputs([],_Env,Cs, [],Cs).
eval_outputs([V|Vs],Env,CsI, [Val|Vals],CsO) :- 
    eval_arg(V,Env,Val, C),
    append(CsI,C,CsI1),
    eval_outputs(Vs,Env,CsI1, Vals,CsO).
%
assign_outputs([], [], Env, Env).
assign_outputs([var(Key)|RestVars],[Val|RestVals],Env, Env2) :- 
    update(Env,var(Key),Val,Env1),
    assign_outputs(RestVars,RestVals,Env1, Env2).
%
inverti_lst(Lista, ListaInvertita) :-
    inverti_lst_acc(Lista, [], ListaInvertita).
% inverti_lst auxiliary predicate
inverti_lst_acc([], Acc, Acc).
%
inverti_lst_acc([Testa|Coda], Acc, ListaInvertita) :-
    inverti_lst_acc(Coda, [Testa|Acc], ListaInvertita).

% ----------------------------------------------------------------------------
% pop(x)
% v1
tr(cf(cmd(L, pop([V0])), Env), cf(cmd(L1, C), Env)) :-
    eval_arg(V0,Env, _Value), % TODO: check _Value
    nextlab(L, L1),
    at(L1, C).
% v2
tr(cf(cmd(L, pop([V0])), Env), cf(cmd(L1, C), Env1)) :-
    update(Env,V0,_, Env1), % TODO: check _
    nextlab(L, L1),
    at(L1, C).

% extcodecopy(a, t, f, s) ==> like codecopy(t, f, s) but take code at address a
tr(cf(cmd(L, extcodecopy([_V0, _V1, V2, _V3])), (D,M,S)), cf(cmd(L1,C), (D, M1, S))) :-
    eval_arg(V2, (D,M,S), T0),
    format(atom(T1), '0x~16r', [T0]),
    update((D,M,S), mem(T1), 0, (D, M1, S)),
    nextlab(L, L1),
    at(L1, C).

% returndatacopy(t, f, s) ==> copy s bytes from returndata at position f to mem at position t
% returndatacopy(s, f, t)
tr(cf(cmd(L, returndatacopy([V0, V1, V2])), (D,M,S)), cf(cmd(L1,C), (D, M1, S))) :-
    eval_arg(V0, (D,M,S), S0),
    eval_arg(V1, (D,M,S), F0),
    eval_arg(V2, (D,M,S), T0),
    format(atom(T1), '0x~16r', [T0]),
    lookup_evm('returndata',(D,M,S), Data),
    slice_memory(Data, F0, S0, RetunData),
    update((D,M,S),mem(T1),RetunData,(D, M1, S)),
    nextlab(L, L1),
    at(L1, C).

% mcopy(t, f, s) copy s bytes from mem at position f to mem at position t
tr(cf(cmd(L, mcopy([S0, F0, T0])), (D, M, S)), cf(cmd(L1, C), (D, M1, S))) :-
    eval_arg(S0, (D, M, S), S1),
    (F0 = var(_) ->
        eval_arg(F0, (D, M, S), F1),
        format(atom(F),'0x~|~`0t~16r~2+' , [F1]), 
        eval_arg(mem(F), (D, M, S), F2)
    ;   
        F0 = mem(_) ->
        eval_arg(F0, (D, M, S), F2)
    ),
    slice_memory(F2, 0, S1, NV), 
    atom_concat('0x', NV, NV2),
    atom_number(NV2, NV3),
    ( T0 = var(_) ->
        (eval_arg(T0, (D, M, S), T2), 
        format(atom(T), '0x~|~`0t~16r~2+' , [T2]),
        update((D, M, S), mem(T), NV3, (D, M1, S)) )
    ; (T0 = mem(_) ->     
        % T0 is of the form mem(_)
        update((D, M, S), T0, NV3, (D, M1, S)) ; true )
    ),
    nextlab(L, L1),
    at(L1, C).

% codecopy(s, f, t)
tr(cf(cmd(L, codecopy([_S0, _F0, T0])), (D, M, S)), cf(cmd(L1, C), (D, M1, S))) :-
    eval_arg(T0, (D, M, S), T1),
    format(atom(T), '0x~|~`0t~16r~2+', [T1]),
    pl_ops((NV is 100)),
    update((D, M, S), mem(T), NV, (D, M1, S)),
    nextlab(L, L1),
    at(L1, C).

% create(v, p, n) ==> create new contract with code mem[p…(p+n)) and 
%                     send v wei and return the new address; 
%                     returns 0 on error
tr(cf(cmd(L, create([V0, V1, V2])), (D,M,S)), cf(cmd(L1,C), (D1, M, S))) :-
    eval_arg(V0, (D,M,S), N),
    eval_arg(V1, (D,M,S), P),
    eval_arg(V2, (D,M,S), W),
    slice_memory(M, P, N, Code),
    create_contract(W, Code, (D,M,S), NewAddr),
    update_global(D, NewAddr, W, D1),
    nextlab(L, L1),
    at(L1, C). 

% create2(v, p, n, s)
% create new contract with code mem[p…(p+n)) 
% at address keccak256(0xff . this . s . keccak256(mem[p…(p+n)))
% create2(s, n, p, v)
tr(cf(cmd(L, create2([V0, V1, V2, V3])), (D,M,S)), cf(cmd(L1,C), (D1, M, S))) :-
    eval_arg(V0, (D,M,S), S),
    eval_arg(V1, (D,M,S), N),
    eval_arg(V2, (D,M,S), P),
    eval_arg(V3, (D,M,S), W),
    slice_memory(M, P, N, Code),
    create_contract(W, Code, (D,M,S), NewAddr),
    update_global(D, NewAddr, W, D1),
    nextlab(L, L1),
    at(L1, C). 

% event
% Considering that they return nothing in the code and have no effect on the environment, 
% they are written but basically do nothing at least for the moment 
% (it will be seen if they need to be changed in future implementations)
tr(cf(cmd(L, log0([_S0, _P0])), (D, M, S)), cf(cmd(L1,C), (D, M, S))) :- 
    nextlab(L,L1), at(L1,C).
tr(cf(cmd(L, log1([_T1, _S0, _P0])), (D, M, S)), cf(cmd(L1, C), (D, M, S))) :- 
    nextlab(L,L1), at(L1,C).
tr(cf(cmd(L, log2([_T2, _T1, _S0, _P0])), (D, M, S)), cf(cmd(L1,C), (D, M, S))) :- 
    nextlab(L,L1), at(L1,C).
tr(cf(cmd(L, log3([_T3, _T2, _T1, _S0, _P0])), (D, M, S)), cf(cmd(L1,C), (D, M, S))) :- 
    nextlab(L,L1), at(L1,C).
tr(cf(cmd(L, log4([_T4, _T3, _T2, _T1, _S0, _P0])), (D, M, S)), cf(cmd(L1,C), (D, M, S))) :- 
    nextlab(L,L1), at(L1,C).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calldatacopy(t, f, s)
tr(cf(cmd(L, calldatacopy([S0, F0, T0])), (D, M, S)), cf(cmd(L1, C), (D, M1, S))) :-        
    eval_arg(F0, (D, M, S), F),            % initial offset of calldata
    eval_arg(S0, (D, M, S), Size),         % numero di byte to copy
    lookup_evm('calldata', (D, M, S), CD), % retrieve calldata
    slice_memory(CD, F, Size, Data),       % retrieve calldata (CD) 
    atom_concat('0x', Data, Full), 
    atom_number(Full, NV),
    ( T0 = var(_) -> (
        eval_arg(T0, (D, M, S), T2),
         % T0 is a local variable
        format(atom(T), '0x~16r', [T2]),
        update((D, M, S), mem(T), NV, (D, M1, S))
        )
    ; ( T0 = mem(_) -> 
         %  T0 is of the form mem(_), use T0
        update((D, M, S), T0, NV, (D, M1, S)) ; true 
      )
    ),
    nextlab(L, L1),
    at(L1, C).


%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr( cf(cmd(L,call([_V0,_V1,_V2,_V3,V4,_V5,V6],R0)), Env0), cf(cmd(L1,C), Env3),Cns) :-
        eval_arg(V6, Env0, Gas,C1),
        eval_arg(V4, Env0, Wei,C2),
        append(C1,C2,C3), 
        retDatas(Gas,Wei,Env0, RetData,C4),
        append(C3,C4,C5),
        update_after_call(Env0,Gas,Wei,RetData, Env2,C6),
        append(C5,C6,Cns),
        update(Env2, R0, RetData, Env3),
        nextlab(L, L1),
        at(L1, C).   

update_after_call(Env0,Gas,Wei,RetData, 
    Env2,[RetData=1, NewGas=X1-Gas, NewBalance=X2-Wei]) :- 
        lookup_evm('gas',Env0, X1), 
        lookup_evm('balance',Env0, X2),
        update(Env0,'gas',NewGas, Env1),
        update(Env1,'balance',NewBalance, Env2).
update_after_call(Env0,_Gas,_Wei,RetData, 
    Env0,[RetData=0]).   

%%%
%%% eval_arg %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% logic variable
eval_arg(X,_Env, X,[]) :-
    var(X).
% number
eval_arg(A,_Env, V,[V=X]) :-
    nonvar(A),
    A = num(X).
% offset
eval_arg(A,(D,_,_), V,[V=X]) :- 
    nonvar(A),
    A = off(K),
    nonvar(K),
    !,
    lookup_list(K,D,X). 
eval_arg(A,(D,_,_), V,[K=I,V=X]) :- 
    nonvar(A),
    A = off(K),
    var(K),
    member((I,X),D), integer(I).
% var
eval_arg(A,(D,M,F), V,C) :-
    nonvar(A),
    A = var(K),
    lookup_list(K,F, T),
    eval_arg(T,(D,M,F), V,C).
% mem
eval_arg(A,(_,M,_), V,[V=X]) :-
    nonvar(A),
    A = mem(K),
    lookup_list(K,M,X).

%%%
%%% eval %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% iszero
eval(iszero([V0]),Env, V1,[X0=0,V1=1|Cns]) :- 
    eval_arg(V0,Env, X0,Cns).
eval(iszero([V0]),Env, V1,[X0=\=0,V1=0|Cns]) :- 
    eval_arg(V0,Env, X0,Cns). 
%% eq
% in YUL documentation the syntax is eq(x, y) for the rule 'if x == y, 0 otherwise', 
% in the Json file the input sono invertiti: eq(y, x)
eval(eq([V0,V1]),Env, V2,[X0=Y0,V2=1|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
eval(eq([V0,V1]),Env, V2,[X0=\=Y0,V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
%% lt
% in YUL documentation the syntax is lt(x, y) for the rule 'if x < y, 0 otherwise', 
% in the Json file the input are inverted: lt(y, x) 
% so, V0 = y e V1 = x  
eval(lt([V0,V1]),Env, V2,[X0<Y0, V2=1|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
eval(lt([V0,V1]),Env, V2,[X0>=Y0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
% gt
% in YUL documentation the syntax is gt(x, y) for the rule 'if x > y, 0 otherwise', 
% in the Json file the input are inverted: gt(y, x) 
% so, V0 = y e V1 = x  
eval(gt([V0,V1]),Env, V2,[X0>Y0, V2=1|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
eval(gt([V0,V1]),Env, V2,[X0=<Y0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
%% slt
% in YUL documentation the syntax is slt(x, y),  1 if x < y 0 otherwise, for signed numbers
% in the Json file the input are inverted: slt(y, x)
eval(slt([V0,V1]),Env, V2,[X0<Y0, V2=1|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
eval(slt([V0,V1]),Env, V2,[X0>=Y0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
%% sgt
% in YUL documentation the syntax is sgt(x, y),  1 if x > y 0 otherwise, for signed numbers
% in the Json file the input are inverted: sgt(y, x)
eval(sgt([V0,V1]), Env, V2,[X0>Y0, V2=1|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
eval(sgt([V0,V1]), Env, V2,[X0=<Y0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns).
%% add
% in YUL documentation the syntax is add(x, y) for the rule 'x + y', 
% in the Json file the input are inverted: add(y, x) 
% so, V0 = y e V1 = x  
eval(add([V0,V1]),Env, V2,[V2=X0+Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2),
    append(C1,C2,Cns). 
% sub
% in YUL documentation the syntax is sub(x, y) for the rule 'x - y', 
% in the Json file the input are inverted: sub(y, x) 
% so, V0 = y e V1 = x  
eval(sub([V0,V1]),Env, V2,[V2=X0-Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2), 
    append(C1,C2,Cns).
%% TODO: mul
% TODO: handling of potentially non-linear constraints
% https://www.swi-prolog.org/pldoc/man?section=clpqr
% in YUL documentation the syntax is mul(x, y) for the rule 'x * y', 
% in the Json file the input are inverted: mul(y, x) 
% so, V0 = y e V1 = x  
eval(mul([V0,V1]), Env, V2,[V2=X0*Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1),
    eval_arg(V1,Env, X0,C2), 
    append(C1,C2,Cns).
%% div
% TODO: handling of potentially non-linear constraints
% seel CIL idiv
% in YUL documentation the syntax is div(x, y) for the rule 'x / y', 
% 0 if y == 0
% in the Json file the input are inverted: div(y, x) 
% so, V0 = y e V1 = x  
eval(div([V0,V1]),Env, V2,[Y0=\=0, V2=X0/Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1), 
    eval_arg(V1,Env, X0,C2), 
    append(C1,C2,Cns).
eval(div([V0,_V1]),Env, V2,[Y0=0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,Cns).
%% TODO: sdiv
% seel CIL idiv
% for signed numbers in two’s complement
% in YUL documentation the syntax is sdiv(x, y) for the rule 'x / y', 
% 0 if y == 0
% in the Json file the input are inverted: sdiv(y, x) 
% so, V0 = y e V1 = x  
eval(sdiv([V0,_V1]),Env, V2,[Y0 =:= 0, V2 = 0]) :- 
    eval_arg(V0, Env, Y0).
eval(sdiv([V0, V1]),Env, V2,[]) :- 
    eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0),   
    % Signed integer conversion: if the value is >= 2^255 then 
    % it represents a negative: the conversion is made by subtracting 2**256
    (Y0 < 2**255 -> SY = Y0 ; pl_ops((SY is Y0 - 2**256))),
    (X0 < 2**255 -> SX = X0 ; pl_ops((SX is X0 - 2**256))),
    % Performing integer division with sign
    pl_ops((SRes is SX div SY)),
    %V2 = SRes.
    % Conversion of result to 256-bit format: if negative, we add 2^256
    (SRes < 0 -> pl_ops((V2 is SRes + 2**256)) ; V2 = SRes).
%% TODO: mod
% seel CIL idiv
% in YUL documentation the syntax is mod(x, y) for the rule x % y, 
% 0 if y == 0 
% in the Json file the input are inverted: mod(y, x) 
% so, V0 = y e V1 = x  
eval(mod([V0,V1]), Env, V2, [Y0=\=0, V2= X0 mod Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1),
    eval_arg(V1,Env, X0,C2), 
    append(C1,C2,Cns).
eval(mod([V0,_V1]), Env, V2,[Y0=0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,Cns).
%% TODO: smod
% for signed numbers in two’s complement
% in YUL documentation the syntax is smod(x, y) for the rule x % y, 
% 0 if y == 0 
% in the Json file the input are inverted: smod(y, x) 
% so, V0 = y e V1 = x 
eval(smod([V0,_V1]), Env, V2,[]) :- eval_arg(V0, Env, Y0), Y0 =:= 0, V2 = 0.
eval(smod([V0, V1]), Env, V2,[]) :- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0),   
    % Signed integer conversion: if the value is >= 2^255 then
    %  it represents a negative: the conversion is made by subtracting 2**256
    (Y0 < 2**255 -> SY = Y0 ; pl_ops((SY is Y0 - 2**256))),
    (X0 < 2**255 -> SX = X0 ; pl_ops((SX is X0 - 2**256))),
    % Performing integer division with sign
    pl_ops((SRes is SX rem SY)), 
    %for the result to have the same sign as x (the dividend) we use rem (IntExpr1 - (IntExpr1 // IntExpr2) × IntExpr2)
    % Conversion of result to 256-bit format: if negative, we add 2^256
    (SRes < 0 -> pl_ops((V2 is SRes + 2**256 )); V2 = SRes).
%% TODO: exp
% https://www.swi-prolog.org/pldoc/man?section=clpqr
% in YUL documentation the syntax is exp(x, y) for the rule x ^ y, 
% in the Json file the input are inverted: exp(y, x) 
% so, V0 = y e V1 = x  
eval(exp([V0,V1]),Env, V2,[V2=X0^Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C1),
    eval_arg(V1,Env, X0,C2), 
    append(C1,C2,Cns).
%% TODO: addmod
% in YUL documentation the syntax is addmod(x, y, m)
% (x + y) % m with arbitrary precision arithmetic, 0 if m == 0 
% in the Json file the input are inverted: addmod(m, y, x)
eval(addmod([V0,_V1,_V2]),Env, V3,[M0 =:= 0, V3 = 0]) :- 
    eval_arg(V0,Env, M0).
eval(addmod([V0,V1,V2]),Env, V3,[V3 is (Y0 + X0) mod M0]) :- 
    eval_arg(V0,Env, M0),
    eval_arg(V1,Env, Y0),
    eval_arg(V2,Env, X0).
%% TODO: mulmod
% in YUL documentation the syntax is mulmod(x, y, m)
% (x * y) % m with arbitrary precision arithmetic, 0 if m == 0 
% in the Json file the input are inverted: addmod(m, y, x)
eval(mulmod([V0,_V1, _V2]),Env, V3,[M0 =:= 0, V3 = 0]) :- 
    eval_arg(V0, Env, M0).
eval(mulmod([V0,V1,V2]),Env, V3,[V3 is (Y0 * X0) mod M0]) :- 
    eval_arg(V0, Env, M0),
    eval_arg(V1, Env, Y0),
    eval_arg(V2, Env, X0).
%% PhiFunction
eval(phiFunction([V0]),Env, V2,[V1=V2|Cns]) :- 
    eval_arg(V0,Env, V1,Cns).
%% Bitwise ‘and’ returns 1 if both operands are 1, and 0 otherwise 
% In Yul: and(x, y), but in the Json file the input are inverted: 
eval(and([V0, V1]),Env, V2,[Y0=\=0, X0=\=0, V2=X0|Cns]) :-
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).
eval(and([V0,_V1]),Env, V2,[Y0=0, V2=0|Cns]) :-
    eval_arg(V0,Env, Y0,Cns).
eval(and([V0, V1]),Env, V2,[Y0=\=0, X0=0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).
%% Bitwise ‘or’ returns 1 if at least one operand is 1, else 0
eval(or([V0,V1]),Env, V2,[Y0=0,   X0=0,   V2=0|Cns]) :-  
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).
eval(or([V0,V1]),Env, V2,[Y0=\=0, X0=0,   V2=Y0|Cns]) :-  
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).    
eval(or([V0,V1]),Env, V2,[Y0=0,   X0=\=0, V2=X0|Cns]) :-  
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).
% TODO:    
eval(or([V0,V1]),Env, V2,[Y0=\=0, X0=\=0, V2=_|Cns]) :-  
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).        
%% TODO: Bitwise “xor” of x and y
eval(xor([V0, V1]),Env, V2,[V2 = X0 xor Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).    
%% bitwise negation not
% Calculates the 256-bit complement of the argument
% eval(not([V0]), Env, V2) :- Mask is (2^256 - 1), eval_arg(V0, Env, X), V2 is Mask - X.
eval(not([V0]),Env, V2,[V2 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - X|Cns]) :-
    eval_arg(V0,Env, X,Cns).
%% TODO: byte(n, x)
%nth byte of x, where the most significant byte is the 0th byte
% in the Json file the input are inverted: byte(x,n)
eval(byte([_V0, V1]), Env, V2,[N0 > 31, V2 = 0]) :- 
    eval_arg(V1, Env, N0).
% moves the desired byte to the least significant digits by integer division
% and isolate that byte by applying the modulus 256
eval(byte([V0, V1]), Env, V2,[V2 = (X0 // (256**(31 - N0))) mod 256]) :- 
    eval_arg(V0, Env, X0), eval_arg(V1, Env, N0). 
%% shl
% shl(x, y) ==> logical shift left y by x bits
%  in the Json file the input are inverted: shl(y,x)
eval(shl([V0,_V1]),Env, V2,[Y0=0, V2=0|Cns]) :- 
    eval_arg(V0,Env, Y0,Cns).
eval(shl([V0, V1]),Env, V2,[Y0=\=0, X0=0, V2=Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).
% TODO: overapproximation (V2 is free) - aggiungere il vincolo
% eval(shl([V0, V1]),Env, V2,[Y0 =\= 0, X0 =\= 0 |Cns]) :-
%     eval_arg(V0,Env, Y0,C0), eval_arg(V1,Env, X0,C1), append(C0,C1,Cns).%, pl_ops((V2 is Y0 << X0)).
% shr(x, y) ==> logical shift right y by x bits
% in the Json file the input are inverted: shr(y,x)
eval(shr([V0,_V1]),Env, V2,[Y0 = 0, V2 = 0|Cns]) :- 
    eval_arg(V0,Env, Y0,Cns).
eval(shr([V0, V1]),Env, V2,[Y0 =\= 0, X0 = 0, V2 = Y0|Cns]) :- 
    eval_arg(V0,Env, Y0,C0),
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,Cns).
% TODO: overapproximation (V2 is free) - aggiungere il vincolo
% eval(shr([V0, V1]),Env, V2,[Y0 =\= 0, X0 =\= 0 |Cns]) :- 
%     eval_arg(V0,Env, Y0,C0), eval_arg(V1,Env, X0,C1), append(C0,C1,Cns). %, pl_ops((V2 is Y0 >> X0)).
% TODO: signed arithmetic shift right y by x bits
% in YUL documentation the syntax is sar(x, y)
% % in the Json file the input are inverted: sar(y, x)
eval(sar([V0, V1]), Env, V2,[]):-
    eval_arg(V0,Env, Y0,C0),      
    eval_arg(V1,Env, X0,C1),
    append(C0,C1,_Cns),     
    (X0 < 2**255 -> SX = X0 ; pl_ops((SX is X0 - 2**256))),
    (Y0 >= 256 -> ( SX < 0 -> SRes = -1 ; SRes = 0)
     ; pl_ops((SRes is SX >> Y0))      
    ),
    (SRes < 0 -> pl_ops((V2 is SRes + 2**256)) ; V2 = SRes).
%% built-in ops to copy bytes from the code or the size of the code, 
% for our purpose these are not needed, so we assign a constant
eval(datasize,_, V1,[V1=0]).
eval(dataoffset,_, V1,[V1=0]).
eval(codesize,_, V1,[V1=0]).
%%TODO: keccak256(p, n)  ==> keccak256(n, p)
eval(keccak256([V0, V1]),Env, V2,[]) :-
    eval_arg(V0,Env, N0),     % N0 = numero di byte da considerare
    eval_arg(V1,Env, P0),     % P0 = offset iniziale in memoria 
    Env = (_,M,_),
    slice_memory(M,P0,N0, Data),   % Data = segmento di memoria corrispondente
    hash_data(Data, V2).           % V2 = keccak256(Data)
%%TODO: blockhash(b) ==> hash of block nr b - only for last 256 blocks excluding current
eval(blockhash([V0]),Env, V1,[V1 is (BN * 42) mod (2^256)|Cns]) :-
    eval_arg(V0,Env, BN,Cns).
%%TODO: extcodesize(a) ==> size of the code at address a
eval(extcodesize([_V0]),_, V1,[V1=0]).
%%TODO: returndatasize() ==> size of the last returndata
eval(returndatasize,Env, V1,[]) :-
    ( lookup_evm('returndata', Env, Data) ->
        format(atom(DataEsa),'0x~|~`0t~16r~2+', [Data]),
        string_length(DataEsa, LenHex),
        (  LenHex =:= 0, pl_ops((V1 is 0))
        ;
            pl_ops((V1 is LenHex // 2))
        )
    ).
%%TODO: extcodehash(a) ==> code hash of address a
eval(extcodehash([V0]),Env, V1,[]) :-
    eval_arg(V0, Env, A0),
    format(atom(A1), '0x~16r', [A0]),
    hash_data(A1, V1).
%%TODO: callcode(g, a, v, in, insize, out, outsize)
eval(callcode([V0, V1, V2, V3, V4, V5, V6]),Env, R0,[]):-
    eval_arg(V0,Env, Gas),
    eval_arg(V1,Env, A0),
    format(atom(_Addr), '0x~16r', [A0]),
    eval_arg(V2,Env, Wei),
    eval_arg(V3,Env, _InOff),
    eval_arg(V4,Env, _InSize),
    eval_arg(V5,Env, _OutOff),
    eval_arg(V6,Env, _OutSize),
    retDatas(Gas, Wei,Env, RetData),
    pl_ops((R0 is RetData)).
%%TODO: staticcall(g, a, in, insize, out, outsize)
%staticcall(outsize, out, insize, in, a, g)
eval(staticcall([V0, V1, V2, V3, V4, V5, V6]),Env, R0,[]):- 
    eval_arg(V0,Env, Gas),
    eval_arg(V1,Env, A0),
    format(atom(_Addr), '0x~16r', [A0]),
    eval_arg(V2,Env, Wei),
    eval_arg(V3,Env, _InOff),
    eval_arg(V4,Env, _InSize),
    eval_arg(V5,Env, _OutOff),
    eval_arg(V6,Env, _OutSize),
    retDatas(Gas, Wei,Env, RetData),    
    pl_ops((R0 is RetData)).
%TODO: delegatecall(g, a, in, insize, out, outsize)
%delegatecall(outsize, out, insize, in, a, g)
eval(delegatecall([V0, V1, V2, V3, V4, V5, V6]),Env, R0,[]):- 
    eval_arg(V0,Env, Gas),
    eval_arg(V1,Env, A0),
    format(atom(_Addr), '0x~16r', [A0]),
    eval_arg(V2,Env, Wei),
    eval_arg(V3,Env, _InOff),
    eval_arg(V4,Env, _InSize),
    eval_arg(V5,Env, _OutOff),
    eval_arg(V6,Env, _OutSize),
    retDatas(Gas, Wei,Env, RetData),
    pl_ops((R0 is RetData)).
%TODO: msize() 	 size of memory, i.e. largest accessed memory index
%knowing that memory is represented as a list of key-value pairs where the key is the slot and to respect EVM semantics for msize 32 bytes are added.
% if the maximum index accessed is 0x40 (64 in decimal), this means that at least one byte of the block starting at 0x40 and covering 
%addresses 0x40 to 0x5F has been used: the size of the allocated memory (msize) must be 64 + 32 = 96 bytes.
eval(msize, (_D, M, _S), V,[]) :-
    findall(Int, ( member((Key, _), M), atom_number(Key, Int) ), Keys),
    ( Keys = [] ->
          V = 0
    ; max_list(Keys, Max),
        (   Max =:= 0, pl_ops((V is 32))
            ;
            Max =:= 1, pl_ops((V is 32*2))
            ;
            pl_ops((V is (Max*32)+ 32)) 
        )
    ).
%% gas
eval(gas,Env, V1,[V1=X0]) :-
    lookup_evm('gas',Env, X0).
%% address
eval(address, Env, V1,[V1=X0]) :- 
    lookup_evm('address',Env, X0).
%% balance(a) ==> wei balance at address a 
eval(balance([V0]),Env, V1,[V1=X0|Cns]) :-
    eval_arg(V0,Env, V2,Cns1),
    eval_arg(off(V2),Env, X0,Cns2), 
    append(Cns1,Cns2,Cns).
%% selfbalance
eval(selfbalance,Env, V1,[V1=X0]) :- 
    lookup_evm('balance',Env, X0).
%% caller
eval(caller,Env, V1,[V1=X0]) :- 
    lookup_evm('msg.sender',Env, X0).
%% callvalue
eval(callvalue,Env, V1,[V1=X0]):- 
    lookup_evm('msg.value',Env, X0).
%% TODO: calldataload    
eval(calldataload([_V0]),Env, V1,[X0=0,V1=X0]) :- 
    lookup_evm('calldata',Env, X0).
%% TODO: calldatasize
eval(calldatasize,Env, _V1,[]) :- 
    lookup_evm('calldata',Env, _X0).    
%% chainid
eval(chainid,Env, V1,[V1=X0]) :- 
    lookup_evm('chainid',Env, X0).
%% basefee
eval(basefee,Env, V1,[V1=X0]) :- 
    lookup_evm('basefee',Env, X0).
%% origin
eval(origin,Env, V1,[V1=X0]) :- 
    lookup_evm('tsender',Env, X0).
%% gasprice 
eval(gasprice,Env, V1,[V1=X0]) :- 
    lookup_evm('gprice',Env, X0).
%% coinbase
eval(coinbase,Env, V1,[V1=X0]) :- 
    lookup_evm('mbeneficiary',Env, X0).
%% timestamp
eval(timestamp,Env, V1,[V1=X0]) :- 
    lookup_evm('timestamp',Env, X0).
%% number
eval(number,Env, V1,[V1=X0]) :- 
    lookup_evm('bnumber',Env, X0).
%% prevrandao
eval(prevrandao,Env, V1,[V1=X0]) :- 
    lookup_evm('prevrandao',Env, X0).
%% gaslimit
eval(gaslimit,Env, V1,[V1=X0]) :- 
    lookup_evm('glimit',Env, X0).
%% TODO: memoryguard
% The memoryguard call indicates that all memory accesses respect this restriction,
% does not change the state so it is treated as a skip for now.
eval(memoryguard,_Env, V1,[V1=128]).
%% TODO: signextend(i, x) ==> sign extend from (i*8+7)th bit counting from least significant
% signextend(x, i)
eval(signextend([V1, V0]),Env, V2,[]) :-
    eval_arg(V0, Env, I),  % I = byte index (0..31)
    eval_arg(V1, Env, X),  % X = number to be extended
    pl_ops((BitPos is (I + 1) * 8 - 1)), % position of the sign bit
    pl_ops((SignBit is 1 << BitPos)),
    ( (X /\ SignBit =\= 0) ->
        ( % if 1, extend by 1 (negative result)
         pl_ops((Mask is (2^256 - 1) - ((1 << (BitPos+1)) - 1))),
         pl_ops((V2 is X \/ Mask)) )
    ;   (
         pl_ops((Mask is (1 << (BitPos+1)) - 1)),
         pl_ops((V2 is X mod (Mask+1))) )
    ).
%% memory operations
%% mload(p) ==> mem[p…(p+32)).
% Legge dalla memory (M)
eval(mload([V0]),Env, V1,[V1=X0|Cns]):- 
    eval_arg(V0,Env, X0,Cns).
%%%%%
eval(sload([off(Key)]),Env, Value,Cns) :-
    eval_arg(off(Key),Env, Value,Cns).  
eval(sload([var(V0)]),Env, V1,Cns) :- 
    Env = (_,_,F),
    lookup_list(V0, F, K),
    ( ( nonvar(K), K = off(_) ) -> 
        eval(sload([K]), Env, V1,Cns) 
    ; 
        eval(sload([off(K)]), Env, V1,Cns)
    ). 

%
retDatas(Gas, Wei, Env, RetData, [X1 =< Gas,X2 < Wei, RetData = 0]) :- 
    lookup_evm('gas', Env, X1), 
    lookup_evm('balance', Env, X2).
retDatas(Gas, Wei, Env, RetData, [X1 > Gas, X2 < Wei, RetData = 0]) :- 
    lookup_evm('gas', Env, X1), 
    lookup_evm('balance', Env, X2).
retDatas(Gas, Wei, Env, RetData, [X1 =< Gas,X2 >= Wei, RetData = 0]) :- 
    lookup_evm('gas', Env, X1), 
    lookup_evm('balance', Env, X2).
retDatas(Gas, Wei, Env, RetData, [X1 > Gas,X2 >= Wei, RetData = 1]) :- 
    lookup_evm('gas', Env, X1), 
    lookup_evm('balance', Env, X2).

%
update_after_call(Env, Gas, Wei, Env2):-
    lookup_evm('gas', (D, M, S), X1), 
    lookup_evm('balance', (D, M, S), X2),
    pl_ops(NewGas is X1 - Gas),
    pl_ops(NewBalance is X2 - Wei),
    update(Env, 'gas', NewGas, Env1),
    update(Env1, 'balance', NewBalance, Env2),
    writeln('gas:', NewGas),
    writeln('balance:', NewBalance).

%
hash_data(Data, Hash) :-
    % SHA3-256 (Keccak-256) algorithm
    crypto_data_hash(Data, HashHex, [algorithm(sha3_256)]),
    atom_concat('0x', HashHex, FullHex),
    atom_number(FullHex, Hash).

slice_memory(M, P, N, Data) :-
    ( number(M) ->
        format(atom(MStr), '~16r', [M])
    ; atom(M) ->
        MStr = M
    ),
    pl_ops((Start is P * 2)),
    pl_ops((Len is N * 2)),
    string_length(MStr, ML),
    (   ML >= Start ->
        pl_ops((Available is ML - Start))
    ; 
        Available = 0
    ),
    ( Available >= Len ->
        sub_atom(MStr, Start, Len, _, Data)
    ;
        ( Available > 0 ->
            sub_atom(MStr, Start, Available, 0, PartD)
         ;
            PartD = ''
        ),
        Missing is Len - Available,
        findall('0', between(1, Missing, _), ZerosList),
        atomic_list_concat(ZerosList, Zeros),
        atom_concat(PartD, Zeros, Data)
    ).

% create new contract
create_contract(W, Code, _Env, NewAddr) :-
    ( ( Code == '' 
        % lookup_evm('balance', Env, X0), X0 < W  
        % TODO: check if enough gas is available
      ) ->
        %creation fails
        NewAddr = 0
    ; % new addresss
        ( new_contract_address(W, Code, NewAddr), NewAddr > 0 )
    ).

new_contract_address(_V, _Code, NewAddr):- 
    random_between(1001, 9999, NewAddr).

