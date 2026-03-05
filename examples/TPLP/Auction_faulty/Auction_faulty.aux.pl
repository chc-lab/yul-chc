% used EVM variable
evm_globals([
    'address',
    'balance',
    'calldata', 
    'gas',
    'msg.sender',
    'msg.value'
]).
% property
prop(Env1, Cf0, [
        V1 = 0x08,           % bid - bid of previous winner (*) - cousing revert
        V2 = 0x07,           % cash - any value >= bid
        V3 = 0xcba321cba321, % winner - any addressed diffent from msg.sender (*)  
        V4 = 1025,           % wei    
        V5 = 0xabc123abc123,
        V6 = 0xabc123abc123,
        V1 = V7
    ]) :-
    update(Env1, off(0), V1, Env2), 
    update(Env2, off(1), V2, Env3), 
    update(Env3, off(2), V3, Env4), 
    update(Env4,'msg.value',  V4 ,Env5), 
    update(Env5,'msg.sender', V5 ,Env6), 
    update(Env6,'gas',        V6 ,Env7),
    update(Env7,'balance',    V7 ,Env8),
    Cmd = cmd('subO_external_fun_offer_84_Block0_3',fun_call(subO_fun_offer_84,[],[])),
    Cf0 = cf(Cmd,Env8).

:- initialization(detect_jps).