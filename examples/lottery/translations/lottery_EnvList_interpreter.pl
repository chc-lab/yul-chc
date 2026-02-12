:- discontiguous tr/2.

evm_globals([
    %'address',
    'balance',
    'gas',
    'msg.sender',
    'calldata', 
    'msg.value',
    'basefee', 
    'bnumber', 
    'chainid', 
    'glimit', 
    'gprice', 
    'mbeneficiary',     
    'prevrandao', 
    'returndata',
    'timestamp', 
    'tsender'
]).


initGLB(Name, E) :-
    globals(Name, G),
    initGlbVar(G, Env0),          % Inizializza le variabili di globals a 0
    evm_globals(EG),
    initGlbEnv(EG, EnvFree),      % Inizializza le variabili di evm_globals con variabili libere
    append(Env0, EnvFree, E).      % Unisce le due liste in E
    %E = [K, L],  

% user defined global variables
initGlbVar([],[]).

initGlbVar([(address, Addr)|Tail], [(address, Addr)|TailOut]) :-
    initGlbVar(Tail, TailOut).

initGlbVar([Id|Tail], [(Id,0)|TailOut]) :-
    %Id non coincide con address
    \+ Id = (address,_),
    initGlbVar(Tail, TailOut).

% evm (global) variables
initGlbEnv([],[]).
initGlbEnv([Id|Ids], [(Id,_)|Gs]):-
    initGlbEnv(Ids,Gs).


% TODO by EMA: non aggiungere l'empty list nello stack vuoto -- lo inseriamo direttamente nella reach di init
% Caso base: lo stack parte con un frame vuoto.
initStackEnv([], [[]]). 
initStackEnv([Id|Ids], [[(Id,_)|Frame] | Rest]) :-  
    initStackEnv(Ids, [Frame | Rest]).  

%se si volessero aggiungere le locals nel file di traduzione si può usare questo per inizializzare 
%initLocals(S):-
%    locals(K,F),
%    initStackEnv(F, L),
%    S = [K, L],
%    writeln(S).

initMem(E) :-
    memory(K, F),
    initGlbMem(F, E).
   % E = [K, L],

initGlbMem([],[]).
initGlbMem([Id|Ids], [(Id,V)|Fs]):-
    V = 0,
    initGlbMem(Ids,Fs).

initAddress(A):-
    address(A), 
    !.


initEList([],[]).
%initEList([Id|Ids], [[(Id,V)]|Fs]):-
%    V = 0,
%    initEList(Ids,Fs).

initEnvList(EL) :-
    %env(F),
    initEList([], EL),
    writeln(EL), 
    nl,nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

%inizializza l'env per un singolo contratto identificato da Name
initEnv(Name, Env) :-
    %globals(Name, G),
    initGLB(Name, D), 
    initMem(M),
    initStackEnv([], S),
    Env = (Name, (D, M, S)).


%inizializza l'env per un singolo contratto identificato da Name
%poi lo aggiunge alla EnvList
initEnvsList(Name, Env, EnvList) :-
    %globals(Name, G),
    initGLB(Name, D), 
    initMem(M),
    initStackEnv([], S),
    Env = (Name, (D, M, S)), 
    initEnvList(EL),
    update_env(EL, Name, [Env], EnvList).    


% costruisce le configuration iniziali (cf) per tutti i contratti
initConfFor(Name, CfInit) :-
    %initEnv(Name, Env),
    initEnvsList(Name, Env, EnvList), 
    lookup_env(Name, EnvList, EnvF),

    initAddress(ADDRESS),

    pl_ops((V0 is 0)),
    update(Env, 'msg.value', V0, Env1),
    pl_ops((V22 is 0x812600df)),
    update(Env1,'calldata', V22 ,Env1_1),
    pl_ops((V00 is 100)),
    update(Env1_1, 'bnumber', V00, Env2),

    
    L1 = 'start_contract',

    at(Name, L1, C1),

    writeln(''),
    writeln(['CONTRATTO: ', Name]),
    writeln(''),
    
    Env2 = (Name, (D,M,S)),
    %Cf1 = cf(cmd(Name, L1, C1), Env2),
    update_env(EnvList, Name, [Env2], EnvList2),

    lookup_env(Name, EnvList2, EnvF),
    Cf1 = cf(cmd(Name, L1, C1), EnvList2),

    nextlab(Name, 'start_contract', L2),
    at(Name, L2, C2),

    %Cf2 = cf(cmd(Name, L2, C2),Env3), 
    Cf2 = cf(cmd(Name, L2, C2), EnvList3), 
    reachable(Cf1,Cf2),

    lookup_env(Name, EnvList3, Env3),
    updateevm_(Env3, Env9),

    %updateevm_(Env1, Env9),
    %CfInit = cf(cmd(Name, L2, C2), Env9).
    
    update_env(EnvList3, Name, [Env9], EnvList4),
    CfInit = cf(cmd(Name, L1, C1), EnvList4).   



%
initConfFor2(Name, IList, CfInit):-
    initEnv(Name, Env),
    initAddress(ADDRESS),
    update_init_env(Env, IList, Env2),
    L1='start_contract',
    at(Name, L1, C1),
    CfInit = cf(cmd(Name, L1, C1), Env2),
    nextlab(Name, 'start_contract', L2),
    at(Name, L2, C2),
    Cf2 = cf(cmd(Name, L2, C2),Env3),
    reachable(Cf1,Cf2).




update_init_env(Env, IList, Envf):-
    IList=[Wei, Gas, Sender, Calldata, Wei], 
    update(Env,'balance', Wei, Env1), 
    update(Env1,'gas', Gas , Env2), 
    update(Env2,'msg.sender', Sender , Env3),
    create_calldata(Calldata,Env3, CD), 
    update(Env3,'calldata', CD , Env4), 
    update(Env4,'msg.value', Wei, Envf).



%[0,50,0xabc123,0x812600df00000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000005,20]

% exec(Name) : inizializza tutti i contratti e poi esegue il contratto Name
exec(Name) :-
%exec(Name, List) :-
    %initConfFor3(Name, List, Cf0),

    initConfFor(Name, Cf0),

    Cf0 = cf(_Cmd, EnvList),

    lookup_env(Name, EnvList, Env0),

    nl, nl, 
    writeln([' Name: ', Name]),
    nl,
    writeln([' CfInit: ', Cf0]),
    nl, 
    %
    % costruisci la configuration di partenza 
    %Cf1 = cf(cmd(Name, 'subO_external_fun_enter_77_Block0_3', fun_call(subO_fun_enter_77, [], [])), EnvList),                %sol_v1_p1
	%Cf1 = cf(cmd(Name, 'subO_external_fun_enter_44_Block0_3', fun_call(subO_fun_enter_44, [], [])), EnvList),               %yul_v1_p1
    %Cf1 = cf(cmd(Name, 'subO_external_fun_enter_76_Block0_3', fun_call(subO_fun_enter_76, [], [])), EnvList),               %sol_v1_p2
    %Cf1 = cf(cmd(Name, 'subO_external_fun_enter_47_Block0_3', fun_call(subO_fun_enter_47, [], [])), EnvList),               %yul_v1_p2
    %Cf1 = cf(cmd(Name, 'subO_external_fun_enter_88_Block0_3', fun_call(subO_fun_enter_88, [], [])), EnvList),               %sol_v1_p4
    Cf1 = cf(cmd(Name, 'subO_external_fun_enter_59_Block0_3', fun_call(subO_fun_enter_59, [], [])), EnvList),               %sol_v1_p4


    reachable(Cf1, Cf2),
    Cf2 = cf(cmd(Name, L1, Cmd), EnvList2),
    %Cf2 = cf(cmd(Name, L1, Cmd), Env2),
    nl, nl, writeln('in exec:'), writeln(EnvList2), nl,
	%L1 = 'subO_external_fun_enter_77_Block0_4',                     %sol_v1_p1
	%L1 = 'subO_external_fun_enter_44_Block0_4',                    %yul_v1_p1
    %L1 = 'subO_external_fun_enter_76_Block0_4',                    %sol_v1_p2
	%L1 = 'subO_external_fun_enter_47_Block0_4',                    %yul_v1_p2
    L1 = 'subO_panic_error_0x01_Block0_3',                         %sol_v1_p4
    %L1 = 'subO_panic_error_0x01_Block0_3',                         %yul_v1_p4




    nl, write('command: '), writeln(Cmd),
    
    lookup_env(Name, EnvList2, Env2),

    Env2 = (Name, (D,M,S)),
    write('environment: '), nl,
    writeln('    storage: '), print_list(D), nl,
    writeln('    memory:  '), print_list(M), nl,
    writeln('    stack:   '), print_list(S).


% error configuration    
error_conf(cf(_Cmd,_Env)) :- 
    true.

incorrect :- initConf(Cf1), reachable(Cf1,Cf2), error_conf(Cf2).

reachable(C,C).
reachable(C,C2) :- tr(C,C1), reachable(C1,C2).


% exec utility predicate
print_list([]).
print_list([H|T]) :- 
    write('            '), writeln(H),
    print_list(T).

pl_ops(PLOP) :- PLOP.

% instruction for TESTING purposes
updateevm_(Env2, Envf) :- 

    pl_ops((V100 is 80)), 
    update(Env2,'gas', V100 , Env3), 
    pl_ops((V101 is 10000000000000000)), 
    update(Env3,'msg.value', V101 ,Env4),     % deve essere esattamente 0.01 eth
    pl_ops((V6 is 0xabc123)), 
    update(Env4,'msg.sender', V6 ,Env5), 
    pl_ops((V20 is 100000000000000000)),        % 10 * 100.000.000.000.000.000 
    update(Env5,'balance', V20 ,Env6),
    pl_ops((V22 is 0xa6606acb)),
    update(Env6,'calldata', V22 ,Env9),
    pl_ops((V00 is 10)), 
        update(Env9, off(0x00), V00 , Env10), 		%impostiamo playerCount = 10
    pl_ops((V01 is 100)), 
        update(Env10, off(0x01), V01 , Env11), 		%impostiamo start = 100
    pl_ops((V02 is 100)), 
        update(Env11, off(0x02), V02 , Env12), 		%impostiamo duration = 100    
    pl_ops((V03 is 130)), 
        update(Env12,'bnumber', V03 , Env13), 		%impostiamo bnumber = 130 (il numero del blocco corrente)  
    pl_ops((V04 is 0xabc123)), 
        update(Env13, off(0x04), V04 , Env14), 		%impostiamo dei valori per i players  
    pl_ops((V05 is 0xabc123)), 
        update(Env14, off(0x05), V05 , Envf). 		%impostiamo dei valori per i players  




%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LOOKUP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EMA: se chiami questa funzione sai che stai recuperando una evm variable, 
% quindi si può utilizzare direttamente look_globlal
lookup_evm(K, (Con, (D,_,_)), V) :- 
    is_evm(K), 
    lookup(K,D, V).
% lookup utility predicate
% lookup(+I,+L, -V,-L1) holds iff
% V is the value of I in L1, and
% L1 is L if I occurs in L, otherwise L1 is L extended with the pair (I,V).
lookup(I,[(J,V)|_], V) :-
    I == J.
lookup(I,[(J,_)|L], V) :-
    I \== J, 
    lookup(I,L, V).        

lookup_local(var(K), (Con, (D,M,[F|Fs])), V):-
    lookup(K,F, V).

lookup_address(K, F, Con) :-
    address(Pairs),
    ( member((K, V), Pairs)
    -> ( F = 1, Con = V)  % mantieni il nome del contratto o metti F a 1? 
    ;  (F = 0)  % se non trovo l'indirizzo 
    ).






% cerca la coppia (I, Frame) in EnvList e unifica Frame
%lookup_env(I, EnvList, V) :-
%    writeln(['SITUAZIONE', I, EnvList]),
%    member((I, Frame), EnvList),   
%    V =  (I, Frame),
%    writeln(['SITUAZIONE', Frame, V]).

% opzionale: default / fallback (se vuoi che fallisca invece di ritornare 0, rimuovila)

%lookup_env(_, _, 0).

lookup_env(I,[[(J,V)]|L], Res) :-
    I == J, 
    V = [Res], !.  

lookup_env(I,[[(J,_)]|L], V) :-
    I \== J, 
    lookup_env(I,L, V).     

lookup_env(I, [], V):-
    V=0.




% update_env(EnvList, Name, NewValue, EnvList2)
% - se Name esiste aggiorna la prima occorrenza
% - se Name non esiste aggiunge un nuovo frame in testa: [[(Name,NewValue)]|EnvList]
update_env(EnvList, Name, NewV, EnvList2) :-
    (   update_existing_env(EnvList, Name, NewV, EnvList2)
         ->  true
        ;   
        EnvList2 = [[','(Name, NewV)] | EnvList]
    ).

% update_existing_env(Env, Name, NewV, EnvOut)
% aggiorna la prima occorrenza; fallisce se Name non è presente
% Pair = ','(CName,Value)
update_existing_env([[Pair]|Rest], Name, V1, [[NewPair]|Rest]) :-
    % controlla il Name e aggiorna
    Pair =.. [',' , CName, _V],
    CName == Name,
    NewPair =.. [',' , Name, V1], !.

update_existing_env([Head|Tail], Name, NewV, [Head|Tail2]) :-
    update_existing_env(Tail, Name, NewV, Tail2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%% EVAL ARGUMENTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temporary code
eval_arg(X,_Env, X) :-
    var(X).
% temporary code    
eval_arg(X,_Env, X) :-
    integer(X).

eval_arg(num(X),_Env, V) :-
    V = X.

% Se abbiamo off(K) allora cerchiamo nella memoria globale
eval_arg(off(K), (Con,(D,_,_)), V) :-
    lookup(K,D,V). 

% Se abbiamo var(K) allora cerchiamo nella memoria locale
eval_arg(var(K), (Con,(D,M,[F|Fs])), V) :-
    lookup(K,F, T),
    eval_arg(T, (Con, (D,M,[F|Fs])), V).

% Se abbiamo mem(K) allora cerchiamo nella memory (M)
eval_arg(mem(K),(Con, (_,M,_)), V) :-
    lookup(K,M, V).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% is_offset e is_variable distingue tra chiavi di memoria (0x...) e variabili (v0, v1, ...), 
% aggiornando D se la chiave è un offset e S se è una variabile.
% Se la chiave non è trovata, la aggiunge nella memoria corretta (in D non è possibile aggiungere variabili)

is_evm(K) :- 
    atom(K), 
    member(K, 
    ['gas','address','msg.sender','msg.value','balance','calldata', 'chainid', 
    'basefee', 'tsender', 'gprice', 'mbeneficiary', 'timestamp', 'bnumber', 'glimit', 'prevrandao', 'returndata']).

% update((D, M, S), K, NV, (D1, M, S)) - Aggiorna D se K è un offset
update((Con, (D, M, S)), off(K), NV, (Con, (D1, M, S))) :-
    update_global(D, K, NV, D1), !.

% update per evm 
update((Con, (D, M, S)), K, NV, (Con, (D1, M, S))) :-
    is_evm(K),
    update_global(D, K, NV, D1), !.

% update((D, M, S), K, NV, (D, M, S1)) - Aggiorna S se K è una variabile locale
% (in SSA non si aggiornano le variabili locali ma se necessario si crea una nuova assegnazione)
update((Con, (D, M, S)), var(K), NV, (Con, (D, M, S1))) :-  
    update_local(S, K, NV, S1), !.

% update((D, M, S), K, NV, (D, M1, S)) - Aggiorna M se K è una chiave di memoria (es. per mstore)
update((Con, (D, M, S)), mem(K), NV, (Con, (D, M1, S))) :-
    update_mem(M, K, NV, M1), !.

% Aggiorna D se la chiave esiste
update_global([], K, NV, [(K, NV)]).
update_global([(K, _)|T], K, NV, [(K, NV)|T]) :- !.
update_global([H|T], K, NV, [H|T1]) :-
    H = (Key, _),
    Key \= K,
    update_global(T, K, NV, T1).

% Aggiorna M se la chiave esiste (simile a update_global)
update_mem([], K, NV, [(K, NV)]).
update_mem([(K, _)|T], K, NV, [(K, NV)|T]) :- !.
update_mem([H|T], K, NV, [H|T1]) :-
    H = (Key, _),
    Key \= K,
    update_mem(T, K, NV, T1).

% Aggiunge nel top frame dello stack: 
% se la chiave esiste, la sostituisce, altrimenti la aggiunge in testa al frame.
/*update_local([Frame|Rest], K, NV, [NewFrame|Rest]) :-
    ( select((K, _Old), Frame, FrameRest) ->
        NewFrame = [(K, NV) | FrameRest]
    ;   
        NewFrame = [(K, NV) | Frame]
    ).*/

update_local([Frame|Rest], K, NV, [NewFrame|Rest]) :-
    select((K, _Old), Frame, FrameRest),
    NewFrame = [(K, NV) | FrameRest].
% update_evm(+D, -DNew)
% DNew è l'ambiente D aggiornato, in cui per ogni chiave evm il valore viene impostato a 0.
update_evm(D, DNew) :-
    evm_globals(EvmKeys),   % recupera la lista delle chiavi evm
    update_evm_keys(EvmKeys, D, DNew).

% Caso base: nessuna chiave evm da aggiornare, l'ambiente resta invariato.
update_evm_keys([], D, D).

% Per ogni chiave evm K, aggiorna D e continua ricorsivamente
update_evm_keys([K|Rest], D, DNew) :-
    update_global(D, K, _, D1),
    update_evm_keys(Rest, D1, DNew).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% tr %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -----
% abort
tr( cf(cmd(Con, L,C), Env),
    cf(cmd('panic_error_0x01', abort(cmd(Con, L, C))), Env) ) :-
        atom_concat('subO_panic_error_0x01_',_, L).

% ------------------
% unconditional jump
tr(cf(cmd(Con, _L, goto(L1)), Env), cf(cmd(Con, L1, C), Env)) :- 
    at(Con, L1,C).

% conditional jump 
% Il valore di X può essere ottenuto direttamente dalla memoria S
% So L1 ==>false, L2 ==>true
% è vero che V0 è 0? si quindi va in L1 
% è vero che V0 è 0? no quindi va in L2 
tr(cf(cmd(Con, _L, cj(V0,L1,_L2)), EnvList), cf(cmd(Con, L1, C), EnvList)) :- 
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    eval_arg(V0, Env, X0), % TODO: sempre local, quindi lookup
    X0 =:= 0, 
    at(Con, L1,C).
tr(cf(cmd(Con, _L, cj(V0,_L1,L2)), EnvList), cf(cmd(Con, L2,C), EnvList)) :- 
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    eval_arg(V0, Env, X0), 
    X0 =:= 1,
    at(Con, L2,C).

% assignment
% assignment and then specialise eval with as many clauses as necessary (lt, gt, etc.) 
% eval(name_op([input list]), (global_environment, memory, local_environment), output)
% also for functions that return precise values (address, gas, balance)
tr(cf(cmd(Con, L, asgn(X,expr(E))), EnvList), cf(cmd(Con, L1,C), EnvList1)) :-  
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    eval(E,Env,V), 
    update(Env,X,V,Env1), 
    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),
    nextlab(Con, L,L1),
    at(Con, L1,C).

% sstore(p, v) ==> storage[p] := v
tr(cf(cmd(Con, L, sstore([V0, var(V1)])), EnvList), FinalConfig) :-   
    lookup_env(Con, EnvList, Env),
    Env = (Con, (D,M,[F|Fs])),
    lookup(V1,F, K2), 
    tr(cf(cmd(Con, L, sstore([V0, K2])), EnvList), FinalConfig).
% 
tr(cf(cmd(Con, L, sstore([V0, off(V1)])), EnvList), cf(cmd(Con, L1,C), EnvList1)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    %eval_arg(V0, (D,M,S), X0), 
    eval_arg(V0, Env, X0), 
    update(Env, off(V1), X0, Env1),
     %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),
    nextlab(Con, L, L1),
    at(Con, L1,C),
    writeln(['envlist1', EnvList1]).

tr(cf(cmd(Con, L, sstore([V0, V1])), EnvList), FinalConfig) :-
    tr(cf(cmd(Con, L, sstore([V0, off(V1)])), EnvList), FinalConfig).



% mstore(p, v) ==> mem[p...(p+32)) := v 
% mstore(v, p)
/*tr(cf(cmd(Con, L, mstore([V0, V1])), (D,M,S)), cf(cmd(Con, L1,C), (D,M1,S))):-
    eval_arg(V0, (D,M,S), X0),
    update((D,M,S), V1, X0, (D,M1,S)),
    nextlab(Con, L,L1), 
    at(Con, L1,C). */
tr(cf(cmd(Con, L, mstore([V0, var(V1)])), EnvList), FinalConfig) :- 
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    Env=(Con, (D,M,[F|Fs])),
    lookup(V1,F, K2), 
    tr(cf(cmd(Con, L, mstore([V0, mem(K2)])), EnvList), FinalConfig).
%
tr(cf(cmd(Con, L, mstore([V0, mem(V1)])), EnvList), cf(cmd(Con, L1,C), EnvList1)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    Env=(Con, (D,M,[F|Fs])),
    eval_arg(V0, Env, X0), 
    update(Env, mem(V1), X0, Env1),
    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),
    nextlab(Con, L, L1),
    at(Con, L1,C).


% mstore8(p, v) ==> mem[p] := v & 0xff (only modifies a single byte)
% mstore(v, p)
tr(cf(cmd(Con, L, mstore8([V0, V1])), EnvList), cf(cmd(Con, L1, C), EnvList1)) :-
     %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    Env=(Con, (D,M,[F|Fs])),
    eval_arg(V0, Env, V),    % V = valore da memorizzare
    pl_ops((V2 is 0xff, NewByte is V /\ V2)),     
    update(Env, V1, NewByte, Env1),    
    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),
    nextlab(Con, L, L1), 
    at(Con, L1, C).

% function call
tr(cf(cmd(Con, L, fun_call(F, InputList, OutputList)), EnvList), Cf3) :-
    %writeln(F),
    %devo farlo qui il lookup perchè non mi porto dietro il nome del contratto e non 
    %riuscire i ad estrarre l'Env
    fun_call_prologue(Con, F, InputList,EnvList, Cf1),

    reachable(Cf1, Cf2),
    fun_call_epilogue(L,OutputList,Cf2, Cf3).

% function call prologue
fun_call_prologue(Con, F, InputList,EnvList, cf(cmd(Con, FL, C), EnvList1)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env), 

    % Valuta gli input della funzione
    eval_list(InputList, Env, Vs),
    % Costruisce l'ambiente della funzione (frame dei parametri e variabili locali)
    build_funenv_invert(F, Vs, Frame),
    % Inserisce il nuovo frame nello stack
    push_frame(Env, Frame, Env1),  

    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),

    % Ottiene il label d'entrata della funzione e accede alla sua definizione
    firstlab(F, FL), at(Con, FL, C).


% function call epilogue
% regular
fun_call_epilogue(L,OutputList,Cf1, Cf2) :-

    Cf1 = cf(cmd(Con, _LR, ret(ReturnVars)), EnvList),

    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env1),

    % Valutiamo i valori di ritorno
    eval_outputs(ReturnVars, Env1, EvaluatedOutputs),
    % Rimuove il frame della funzione (torna nello stack del chiamante)
    pop_frame(Env1, Env2),
    % Associa in ordine i valori restituiti alle variabili indicate nella chiamata
    assign_outputs(OutputList, EvaluatedOutputs, Env2, Env3),

    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env3], EnvList3),
    % Passa al comando successivo, aggiornando il label
    nextlab(Con, L, L2), 
    at(Con, L2, C2),
    Cf2 = cf(cmd(Con, L2,C2), EnvList3).


% revert
fun_call_epilogue(_L,_OutputList,Cf1, Cf2) :- 
    Cf1 = cf(cmd(Con, L, revert([Sz, P])), EnvList),
    %%
    %write('****'), writeln(LC), writeln(Cf1),
    initGLB(Con, D0),
    initMem(M0), 
    %initGlbMem(F, M0),
    initStackEnv([], S0),
    %nextlab(Con, L, L2), 
    Env2 = (Con,(D0,M0,S0)),

    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env2], EnvList2),

    Cf2 = cf(cmd(Con, L, revert([Sz, P])), EnvList2).   

% return
fun_call_epilogue(_L,_OutputList,Cf1, Cf2) :-  
    Cf1 = cf(cmd(Con, L, return([Sz, P])), EnvList),
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env1),
    Env1=(Con, (D,_,_)),
    %%
    update_evm(D, D0), 
    %%
    %memory(F),
    %initGlbMem(F, M0),
    initMem(M0),
    initStackEnv([], S0),

    %aggiorna l'env generale 
    Env2= (Con,(D0,M0,S0)),
    update_env(EnvList, Con, [Env2], EnvList2),
    
    Cf2 = cf(cmd(Con, L, return([Sz, P])), EnvList2).

% ----------------------------------------------------------------------------
% pop(x)
% opzione 1:
% La regola per pop valuta l'argomento (che viene scartato) e passa al comando successivo senza modificare l'ambiente (D, M, S).
tr(cf(cmd(Con, L, pop([V0])), EnvList), cf(cmd(Con, L1, C), EnvList)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    eval_arg(V0, Env, _Value), % TODO by EMA: a che serve valutare l'argomento se lo scartiamo?
    nextlab(Con, L, L1),
    at(Con, L1, C).
% opzione 2: 
% La regola per pop valuta l'argomento (che viene resettato) e passa al comando successivo modificando l'ambiente locale (D, M, S1).
%tr(cf(cmd(Con, L, pop([V0])), Env), cf(cmd(Con, L1, C), Env1)) :-
%    update(Env, V0, _, Env1),
%    nextlab(Con, L, L1),
%    at(Con, L1, C).

% extcodecopy(a, t, f, s) ==> like codecopy(t, f, s) but take code at address a
% copia s byte del codice esterno associato all’indirizzo a, a partire dall’offset f, nella memoria alla posizione t
% extcodecopy(s, f, t, a,)

%come in codecopy:
% si assume che gli argomenti s, f e t siano variabili locali (var(...)) 
% perchè sono il risultato di chiamate ad altre op builtin come datasize e dataoffset che vengono inserite in variabili locali
%considerando che non dobbiamo realmente copiare il codice ci occupiamo solo di inserire una costante nella posizione t della memory

%TO DO: generare esempio per controllo 
tr(cf(cmd(Con, L, extcodecopy([_V0, _V1, V2, _V3])), EnvList), cf(cmd(Con, L1,C), EnvList1)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),

    eval_arg(V2, Env, T0),
    %format(atom(T1), '0x~16r', [T0]),
    %update((D,M,S), mem(T1), 0, (D, M1, S)),
    update(Env, mem(T0), 0, Env1),

    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),

    nextlab(Con, L, L1),
    at(Con, L1, C).

% returndatacopy(t, f, s) ==> copy s bytes from returndata at position f to mem at position t
% returndatacopy(s, f, t)
%sapendo che T è contenuto in una variaible locale, la valutiamo per ottenere il valore, lo riconvertiamo in esadecimale
%e lo utiliziamo come chiave per l'update in M
tr(cf(cmd(Con, L, returndatacopy([V0, V1, V2])), EnvList), cf(cmd(Con, L1,C), EnvList1)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),

    eval_arg(V0, Env, S0),
    eval_arg(V1, Env, F0),
    eval_arg(V2, Env, T0),
    %format(atom(T1), '0x~16r', [T0]),
    lookup_evm('returndata',Env, Data),
    slice_memory(Data, F0, S0, RetunData),
    %update((D,M,S),mem(T1),RetunData,(D, M1, S)),
    update(Env, mem(T0), RetunData, Env1),

    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),

    nextlab(Con, L, L1),
    at(Con, L1, C).

% mcopy(t, f, s) copy s bytes from mem at position f to mem at position t
% diventa mcopy(s, f, t) per l'inversione
%'0x~16r'
tr(cf(cmd(Con, L, mcopy([S0, F0, T0])), EnvList), cf(cmd(Con, L1, C), EnvList1)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),

    eval_arg(S0, Env, S1),
    (F0 = var(_) ->
        eval_arg(F0, Env, F1),
        %writeln(['F',  F])
        %format(atom(F),'0x~|~`0t~16r~2+' , [F1]), 
        %lookup_mem(F, M, F2) %valore in memory alla posizione f
        eval_arg(mem(F1), Env, F2)
    ;   
        F0 = mem(_) ->
        eval_arg(F0, Env, F2)
    ),
    slice_memory(F2, 0, S1, NV), %estrae S byte dalla posizione F1 in M e li salva in Data
    %converto nuovamente il valore in decimale
    atom_concat('0x', NV, NV2),
    atom_number(NV2, NV3),
    ( T0 = var(_) ->
        eval_arg(T0, Env, T2), % posizione di destinazione nella memoria
         % Se T0 è una variabile locale, converto il valore numerico in esadecimale con prefisso '0x' ==> '0x~16r'
        %format(atom(T), '0x~|~`0t~16r~2+' , [T2]),
        % T al posto di T2
        update(Env, mem(T2), NV3, Env1),
        %aggiorna l'env generale 
        update_env(EnvList, Con, [Env1], EnvList1)

    ; T0 = mem(_) ->
        
        % Se T0 è già del tipo mem(_), uso direttamente T0
        update(Env, T0, NV3, Env1),
        %aggiorna l'env generale 
        update_env(EnvList, Con, [Env1], EnvList1)
    ),
    nextlab(Con, L, L1),
    at(Con, L1, C).


% codecopy(s, f, t) copia s byte dal codice (a partire dalla posizione f)
% nella cella di memoria all'indirizzo t
% si assume che gli argomenti s, f e t siano variabili locali (var(...)) 
% perchè sono il risultato di chiamate ad altre op builtin come datasize e dataoffset 
%che vengono inserite in variabili locali
%considerando che non dobbiamo realmente copiare il codice ci occupiamo solo di inserire una costante nella posizione t della memory
tr(cf(cmd(Con, L, codecopy([_S0, _F0, T0])), EnvList), cf(cmd(Con, L1, C), EnvList1)) :-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),

    eval_arg(T0, Env, T1),
    % Converti t in formato esadecimale'0x~16r'
    %format(atom(T), '0x~|~`0t~16r~2+', [T1]),
    pl_ops((NV is 100)),
    %T al posto di T1 con format
    update(Env, mem(T1), NV, Env1),

    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),

    nextlab(Con, L, L1),
    at(Con, L1, C).


% create(v, p, n) ==> create new contract with code mem[p…(p+n)) and 
%                     send v wei and return the new address; 
%                     returns 0 on error
% al momento della creazione del contratto, non disponiamo di informazioni sul valore di NewAddr
% capire se mettere qui il vincolo che sia >= 0 (per considerare il caso di errore)
tr(cf(cmd(Con, L, create([V0, V1, V2])), EnvList), cf(cmd(Con, L1,C), EnvList1)) :-
    
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    Env = (Con, (D,M,S)),

    eval_arg(V0, Env, N),
    eval_arg(V1, Env, P),
    eval_arg(V2, Env, W),
    slice_memory(M, P, N, Code),
    %ritorna l'indirizzo del contratto oppure 0 in caso di errore 
    % utilizzare un predicato specificando che non sappiamo che valore avrà 
    create_contract(W, Code, NewAddr),
    update_global(D, NewAddr, W, D1),
    Env1 = (Con,(D1, M, S)),

    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),

    nextlab(Con, L, L1),
    at(Con, L1, C). 

% create2(v, p, n, s) .... create new contract with code mem[p…(p+n)) at address keccak256(0xff . this . s . keccak256(mem[p…(p+n)))
% create2(s, n, p, v)
tr(cf(cmd(Con, L, create2([V0, V1, V2, V3])), EnvList), cf(cmd(Con, L1,C), EnvList1)) :-
    
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    Env = (Con, (D,M,S)),

    eval_arg(V0, Env, S),
    eval_arg(V1, Env, N),
    eval_arg(V2, Env, P),
    eval_arg(V3, Env, W),
    slice_memory(M, P, N, Code),
    %ritorna l'indirizzo del contratto oppure 0 in caso di errore 
    % utilizzare un predicato specificando che non sappiamo che valore avrà 
    create_contract(W, Code, NewAddr),
    update_global(D, NewAddr, W, D1),

    Env1 = (Con,(D1, M, S)),
    %aggiorna l'env generale 
    update_env(EnvList, Con, [Env1], EnvList1),

    nextlab(Con, L, L1),
    at(Con, L1, C). 

% event
% Considering that they return nothing in the code and have no effect on the environment, 
% they are written but basically do nothing at least for the moment 
% (it will be seen if they need to be changed in future implementations)
tr(cf(cmd(Con, L, log0([_S0, _P0])), Env), cf(cmd(Con, L1,C), Env)) :- 
    nextlab(Con, L,L1), at(Con, L1,C).
tr(cf(cmd(Con, L, log1([_T1, _S0, _P0])), Env), cf(cmd(Con, L1, C), Env)) :- 
    nextlab(Con, L,L1), at(Con, L1,C).
tr(cf(cmd(Con, L, log2([_T2, _T1, _S0, _P0])), Env), cf(cmd(Con, L1,C), Env)) :- 
    nextlab(Con, L,L1), at(Con, L1,C).
tr(cf(cmd(Con, L, log3([_T3, _T2, _T1, _S0, _P0])), Env), cf(cmd(Con, L1,C), Env)) :- 
    nextlab(Con, L,L1), at(Con, L1,C).
tr(cf(cmd(Con, L, log4([_T4, _T3, _T2, _T1, _S0, _P0])), Env), cf(cmd(Con, L1,C), Env)) :- 
    nextlab(Con, L,L1), at(Con, L1,C).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calldatacopy(t, f, s): copia s byte dal calldata (globale) a partire dall’offset f, nella memoria a partire dalla posizione t.
tr(cf(cmd(Con, L, calldatacopy([S0, F0, T0])), EnvList), cf(cmd(Con, L1, C), EnvList1)) :-        
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env),
    
    eval_arg(F0, Env, F),          % offset di partenza nel calldata
    eval_arg(S0, Env, Size),       % numero di byte da copiare
    lookup_evm('calldata', Env, CD), % recupera il valore di calldata
    slice_memory(CD, F, Size, Data),     % estrae dal calldata (CD) il segmento di Size byte a partire da F
    %lo riconvertiamo in numero
    atom_concat('0x', Data, Full), 
    atom_number(Full, NV),
    %aggiorniamo a seconda del tipo del terzo parametro T0
    ( T0 = var(_) ->
        eval_arg(T0, Env, T2), % posizione di destinazione nella memoria
         % Se T0 è una variabile locale, converto il valore numerico in esadecimale con prefisso '0x'
        %format(atom(T), '0x~16r', [T2]),
        %update((D, M, S), mem(T), NV, (D, M1, S))
        update(Env, mem(T2), NV, Env1),
         %aggiorna l'env generale 
        update_env(EnvList, Con, [Env1], EnvList1)

    ; T0 = mem(_) ->
         % Se T0 è già del tipo mem(_), uso direttamente T0
        update(Env, T0, NV, Env1),
         %aggiorna l'env generale 
        update_env(EnvList, Con, [Env1], EnvList1)
    ),
    nextlab(Con, L, L1),
    at(Con, L1, C).


%%%%%%%%%%%%%%%%%%%%%%%%%%%

create_temp(TempEnv):-
    initGLB2(Tem_D), 
    initMem(Tem_M), 
    initStackEnv([], Tem_S).

%call(outsize, out, insize, in, v, a, g )

tr(cf(cmd(Con, L,call([V0, V1, V2, V3, V4, V5, V6], R0)), EnvList) , cf(cmd(Con, L1,C), EnvList2) ):-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env0),

    eval_arg(V6, Env0, Gas),
    eval_arg(V5, Env0, A0),
    eval_arg(V4, Env0, Wei),
    eval_arg(V3, Env0, InOff),
    eval_arg(V2, Env0, InSize),
    eval_arg(V1, Env0, OutOff),
    eval_arg(V0, Env0, OutSize),
    %dopo aver valutato gli argomenti separo i casi
    writeln(['InOff ', InOff, ' InSize: ', InSize]),
    % 0. estraggo le informazioni dalla memory
    eval_arg(mem(OutOff), Env0, Data),

    % 1. controllo pre-chiamata 
    pre_ex_call_check(Gas, Wei, Env0, RetCheck),
    % 2. comportamento post controllo 1 
    % Questo va suddivisio in 2 casistiche: 
        %a. check restituisce 0 --> aggiorno gas e e R0 e mi fermo 
        %b. check restituisce 1 --> in questo caso bisogna ipotizzare che la chiamata sia stata esiguita 
    % 3. il punto 2b a sua volta può restituire due risultati:
        % - 0, la chiamata viene eseguita ma fallisce per qualche motivo sconosciuto 
        % - 1, la chiamata va a buon fine e quindi bisogna considerare che anche le variabili globali potrebbero essere cambiate 
    
    % per il punto 2 bisogna creare la lista di variabili da passare per creare l'ambiente corretto
    create_new_env_variable_list(Env0, InOff, InSize, Wei, Gas, IList),
    
    %post_ex_call_check(IList, RetCheck, Gas, Wei, Env0, EnvList, R0, InOff, OutOff, A0, Env2),
    post_ex_call_check(IList, RetCheck, Gas, Wei, Env0, EnvList, R0, InOff, OutOff, A0, Env2, EnvList1),

    %aggiorna l'env generale 
    update_env(EnvList1, Con, [Env2], EnvList2),
    nextlab(Con, L, L1),
    at(Con, L1, C).   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

eval(iszero([V0]), Env, V1):- eval_arg(V0, Env, X0), X0 =:= 0, V1 = 1.
eval(iszero([V0]), Env, V1):- eval_arg(V0, Env, X0), X0 =\= 0, V1 = 0. 


% in YUL documentation the syntax is eq(x, y) for the rule 'if x == y, 0 otherwise', 
% in the Json file the input sono invertiti: eq(y, x)
% essendo commutativo l'ordine non influisce
eval(eq([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 =:= Y0, V2 = 1.
eval(eq([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 =\= Y0, V2 = 0.

% in YUL documentation the syntax is lt(x, y) for the rule 'if x < y, 0 otherwise', 
% in the Json file the input are inverted: lt(y, x) 
% so, V0 = y e V1 = x  
eval(lt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 < Y0, V2 = 1.
% eval(lt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 > Y0, V2 = 0.
% eval(lt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 = Y0, V2 = 0.
eval(lt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 >= Y0, V2 = 0.

% in YUL documentation the syntax is gt(x, y) for the rule 'if x > y, 0 otherwise', 
% in the Json file the input are inverted: gt(y, x) 
% so, V0 = y e V1 = x  
eval(gt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 > Y0, V2 = 1.
% eval(gt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 < Y0, V2 = 0.
% eval(gt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 = Y0, V2 = 0.
eval(gt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 =< Y0, V2 = 0.

% in YUL documentation the syntax is slt(x, y),  1 if x < y 0 otherwise, for signed numbers
% in the Json file the input are inverted: slt(y, x)
eval(slt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 < Y0, V2 = 1.
% eval(slt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 > Y0, V2 = 0.
% eval(slt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 = Y0, V2 = 0.
eval(slt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 >= Y0, V2 = 0.

% in YUL documentation the syntax is sgt(x, y),  1 if x > y 0 otherwise, for signed numbers
% in the Json file the input are inverted: sgt(y, x)
eval(sgt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 > Y0, V2 = 1.
% eval(sgt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 < Y0, V2 = 0.
% eval(sgt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 = Y0, V2 = 0.
eval(sgt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 =< Y0, V2 = 0.

% in YUL documentation the syntax is add(x, y) for the rule 'x + y', 
% in the Json file the input are inverted: add(y, x) 
% so, V0 = y e V1 = x  
eval(add([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is X0 + Y0)).

% in YUL documentation the syntax is sub(x, y) for the rule 'x - y', 
% in the Json file the input are inverted: sub(y, x) 
% so, V0 = y e V1 = x  
eval(sub([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is X0 - Y0)).

% in YUL documentation the syntax is mul(x, y) for the rule 'x * y', 
% in the Json file the input are inverted: mul(y, x) 
% so, V0 = y e V1 = x  
eval(mul([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is X0 * Y0)).

% in YUL documentation the syntax is div(x, y) for the rule 'x / y', 
% 0 if y == 0
% in the Json file the input are inverted: div(y, x) 
% so, V0 = y e V1 = x  
eval(div([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), Y0 =\= 0, pl_ops((V2 is X0 / Y0)).
eval(div([V0,_V1]), Env, V2):- eval_arg(V0, Env, Y0), Y0 =:= 0, V2 = 0.

% for signed numbers in two’s complement
% in YUL documentation the syntax is sdiv(x, y) for the rule 'x / y', 
% 0 if y == 0
% in the Json file the input are inverted: sdiv(y, x) 
% so, V0 = y e V1 = x  
eval(sdiv([V0,_V1]), Env, V2):- eval_arg(V0, Env, Y0), Y0 =:= 0, V2 = 0.
eval(sdiv([V0, V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0),   
    % Signed integer conversion: if the value is >= 2^255 then it represents a negative: the conversion is made by subtracting 2**256
    (Y0 < 2**255 -> SY = Y0 ; pl_ops((SY is Y0 - 2**256))),
    (X0 < 2**255 -> SX = X0 ; pl_ops((SX is X0 - 2**256))),
    % Performing integer division with sign
    pl_ops((SRes is SX div SY)),
    %V2 = SRes.
    % Conversion of result to 256-bit format: if negative, we add 2^256
    (SRes < 0 -> pl_ops((V2 is SRes + 2**256)) ; V2 = SRes).

%mod
% in YUL documentation the syntax is mod(x, y) for the rule x % y, 
% 0 if y == 0 
% in the Json file the input are inverted: mod(y, x) 
% so, V0 = y e V1 = x  
eval(mod([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), Y0 =\= 0, pl_ops((V2 is X0 mod Y0)).
eval(mod([V0,_V1]), Env, V2):- eval_arg(V0, Env, Y0), Y0 =:= 0, V2 = 0.


% for signed numbers in two’s complement
% in YUL documentation the syntax is smod(x, y) for the rule x % y, 
% 0 if y == 0 
% in the Json file the input are inverted: smod(y, x) 
% so, V0 = y e V1 = x 
eval(smod([V0,_V1]), Env, V2):- eval_arg(V0, Env, Y0), Y0 =:= 0, V2 = 0.
eval(smod([V0, V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0),   
    % Signed integer conversion: if the value is >= 2^255 then it represents a negative: the conversion is made by subtracting 2**256
    (Y0 < 2**255 -> SY = Y0 ; pl_ops((SY is Y0 - 2**256))),
    (X0 < 2**255 -> SX = X0 ; pl_ops((SX is X0 - 2**256))),
    % Performing integer division with sign
    pl_ops((SRes is SX rem SY)), 
    %for the result to have the same sign as x (the dividend) we use rem (IntExpr1 - (IntExpr1 // IntExpr2) × IntExpr2)
    % Conversion of result to 256-bit format: if negative, we add 2^256
    (SRes < 0 -> pl_ops((V2 is SRes + 2**256 )); V2 = SRes).


%exp
% in YUL documentation the syntax is exp(x, y) for the rule x ^ y, 
% in the Json file the input are inverted: exp(y, x) 
% so, V0 = y e V1 = x  
eval(exp([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is X0 ^ Y0)).


% in YUL documentation the syntax is slt(x, y),  1 if x < y 0 otherwise, for signed numbers
% in the Json file the input are inverted: slt(y, x)
eval(slt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 < Y0, V2 = 1.
eval(slt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 > Y0, V2 = 0.

% in YUL documentation the syntax is sgt(x, y),  1 if x > y 0 otherwise, for signed numbers
% in the Json file the input are inverted: sgt(y, x)
eval(sgt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 > Y0, V2 = 1.
eval(sgt([V0,V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), X0 < Y0, V2 = 0.

% in YUL documentation the syntax is addmod(x, y, m)
% (x + y) % m with arbitrary precision arithmetic, 0 if m == 0 
% in the Json file the input are inverted: addmod(m, y, x)
eval(addmod([V0,_V1, _V2]), Env, V3):- eval_arg(V0, Env, M0), M0 =:= 0, V3 = 0.
eval(addmod([V0,V1,V2]), Env, V3):- eval_arg(V0, Env, M0), eval_arg(V1, Env, Y0), eval_arg(V2, Env, X0), pl_ops((V3 is (Y0 + X0) mod M0)).

% in YUL documentation the syntax is mulmod(x, y, m)
% (x * y) % m with arbitrary precision arithmetic, 0 if m == 0 
% in the Json file the input are inverted: addmod(m, y, x)
eval(mulmod([V0,_V1, _V2]), Env, V3):- eval_arg(V0, Env, M0), M0 =:= 0, V3 = 0.
eval(mulmod([V0,V1,V2]), Env, V3):- eval_arg(V0, Env, M0), eval_arg(V1, Env, Y0), eval_arg(V2, Env, X0), pl_ops((V3 is (Y0 * X0) mod M0)).

%PhiFunction
eval(phiFunction([V0]), Env, V2):- eval_arg(V0, Env, V1), pl_ops((V2 is V1)).

%%%%%%%%%%%%%%%%%%% Bitwise Operations

% bitwise ‘and’ returns 1 if both operands are 1, and 0 otherwise 
% In Yul: and(x, y), but in the Json file the input are inverted: 
eval(and([V0, V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is X0 /\ Y0)).

% Bitwise operation ‘or’ returns 1 if at least one operand is 1, else 0
eval(or([V0, V1]), Env, V2):-  eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is X0 \/ Y0)).

% Bitwise “xor” of x and y
eval(xor([V0, V1]), Env, V2):- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is X0 xor Y0)).

% Calculates the 256-bit complement of the argument
eval(not([V0]), Env, V2) :-
   % writeln(['op not']),
    Mask is (2^256 - 1),
    eval_arg(V0, Env, X),
    V2 is Mask - X.
    %writeln(["NOT D1: ", X, "e: ",  V2]).

%byte(n, x)
%nth byte of x, where the most significant byte is the 0th byte
% in the Json file the input are inverted: byte(x,n)
eval(byte([_V0, V1]), Env, V2) :- eval_arg(V1, Env, N0), N0 > 31, pl_ops((V2 is 0)).
% moves the desired byte to the least significant digits by integer division
% and isolate that byte by applying the modulus 256
eval(byte([V0, V1]), Env, V2) :- eval_arg(V0, Env, X0), eval_arg(V1, Env, N0), pl_ops(( V2 is (X0 // (256**(31 - N0))) mod 256)). 


% shl(x, y) ==> logical shift left y by x bits
%  in the Json file the input are inverted: shl(y,x)
eval(shl([V0, V1]), Env, V2) :- eval_arg(V0, Env, Y0),  eval_arg(V1, Env, X0), pl_ops((V2 is Y0 << X0)).
eval(shl([V0, V1]), Env, V2) :- eval_arg(V0, Env, Y0),  eval_arg(V1, Env, _X0), Y0 =:= 0,  pl_ops((V2 is 0)).
eval(shl([V0, V1]), Env, V2) :- eval_arg(V0, Env, Y0),  eval_arg(V1, Env, X0), X0 =:= 0,  pl_ops((V2 is Y0)).

% shr(x, y) ==> logical shift right y by x bits
% in the Json file the input are inverted: shr(y,x)
eval(shr([V0, V1]), Env, V2) :- eval_arg(V0, Env, Y0), eval_arg(V1, Env, X0), pl_ops((V2 is Y0 >> X0)).
eval(shr([V0, V1]), Env, V2) :- eval_arg(V0, Env, Y0),  eval_arg(V1, Env, _X0), Y0 =:= 0,  pl_ops((V2 is 0)).
eval(shr([V0, V1]), Env, V2) :- eval_arg(V0, Env, Y0),  eval_arg(V1, Env, X0), X0 =:= 0,  pl_ops((V2 is Y0)).


% signed arithmetic shift right y by x bits
% in YUL documentation the syntax is sar(x, y)
% % in the Json file the input are inverted: sar(y, x)
eval(sar([V0, V1]), Env, V2):-
    eval_arg(V0, Env, Y0),      
    eval_arg(V1, Env, X0),     
    (X0 < 2**255 -> SX = X0 ; pl_ops((SX is X0 - 2**256))),
    (Y0 >= 256 -> ( SX < 0 -> SRes = -1 ; SRes = 0)
     ; pl_ops((SRes is SX >> Y0))      
    ),
    (SRes < 0 -> pl_ops((V2 is SRes + 2**256)) ; V2 = SRes).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OTHER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%op built in to copy bytes from the code or the size of the code, 
%for our purpose these are not needed so we assign a constant
eval(datasize, _Env, V1):- pl_ops((V1 is 10)).
eval(dataoffset, _Env, V1):- pl_ops((V1 is 0)).
eval(codesize, _Env, V1):- pl_ops((V1 is 100)).



%keccak256(p, n)  ==> keccak256(n, p)
eval(keccak256([V0, V1]), (Con, (D,M,S)), V2) :-
    eval_arg(V0, (Con, (D,M,S)) , N0),     % N0 = numero di byte da considerare
    eval_arg(V1, (Con, (D,M,S)), P0),     % P0 = offset iniziale in memoria 
    slice_memory(M, P0, N0, Data),   % Data = segmento di memoria corrispondente
    hash_data(Data, V2).           % V2 = keccak256(Data)

%blockhash(b) ==> hash of block nr b - only for last 256 blocks excluding current
% TO DO: questa implementazione restituisce un “dummy hash” basato sul numero del blocco
% Si potrebbe pensare di restituire una costante (o un range come in SOLCMC)
eval(blockhash([V0]), Env, V1) :-
    eval_arg(V0, Env, BN),
    pl_ops((V1 is (BN * 42) mod (2^256))).


% extcodesize(a) ==>size of the code at address a
%restituisce la dimensione del codice esterno (in byte) associato all’indirizzo. Supponendo che nel globals 
% il codice di un contratto sia memorizzato come stringa esadecimale dovrebbe valutare l'indirizzo contenuto in una variabile locale,
%convertirlo in esadecimale e poi utilizzare il risultato come chiave e cercare il valore associato.
% al momento restituisce una costante
eval(extcodesize([_V0]), _Env, V1) :-
    pl_ops((V1 is 0)).

% returndatasize() ==> size of the last returndata
% restituisce la dimensione (in byte) dell’area di “returndata” (memorizzata in D con chiave 'returndata') 
% il valore non è memorizzato come stringa esadecimale quindi bisogna prima riconvertirlo
% TODO by EMA: tested? check prolog ...
eval(returndatasize, Env, V1) :-
    ( lookup_evm('returndata', Env, Data) ->
        %format(atom(DataEsa),'0x~|~`0t~16r~2+', [Data]),
        %string_length(DataEsa, LenHex),
        string_length(Data, LenHex),
        (  LenHex =:= 0, pl_ops((V1 is 0))
        ;
            pl_ops((V1 is LenHex // 2))
        )
    ).

%extcodehash(a) ==> code hash of address a
%valuto l'argomento contenuto nella variabile locale (v<number>), ==> A0
%lo trasformo nuovamente in esadecilame  ==> A1
%applico hash

%TO DO: generare esempio per controllo 
eval(extcodehash([V0]), Env, V1) :-
    eval_arg(V0, Env, A0),
    %format(atom(A1), '0x~16r', [A0]),
    hash_data(A0, V1).
 


%callcode(g, a, v, in, insize, out, outsize)
% simile a call, ma esegue il codice del contratto specificato, mantenendo il contesto (ad es. il caller non cambia)
eval(callcode([V0, V1, V2, V3, V4, V5, V6]), Env, R0):-
    eval_arg(V0, Env, Gas),
    eval_arg(V1, Env, _A0),
    %format(atom(_Addr), '0x~16r', [A0]),
    eval_arg(V2, Env, Wei),
    eval_arg(V3, Env, _InOff),
    eval_arg(V4, Env, _InSize),
    eval_arg(V5, Env, _OutOff),
    eval_arg(V6, Env, _OutSize),
    pre_ex_call_check(Gas, Wei, Env, RetCheck),
    %update((D,M,S), 'returndata', RetCheck, (D1,M,S)), %D1 non utilizzata
    %update((D,M,S), 'returndata', RetCheck, (_D1,M,S)),
    pl_ops((R0 is RetCheck)).

%staticcall(g, a, in, insize, out, outsize)
%staticcall(outsize, out, insize, in, a, g)
tr(cf(cmd(Con, L,staticcall([V0, V1, V2, V3, V4, V5], R0)), EnvList) , cf(cmd(Con, L1,C), EnvList2) ):-
    %estrae l'env per il contratto
    lookup_env(Con, EnvList, Env0),

    eval_arg(V5, Env0, Gas),
    eval_arg(V4, Env0, A0),
    eval_arg(V3, Env0, InOff),
    eval_arg(V2, Env0, InSize),
    eval_arg(V1, Env0, OutOff),
    eval_arg(V0, Env0, OutSize),
    
    %dopo aver valutato gli argomenti separo i casi
    writeln(['InOff ', InOff, ' InSize: ', InSize]),
    % 0. estraggo le informazioni dalla memory
    eval_arg(mem(OutOff), Env0, Data),

    % 1. controllo pre-chiamata 
      %qui non serve il controllo sul balance perchè non vengono passati wei
   
    % per il punto 2 bisogna creare la lista di variabili da passare per creare l'ambiente corretto
    create_new_env_variable_list(Env0, InOff, InSize, 0, Gas, IList),
    
    %post_ex_call_check(IList, RetCheck, Gas, Wei, Env0, EnvList, R0, InOff, OutOff, A0, Env2),
    post_ex_call_check(IList, 1, Gas, 0, Env0, EnvList, R0, InOff, OutOff, A0, Env2, EnvList1),
    
    %aggiorna l'env generale 
    update_env(EnvList1, Con, [Env2], EnvList2),
    nextlab(Con, L, L1),
    at(Con, L1, C). 


tr(cf(cmd(Con, L,(delegatecall([V1, V2, V3, V4, V5, V6]), R0)), Env0) , cf(cmd(Con, L1,C), Env2) ):-
    eval_arg(V6, Env0, Gas),
    eval_arg(V5, Env0, A0),
    eval_arg(V4, Env0, InOff),
    eval_arg(V3, Env0, InSize),
    eval_arg(V2, Env0, _OutOff),
    eval_arg(V1, Env0, _OutSize),

    eval_arg(mem(InOff), Env0, Sig),
    writeln(['SIGNATURE', Sig]).






%msize() 	 size of memory, i.e. largest accessed memory index
%knowing that memory is represented as a list of key-value pairs where the key is the slot and to respect EVM semantics for msize 32 bytes are added.
% if the maximum index accessed is 0x40 (64 in decimal), this means that at least one byte of the block starting at 0x40 and covering 
%addresses 0x40 to 0x5F has been used: the size of the allocated memory (msize) must be 64 + 32 = 96 bytes.
eval(msize, (Con, (_D, M, _S)), V) :-
    findall(Int, ( member((Key, _), M), atom_number(Key, Int) ), Keys),
    %writeln(['Keys',  Keys]),
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eval(gas,Env, V1) :-
    lookup_evm('gas',Env, X0), 
    pl_ops((V1 is X0)).

eval(address, Env, V1) :- 
    lookup_evm('address',Env, X0), 
    pl_ops((V1 is X0)).

% balance(a) ==> wei balance dell'indirizzo a 
% a è passato come variabile locale quindi prima si deve valutare, 
% poi convertire in esadecimale e poi cercare in globals
% assuming we are talking about addresses that are stored in the contract, 
% they are in the ‘globals’, otherwise it puts 0 ... look for a better solution 
% TODO by EMA: check the if-then-else at the end
eval(balance([V0]), Env, V1) :-
    eval_arg(V0, Env, V2),
    lookup_evm('address', Env, X0),
    (
        (X0 ==  V2) -> 
            (lookup_evm('balance',Env, V1))
        ;
            (
                eval_arg(off(V2), Env, Bal) ->
                    pl_ops((V1 is Bal))
                ;  
                    pl_ops((V1 is 0))
            )

    ).
%
eval(selfbalance,Env, V1) :- 
    lookup_evm('balance',Env, X0),
    pl_ops((V1 is X0)).
%
eval(caller, Env, V1) :- 
    lookup_evm('msg.sender',Env, X0), 
    pl_ops((V1 is X0)).
%
eval(callvalue, Env, V1):- 
    lookup_evm('msg.value',Env, X0), 
    pl_ops((V1 is X0)).
%
eval(calldataload([V0]),Env, V1) :- 
    eval_arg(V0,Env, P),       % position p
    lookup_evm('calldata',Env, CD),
    slice_memory(CD, P, 32, V2),  % estrae 32 byte da Calldata a partire dalla posizione p
    %se si vuole riconvertire in numero 
    atom_concat('0x', V2, V3),
    atom_number(V3, V1).
%    
eval(calldataload([_V0]),Env, V1) :- 
    lookup_evm('calldata',Env, CD),
    CD=:=0, pl_ops((V1 is 0)).
%     
eval(calldatasize,Env, V1) :- 
    lookup_evm('calldata',Env, CD), 
    %format(atom(CD1), '0x~|~`0t~16r~2+', [CD]), 
    string_length(CD, V0), pl_ops((V1 is V0//2)).% 
eval(chainid,Env, V1) :- 
    lookup_evm('chainid',Env, X0),
    pl_ops((V1 is X0)).
% 
eval(basefee,Env, V1) :- 
    lookup_evm('basefee',Env, X0), 
    pl_ops((V1 is X0)).
% 
eval(origin,Env, V1) :- 
    lookup_evm('tsender',Env, X0), 
    pl_ops((V1 is X0)).
% 
eval(gasprice,Env, V1) :- 
    lookup_evm('gprice',Env, X0), 
    pl_ops((V1 is X0)).
% 
eval(coinbase,Env, V1) :- 
    lookup_evm('mbeneficiary',Env, X0), 
    pl_ops((V1 is X0)).
% 
eval(timestamp,Env, V1) :- 
    lookup_evm('timestamp',Env, X0), 
    pl_ops((V1 is X0)).
% 
eval(number,Env, V1) :- 
    lookup_evm('bnumber',Env, X0), 
    pl_ops((V1 is X0)).
% 
eval(prevrandao,Env, V1) :- 
    lookup_evm('prevrandao',Env, X0), 
    pl_ops((V1 is X0)).
% 
eval(gaslimit,Env, V1) :- 
    lookup_evm('glimit',Env, X0), 
    pl_ops((V1 is X0)).


% The memoryguard call indicates that all memory accesses respect this restriction,
% does not change the state so it is treated as a skip for now: it goes to the next op
eval(memoryguard, _Env, V1) :- pl_ops((V1 is 128)).

%signextend(i, x) ==> sign extend from (i*8+7)th bit counting from least significant
%signextend(x, i)
%TO DO: usare un contratto che genera signetend per veddere com'è rappresentata 
eval(signextend([V1, V0]), Env, V2) :-
    eval_arg(V0, Env, I),  % I = indice del byte (0..31)
    eval_arg(V1, Env, X),  % X = numero da estendere
    pl_ops((BitPos is (I + 1) * 8 - 1)), % posizione del bit di segno
    pl_ops((SignBit is 1 << BitPos)),
    ( X /\ SignBit =\= 0 ->
         % Se il bit di segno è 1, estendi con 1 (risultato negativo)
         pl_ops((Mask is (2^256 - 1) - ((1 << (BitPos+1)) - 1))),
         pl_ops((V2 is X \/ Mask))
    ;
         % Altrimenti, maschera i bit superiori
         pl_ops((Mask is (1 << (BitPos+1)) - 1)),
         pl_ops((V2 is X mod (Mask+1)))
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OPERAZIONI SU MEMORIA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% mload(p) ==> mem[p…(p+32)).
% Legge dalla memory (M)
%eval(mload([V0]), Env, V1):- eval_arg(V0, Env, X0), pl_ops((V1 is X0)).
eval(mload([V0]), Env, V1):- eval_arg(mem(V0), Env, V1).

eval(mload([mem(Key)]), Env, Value) :-
    eval_arg(mem(Key), Env, Value).  

eval(mload([var(V0)]),Env, V1) :- 
    eval_arg(var(V0), Env, K),
    eval_arg(mem(K), Env, V1).


% ———————————————————————————————————————
% 1) Caso sload([off(Key)]), 
% ———————————————————————————————————————
eval(sload([off(Key)]), Env, Value) :-
    !,
    eval_arg(off(Key), Env, Value).  

%eval(sload([V0]), Env, V1):- eval_arg(V0, Env, V1), writeln(V0),writeln(V1).

eval(sload([var(V0)]),Env, V1) :- 
    lookup_local(var(V0), Env, K),
    (
        integer(K) -> 
            (%format(atom(K0), '0x~|~`0t~16r~2+', [K]),
            eval(sload([off(K)]), Env, V1)
            )
        ;
        eval(sload([K]), Env, V1)
    ).



% ============
% TO DO :    hash_data 
% SWI-Prolog dovrebbe includere la libreria crypto: https://www.swi-prolog.org/search?for=crypto
%:- use_module(library(crypto)).

hash_data(Data, Hash) :-
    % Calcola l’hash usando l’algoritmo SHA3-256 (Keccak-256)
    crypto_data_hash(Data, HashHex, [algorithm(sha3_256)]),
    % Aggiunge il prefisso '0x' e converte in numero (capire il formato atteso)
    atom_concat('0x', HashHex, FullHex),
    atom_number(FullHex, Hash).

slice_memory(M, P, N, Data) :-
    ( number(M) ->
         format(atom(MStr), '~16r', [M])
    ; atom(M) ->
         MStr = M
    ),
    pl_ops((Start is P * 2)),   % ogni byte = 2 caratteri
    pl_ops((Len is N * 2)),
    string_length(MStr, ML),
    (   ML >= Start ->
         pl_ops((Available is ML - Start))
    ; 
    %se P è oltre la lunghezza della stringa Available risulta negativo e la chiamata a sub_atom genera un errore
    %cambiamo quindi e mettiamo Available = 0
         Available = 0
    ),
    ( Available >= Len ->   %viene estratta la sottostringa richiesta
         sub_atom(MStr, Start, Len, _, Data)
    ;
         ( Available > 0 ->  %si estrae la parte disponibile 'PartD'
             sub_atom(MStr, Start, Available, 0, PartD)
         ;
             PartD = ''  %considera PartD come stringa vuota
         ),
         %si genera una stringa di zeri di lunghezza Missing, che viene concatenata a PartD
         Missing is Len - Available,
         findall('0', between(1, Missing, _), ZerosList),
         atomic_list_concat(ZerosList, Zeros),
         atom_concat(PartD, Zeros, Data)
    ).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%%%%%%%%%55 aggiornamento del 30/10/2025 

%se P > 32 allora sono da prendere i primi 4 byte  dalla prima posizione e 
% i successivi dalle posizioni successive  --> 
% contando multipli di 32 per capire quante posizioni della memoria leggere
% ex_call_slice_memory(+InOff, +Env0, +MData, +PosIniz, +Size, -DataHex)
% InOff: offset iniziale (posizione in M)
% Env0 = (Con,(D,M,S))
% M: valore della posizione corrente dalla quale estrarre i primi bytes
% P: posizione dalla quale partire ad estrarre i dati
% N: numero di bytes da leggere in totale
% DataHex: risultato della concatenazione hex dei dati richiesti
ex_call_slice_memory(InOff, Env0, MData, P, Size, DataList) :-
    % MData -> MStr (hex)
    hex_of_value(MData, MStr0),
    % calcola in caratteri hex (ogni byte = 2 caratteri)
    pl_ops((Start is P * 2)),   % ogni byte = 2 caratteri
    pl_ops((LenChars is Size * 2)),
    atom_length(MStr0, ML0),
    ( ML0 >= Start -> AvailableChars is ML0 - Start ; AvailableChars = 0 ),

    (  
        Size =< 32 ->
         % caso semplice (richiesta <= 32 bytes)
         (
            %sub_atom(MStr0, Start, LenChars, _, DataHex), 
            First4Chars is 4 * 2,
            sub_atom(MStr0, Start, First4Chars, _, First4Hex),
            DataList = [num(First4Hex)]
         )
         
    ; % Size > 32 -> procedura multi-slot
        (
         % prende i primi 4 byte (8 caratteri hex) dalla posizione corrente
         First4Chars is 4 * 2,
         sub_atom(MStr0, Start, First4Chars, _, First4Hex),

         pl_ops((Lun is Size - 4)),                        % bytes da prendere dopo i primi 4
         %pl_ops((NumSlots is (Lun + 32 - 1)// 32)) ,    divisione per numeri dispari

         pl_ops((NumSlots is (Lun / 32))) ,    % ogni key associato ad un valore di max 32 byte (lun/32)

         % prende le chiavi successive (NumSlots) a partire da InOff
         read_memory_key(InOff, Env0, NumSlots, Keys),

        % estrae i valori dalle chiavi
         evaluate_key_slots(Keys, Env0, ListSlots),

        % costruisce il risultato: primi 4 byte + lista dei valori estratti dagli slot
         DataList = [num(First4Hex) | ListSlots]
        )
    ).
        


%estrae ogni valore dalla memory in base alla key  
evaluate_key_slots([], _Env0, []) :- !.
evaluate_key_slots([K|Ks], Env0, [num(V)|Rest]) :-
    eval_arg(mem(K), Env0, V),         % prendi valore dal memory slot K
    evaluate_key_slots(Ks, Env0, Rest).

%trasforma gli elelementi estratti in elementi della lista
create_list_slots(_Slots, Needed, []) :- Needed =< 0, !.
create_list_slots([], _Needed, []) :- !.
create_list_slots([S|Ss], Needed, [Part|Rest]) :-
        Part = S,
        Remaining is Needed - SL,
        create_list_slots(Ss, Remaining, Rest).


% hex_of_value(+Val, -HexAtom)
% converte un valore (numero o atom) in stringa hex (senza 0x, lowercase)
hex_of_value(Val, HexAtom) :-
    number(Val), !,
    format(atom(HexAtom0), '~16r', [Val]),
    downcase_atom(HexAtom0, HexAtom).
hex_of_value(Val, Val) :-
    atom(Val), !.  % assume già una rappresentazione hex come atom


% concatena i valori di ciascuna key, convertiti in hex e padded a 32 bytes (64 hex chars)
concat_slots_hex([], _Env0, '').
concat_slots_hex([K|Ks], Env0, Conc) :-
    eval_arg(mem(K), Env0, V),         % prendi valore dal memory slot K
    format(atom(H), '~`0t~16r~64|', [V]),   % number -> padded hex direttamente
    concat_slots_hex(Ks, Env0, Rest),
    atom_concat(H, Rest, Conc).


read_memory_key(InOff, Env0, Num, KeyList) :- 
    Env0 = (_Con, (_D, M, _S)), 
    skip_until(M, InOff, Tail),
    take_keys(Tail, Num, KeyList).


% prende i primi N key dalla lista di coppie (se meno, prende quelli disponibili)
take_keys(_, 0, []) :- !.
take_keys([], _, []) :- !.
take_keys([(K,_)|T], N, [K|Ks]) :-
    N > 0,
    N1 is N - 1,
    take_keys(T, N1, Ks).

% trova la coda della lista dopo la coppia che ha Key
% TailAfterKey è la lista che segue la coppia che ha Key.
skip_until([(Key,_)|Tail], Key, Tail) :- !.
skip_until([_|T], Key, TailAfter) :-
    skip_until(T, Key, TailAfter).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% Predicato che modella la creazione del contratto
create_contract(W, Code, NewAddr) :-
    ( ( %qui serve per derifire i casi in cui dovrebbe restituire 0, quindi se il gas non è sufficiente ecc
        Code == '' 
        ; 
        % TODO by EMA: ?!? fallisce: perche' variabili anonime? (_D, _M, _S)
        lookup_evm('balance', (_D, _M, _S), X0), X0 < W  
        %qui bisognerebbe mettere controllo su gas e su esistenza di codice all'indirizzo calcolato 
        %lookup_evm('gas', (D, M, S), X1), X1 < 
    ) ->
         % Se il codice è vuoto, la creazione fallisce: restituisce 0
         NewAddr = 0
    ;   % Altrimenti, si genera un nuovo indirizzo.
         % In una implementazione reale questo indirizzo verrebbe calcolato, ad esempio,
         % come funzione dell'indirizzo del creatore e del suo nonce.
         % in teoria bisognerebbe calcolare l'indirizzo come 'address is calculated as the rightmost 20 bytes (160 bits) of the Keccak-256 hash of the rlp encoding of the sender address followed by its nonce'
         % ma noi possiamo calcolare un valore fisso random 
         new_contract_address(W, Code, NewAddr),
         NewAddr > 0
    ).

new_contract_address(_V, _Code, NewAddr):- random_between(1001, 9999, NewAddr).


    
% call(g, a, v, in, insize, out, outsize)
%chiamata esterna; parametri: gas, indirizzo chiamato, valore, offset e dimensione degli input e output. 
% returning 0 on error (eg. out of gas) and 1 on success 

%bisognerebbe modellare i casi in cui restituisce 0 o lasciare vincolato in modo 
%che sappiamo che può ritornare solo 0 o 1 
% TODO by EMA: correggere -->
% TODO by EMA: ?!? fallisce: perche' variabili anonime? (_D, _M, _S)
pre_ex_call_check(_Gas, Wei, Env, RetCheck):- 
    %lookup_evm('gas', Env, X1), 
    lookup_evm('balance', Env, X2),
    %OR ( NOT AND) because even if only one of the conditions occurs, it must generate an error
    %(X1 < Gas ; X2 < Wei) ->
    %(X2 < Wei) ->

    %(
    %    pl_ops((RetCheck is 0)),
    %    writeln('Controlli NON ok')
    %)
    %; 
    %(
    %    pl_ops((RetCheck is 1)),
    %    writeln('Controlli ok')
    %).
     (X2 >= Wei) ->

    (
        pl_ops((RetCheck is 1)),
        writeln('Controlli ok')
    )
    ; 
    (
        pl_ops((RetCheck is 0)),
        writeln('Controlli NON ok')
    ).


% RetCheck restituisce 0 - caso di errore nei prerequisiti 
post_ex_call_check(_IList, RetCheck, Gas, Wei, Env0, EnvList, R0, InOff, _OutOff, A0, Envf, EnvList):- 
    RetCheck =:= 0,
    update_after_call_f(Env0, Gas, Env1), 
    update(Env1, R0, RetCheck, Envf).
    %nextlab(Con, L, L1),
   %at(Con, L1, C),
   %writeln('post_ex con call fallita').

post_ex_call_check(IList, RetCheck, Gas, Wei, Env0, EnvList, R0, InOff,  OutOff, A0, Envf, EnvList3):- 
%post_ex_call_check(IList, RetCheck, Gas, Wei, Env0, EnvList, R0, InOff,  OutOff, A0, Envf):- 
    RetCheck =:= 1,
    lookup_address(A0, A1, Con2),
    writeln(['contratto', A0]),
    writeln(['Esiste il contratto?', A1]),
    writeln(['Nome?', Con2]),
    (
        ( A1 =:= 0 -> do_ex_call(Env0, R0, Gas, Wei, Envf),
            writeln(['Contratto sconosciuto'])
        )
        ;
        (
               ( 
                eval_arg(mem(InOff), Env0, Sig),
                P = 0,
                Size = 4, 
                slice_memory(Sig, P, Size, Data),
                writeln(['extract SIGNATURE', Data]),
                
                %aggiornato: controlla se esiste già o meno l'env per con2    
                execute_called_contract(EnvList, IList, Con2, Data, Ret, InOff, EvaluatedOutputs, EnvFC3, EnvList3),

                nl,
                writeln(['RET : ', Ret, 'RES : ', EvaluatedOutputs ]),
                nl,
                
                %aggiorna il risultato dell' esecuzione della funzione chiamata 
                % Ret = 1, chiamata andata a buon fine, Ret = 0 si è verificato un revert 
                update(Env0, R0, Ret, Env1),
                
                %aggiornamento della memoria e in base all'esito dell'esecuzione del codice chiamato
                nl, 
                writeln(['Write Output on mem at position : ', OutOff]),
                nl,
                update_env_aft_call(Env1, R0, EvaluatedOutputs, Gas, Wei, OutOff, Envf)
                )
        )
    )
    .


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%genera la lista di variabili da passare durante la creazione dell'env del contratto chiamato
create_new_env_variable_list(Env0, InOff, InSize, Wei, Gas, IList):-
    lookup_evm('address', Env0, Sender),
    eval_arg(mem(InOff), Env0, Call),
    ex_call_slice_memory(InOff, Env0, Call, 0, InSize, Calldata),
    writeln([' Calldata: ', Calldata]),
    IList=[Wei, Gas, Sender, Calldata, Wei].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    %NUOVE REGOLE PER CHIAMATA A CONTRATTO CON CODICE NOTO 

%controlla che esista l'env per il contratto chiamato, 
% - se esiste allora va avanti con quello, senza crearlo nuovamente 
% - se non esiste lo inizializza e lo memorizza --> lookup_env = 0 

execute_called_contract(EnvList, IList, Con2, Data, Ret, InOff, EvaluatedOutputs, EnvFC3, EnvList3):-
    lookup_env(Con2, EnvList, EnvCon2),
        (
            (EnvCon2 == 0) ->
                (
                    init_env_called_cont(IList, Con2, Env0C2),
                    extract_call_data(IList, Calldata),
                    extract_conf_called_cont(Env0C2, Con2, Data, FName, ExFName, Lab, Input, Output, Env1C2),
                    update_env(EnvList, Con2, [Env1C2], EnvList1),
                    nl,
                    writeln(['L env per il contratto chiamato è stato creato']),
                    nl,
                    exec_called(Calldata, EnvList1, Con2, FName, ExFName, Lab, Input, Output, Env1C2, EvaluatedOutputs, Ret, EnvList3)
                )    

            ;
                (
                    extract_conf_called_cont(EnvCon2, Con2, Data, FName, ExFName, Lab, Input, Output, Env1C2),
                    %aggiorno le variabili evm 
                    %update_init_env(Env1C2, IList, Env1C3),
                    update_ex_evm_called(Env1C2, IList, Env1C3),
                    extract_call_data(IList, Calldata),
                    update_env(EnvList, Con2, [Env1C3], EnvList1),
                    nl,
                    writeln(['L env per il contratto chiamato esiste già']),
                    nl,
                    exec_called(Calldata, EnvList1, Con2, FName, ExFName, Lab, Input, Output, Env1C3, EvaluatedOutputs, Ret, EnvList3)
                )
        ).



update_ex_evm_called(Env, IList, Envf):- 
    IList=[Wei, Gas, Sender, Calldata, Wei], 
    lookup_evm('balance',Env, OldB),
    lookup_evm('gas',Env, OldG),
    pl_ops(NBal is OldB + Wei),
    pl_ops(NGas is OldG + Gas),
    update(Env,'balance', NBal, Env1), 
    update(Env1,'gas', NGas , Env2), 
    update(Env2,'msg.sender', Sender , Env3), 
    create_calldata(Calldata, Env3, CD),
    update(Env3,'calldata', CD , Env4), 
    update(Env4,'msg.value', Wei, Envf).


extract_call_data(IList, Calldata):- 
    IList=[Wei, Gas, Sender, Calldata, Wei].


%ho già l'env del chiamato nella lista, quindi lo recupero e vado avanti
% esegue  contratto2, terminando correttamente
% Con2 = Contratto2 
% Ret = Risultato esecuzione (1 qui) ; VarRet = Variabili di ritorno
exec_called(Calldata, EnvList1, Con2, FName, ExFName, Lab, Input, Output, Env1C2, EvaluatedOutputs, Ret, EnvList3):-
    %create_ret_at(ExFName, L1),
    extract_last_label(Lab, L1),
    create_input_list(Calldata, Input, Env1C2, InputList),


    CfSupp = cf(cmd(Con2, Lab, fun_call(FName, InputList, Output)),  EnvList1),
    reachable(CfSupp, CfSupp2),

    CfSupp2 = cf(cmd(Con2, L1, Cmd), EnvList2),

    %estraggo l'env aggiornato del contratto c2
    lookup_env(Con2, EnvList2, EnvFC2),
                writeln(['L1 ', L1, 'Cmd ', Cmd]),
          
    pl_ops( Ret is 1), 
    eval_outputs(Output, EnvFC2, EvaluatedOutputs),
    assign_outputs(VarRet, EvaluatedOutputs, EnvFC2, EnvFC3),
                nl,nl,
                writeln(['VarRet ', VarRet, 'EvaluatedOutputs ', EvaluatedOutputs ]),
                nl,nl,
    
    %elimino il frame della funzione chiamata altrimenti genera errore 
    % quando viene effettuata una seconda chiamata alla funzione
    pop_frame(EnvFC3, EnvFC4),
    %aggiorno l'Env generale
    update_env(EnvList2, Con2, [EnvFC4], EnvList3),
                nl,nl,
                writeln(['EnvList3 ', EnvList3]),
                nl,nl.



% ho già l'env del chiamato nella lista, quindi lo recupero e vado avanti
% esegue  contratto2, terminando con il revert 
% Con2 = Contratto2 
% Ret = Risultato esecuzione (0 qui) ; VarRet = Variabili di ritorno
exec_called(Calldata, EnvList1, Con2, FName, ExFName, Lab, Input, Output, Env1C2, EvaluatedOutputs, Ret, EnvList3):-
    extract_revert_label(Con2, FName,  RevertLabel), 
    create_input_list(Calldata, Input, Env1C2, InputList),

    CfSupp = cf(cmd(Con2, Lab, fun_call(FName, InputList, Output)),  EnvList1),
                nl,nl,
                writeln(['EnvList1', EnvList1]),
                nl,nl,

    reachable(CfSupp, CfSupp2),

    CfSupp2 = cf(cmd(Con2, RevertLabel, Cmd), EnvList2),
                writeln(['RevertLabel ', RevertLabel, 'Cmd ', Cmd]),
                nl,nl,
  
    %non serve controllare output perchè sono nel caso del revert
    %non serve aggiornare l'ambiente perchè sono nel caso del revert
    %quindi devo solo "propagare" l'errore impostando i risultati a 0
    % e dicendo che l'env generale non è cambiato
    pl_ops( Ret is 0), 
    pl_ops( EvaluatedOutputs is 0),
    EnvList3 = EnvList1,
    EnvFC3 = Env1C2.



%crea l'env per il contratto chiamato
init_env_called_cont(IList, Con2, Env0C2 ):-
    initConfFor2(Con2, IList, CfInitC2),
    CfInitC2 = cf(_Cmd, Env0C2), 
                nl,
                writeln(['Create init Conf For ', Con2, ' : ', CfInitC2]),
                nl.
    


% Data = porzione da cui estrare la signature    
% a partire dal contratto 2 trova: 
% il nome della funzione --> signature_lookup
% la label della fun_call alla funzione interessata -->  at_lookup
% estrae informazioni necessarie, come la lista di input / output richiesti dalla funzione
% inserisce un frame nei locals necessaria nel caso di input / output (altrimenti la fun_call fallisce) -->     
extract_conf_called_cont(Env0C2, Con2, Data, FName, ExFName, Lab, Input, Output, Env1C2):-   
     
    signature_lookup(Con2, Data, ExFName, FName),
                writeln(['Function Name ', FName, ' External function: ', ExFName]),
                nl,
    at_lookup(Con2, FName, Lab),
                writeln(['Function Call Label ', Lab]),
                nl,
    
    ex_i_o_fun_call(Con2, FName, Label, Input, Output),
                nl,nl,
                writeln(['I :  ', Input, ' O : ', Output]),
                nl,
    %eval_list(Input, Env0C2, Vs),
    %build_funenv_invert(ExFName, Vs, Frame),
    %push_frame(Env0C2, Frame, Env1C2).
    fun(Con2, ExFName, _Params, Locals, _Entry),
    initialize_locals(Locals, Frame),
    push_frame(Env0C2, Frame, Env1C2).




%prima parte della chiamata 
% a partire dal contratto 2 trova: 
% il nome della funzione --> signature_lookup
% la label della fun_call alla funzione interessata -->  at_lookup
% estrae informazioni necessarie, come la lista di input / output richiesti dalla funzione
% inserisce un frame nei locals necessaria nel caso di input / output (altrimenti la fun_call fallisce) --> 
create_initial_configuration(IList, Con2, Data, FName, ExFName, Lab, Input, Output, Env1C2 ):-
    initConfFor2(Con2, IList, CfInitC2),
                nl,nl, 
                writeln(['List and Env ', Con2, ' : ', CfInitC2]),
                nl,nl,
    CfInitC2 = cf(_Cmd, Env0C2), 
                nl,nl, 
                writeln(['Create init Conf For ', Con2, ' : ', CfInitC2]),
                nl,nl,
                writeln(['Initial Env for ', Con2, ' : ', Env0C2]),
                nl,nl,
    %signature_lookup(Con2, Data, FName),
    signature_lookup(Con2, Data, ExFName, FName),
                writeln(['Function Name ', FName, ' External function: ', ExFName]),
                nl,nl,
    at_lookup(Con2, FName, Lab),
                writeln(['Function Call Label ', Lab]),
                nl,nl, 
    
    ex_i_o_fun_call(Con2, FName, Label, Input, Output),
                nl,nl,
                writeln(['I :  ', Input, ' O : ', Output]),
                nl,nl,

    build_funenv_invert(ExFName, Vs, Frame),
    push_frame(Env0C2, Frame, Env1C2).

%valuta l'esistenta di input / output e crea le corrispondenti liste da inserire nella fun_call 




%trova la funzione che corrisponde alla signature
signature_lookup(Con2, FragmentHex, SOExFName, FName) :-
    signatures(Con, Pairs),
    member((ExFName, StoredHex), Pairs),
    sub_atom(StoredHex, _, _, _, FragmentHex),
    atom_concat('external_', Name, ExFName),
    atom_concat('subO_', Name, FName),
    atom_concat('subO_external_', Name, SOExFName). 

%trova la label che corrisponde alla chiamata di funzione
at_lookup(Con2, FName, Label) :-
    at(Con2, Label, fun_call(FName, _, _)).


%estrae lista input e output della chiamata di funzione 
ex_i_o_fun_call(Con2, FName, Label, Input, Output):-
    at(Con2, Label, fun_call(FName, Input, Output)).


%crea la label che corrisponde alla corretta terminazione della chiamata di funzione (_ret --> ret([_]))
create_ret_at(FName, Label) :-
    atom(FName),
    atom_concat(FName, '_ret', Label).



%trova la label che corrisponde al revert della chiamata di funzione
extract_revert_label(Con, Fname,  Label) :-
    at(Con, Label, revert([_,_])),
    atom_concat(Fname, Rest, Label),
    atom_chars(Rest, ['_'|_]). 


extract_last_label(Label, NewLabel) :-
    % ricavo stringa e ricordo il tipo di ritorno
    (  atom(Label)   -> atom_string(Label, LabelStr), ReturnAtom = true
    ;  string(Label) -> LabelStr = Label, ReturnAtom = false
    ),

    % divido sui '_' e separo l'ultima parte
    split_string(LabelStr, "_", "", Parts),
    Parts \= [],
    append(Init, [Last], Parts),

    % Last deve essere una rappresentazione numerica
    number_string(N, Last),
    N1 is N + 1,
    number_string(N1, NewLast),

    % ricompongo l'etichetta
    append(Init, [NewLast], NewParts),
    atomic_list_concat(NewParts, '_', NewLabelAtom),

    % riconverto al tipo richiesto
    (  ReturnAtom -> NewLabel = NewLabelAtom
    ;  atom_string(NewLabelAtom, NewLabel)
    ).




extract_call_label(Con2, FName,  CallLabel):-
    at(Con, Label, call([_,_,_,_,_,_,_],_)),
    atom_concat(Fname, Rest, Label),
    atom_chars(Rest, ['_'|_]). 


%controlla se la funzione richiede o meno  una lista di dati di input 
%se la lista è vuota, viene restituita come tale 
%nel caso in cui sono necessari degli input devono essere presi dalla memoria

prepare_reverse_list([_Head|Tail], ReversedTail) :-
    reverse(Tail, ReversedTail).


%TO DO: decommenta
create_input_list(_Calldata, [], _Env, []):- !.

create_input_list(Calldata, Input, Env, InputList):- 
    length(Input, K),
    nl,nl,
    writeln(['lunghezza: ', K, Input]),
    %lookup_evm('calldata', Env, Data),
    %so che devo estrarre tante informazioni quante sono le variabili richeiste come input
    (
    
        (K =:= 1) -> 
            ( 
                %wrappa e crea la input list
                InputList = Calldata,                
                writeln(['InputList: ', InputList])
            )
            ;
            (
                prepare_reverse_list(Calldata, InputList),
                writeln(['Calldata: ', Calldata, ' InputList: ', InputList])
            )    

    ).
  


create_calldata([], _Env, '').
create_calldata([X|T], Env, Call) :- !,
    eval_arg(X, Env, V), 
    atom_concat('0x', V, V1), 
    atom_number(V1, N),
    format(atom(H), '~`0t~16r~64|', [N]), 
    create_calldata(T, Env, Call2),
    atom_concat(H, Call2, Call).




% crea il valore che va inserito all'interno dello spazio di memoria destinato all'output 
% li concatena come se fossero uno dopo l'altro

% se List è [X] un solo elemento --> Result = X
% se List ha più elementi --> concatena
extract_results([], 0).
extract_results([X], X) :- !.
extract_results([H|T], Result) :-
    List = [H|T],
    maplist(number_codes, List, CodesLists),        % trasforma ogni numero in lista di char
    append_all(CodesLists, AllCodes),               % concatena tutte le liste di char
    number_codes(Result, AllCodes).                 % ricostruisce il numero
        


% helper
append_all([], []).
append_all([L|Ls], R) :-
    append_all(Ls, Rest),
    append(L, Rest, R).



update_env_aft_call(Env1, R0, EvaluatedOutputs, Gas, Wei, OutOff, Envf):-
        eval_arg(R0, Env1, R), 
        (
            (R =:= 0) -> (
                           update_after_call_f(Env1, Gas, Env2), 
                           update(Env1, mem(OutOff), 0, Envf)
                         ) 
                         ;
                         (
                            update_after_call_t(Env1, Gas, Wei, Env2),
                            extract_results(EvaluatedOutputs, Result),
                            create_calldata(EvaluatedOutputs,Env2, ReturnData),
                            nl,nl, writeln(['Result after call: ', ReturnData]),
                            update(Env2, 'returndata', ReturnData, Env3),
                            update(Env3, mem(OutOff), Result, Envf)
                         )     
        ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

do_ex_call(Env0, R0, Gas, Wei, Envf):-
    %sviluppo punto 3
    Val = 0,
    update_after_call_f(Env, Gas, Env1), 
    update(Env1, R0, Val, Envf),
    nextlab(Con, L, L1),
    at(Con, L1, C).

do_ex_call(Env0, R0, Gas, Wei, Envf):-
    %sviluppo punto 3 
    Val = 1,
    update_after_call_t(Env, Gas, Wei, Env1), 
    %imposto le varibili globali a variabili libere
    d_free_variable(Env1, Env2),
    update(Env2, R0, Val, Envf),
    nextlab(Con, L, L1),
    at(Con, L1, C).




% TO DO : sistemare per non sottratte tutto il gas ma solo in parte? 
update_after_call_t(Env, Gas, Wei, Env2):-
    lookup_evm('gas', Env, X1), 
    lookup_evm('balance', Env, X2),
    pl_ops(NewGas is X1 - Gas),
    pl_ops(NewBalance is X2 - Wei),
    update(Env, 'gas', NewGas, Env1),
    update(Env1, 'balance', NewBalance, Env2).


%quando la chiamata genera un revert per balance o gas insufficente prima 
%di effettuare la chiamata stessa
update_after_call_f(Env, Gas, Env1):-
    lookup_evm('gas', Env, X1),
     writeln(['gas ', X1]),
    (
        ( X1 >= Gas ) ->
        (
            pl_ops(NewGas is X1 - Gas),
            writeln('Gas sufficiente')
        )
    ;
        (
            pl_ops(NewGas is 0),
            writeln('Gas INsufficiente')
        )
    ),
    update(Env, 'gas', NewGas, Env1).



d_free_variable(Env1, Env2):-
    Env1 = (Con, (D, M0, S0)),
    initGLB(Con, D0),
    Env2 = (Con, (D0, M0, S0)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% function calls  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Aggiunge un nuovo frame vuoto in cima allo stack
%push_frame(S, F, [F|S]).
push_frame((Con, (D,M,S)), F, (Con, (D,M,[F|S]))).

% Rimuove il frame in cima, restituendo il resto dello stack
%pop_frame([_Top|Rest], Rest).
pop_frame((Con,(D,M,[_Top|Rest])), (Con,(D,M,Rest))).

% Valuta ciascuna espressione nella lista degli argomenti Es nell'ambiente corrente Env ottenendo la lista dei valori Vs
eval_list([], _Env, []).
eval_list([off(K)|Es], Env, [off(K)|Vs]):- 
    eval_list(Es, Env, Vs).

eval_list([E|Es], Env, [V|Vs]):-
    eval_arg(E, Env, V),
    eval_list(Es, Env, Vs).

% Costruisce il frame (cioè l'ambiente locale) per la funzione F, inizializzando i parametri con i valori Vs e predisponendo le variabili locali (secondo la firma della funzione)
build_funenv(F, Vs, Frame) :- 
    fun(F, Params, Locals, _Entry),
    build_params_frame(Params, Vs, FrameParams),
    initialize_locals(Locals, FrameLocals),
    append(FrameParams, FrameLocals, Frame).

pair_params_values([], [], []).
pair_params_values([var(K)|Ps], [V|Vs], [(K, V)|Rest]) :-
    pair_params_values(Ps, Vs, Rest).

build_params_frame_invert(Params, Vs, Frame) :-
    inverti_lista(Params, ParamsInv),
    pair_params_values(ParamsInv, Vs, Frame).

build_funenv_invert(F, Vs, Frame) :-
    fun(Con, F, Params, Locals, _Entry),
    build_params_frame_invert(Params, Vs, FrameParams),
    initialize_locals(Locals, FrameLocals),
    append(FrameParams, FrameLocals, Frame).


% Associa ogni parametro al corrispondente valore.
build_params_frame([], [], []).
build_params_frame([var(K)|Ps], [V|Vs], [(K, V)|FrameParams]) :- 
    build_params_frame(Ps, Vs, FrameParams).

% Inizializza le variabili locali a un valore 0 (o lasciate non definite).
initialize_locals([], []).
initialize_locals([var(K)|Ls], [(K, 0 )|FrameLocals]) :- 
    initialize_locals(Ls, FrameLocals).

% Estrae il label d'ingresso dalla definizione della funzione.
firstlab(F, FL) :- 
    fun(Con, F, _Params, _Locals, FL).

% Predicato per valutare una lista di espressioni di ritorno.
eval_outputs([], Env, []).
eval_outputs([V|Vs], Env, [Val|Vals]) :- 
    eval_arg(V, Env, Val),
    eval_outputs(Vs, Env, Vals).

% Predicato per assegnare in ordine i valori valutati alle variabili di output.
assign_outputs([], [], Env, Env).
assign_outputs([var(Key)|RestVars], [Val|RestVals], Env, Env2) :- 
    update(Env, var(Key), Val, Env1),
    assign_outputs(RestVars, RestVals, Env1, Env2).

% Predicato principale
inverti_lista(Lista, ListaInvertita) :-
    inverti_lista_acc(Lista, [], ListaInvertita).
% Caso base: lista vuota
inverti_lista_acc([], Acc, Acc).
% Caso ricorsivo: sposta la testa della lista originale nell'accumulatore
inverti_lista_acc([Testa|Coda], Acc, ListaInvertita) :-
    inverti_lista_acc(Coda, [Testa|Acc], ListaInvertita).


