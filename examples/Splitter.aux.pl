% used EVM variable
evm_globals([
    'address',
    'balance',
    'msg.sender',
    'msg.value'
]).
% property
prop(Env1, Cf0, [
        V100=50,
        V101=20,
        V102=30,
        V6=0xabc123,
        V20=10,
        V8=0xbbbb123,
        V30=90          %return
        %V30=80          %revert
    ]) :-
    update(Env1,off(0x06), V100, Env2), 
    update(Env2,off(0x07), V101, Env3), 
    update(Env3,off(0x08), V102, Env4), 
    update(Env4,'msg.sender',V6, Env5), 
    update(Env5,off(0x0d),  V20, Env6), 
    update(Env6,off(0x09),  V20, Env7), 
    update(Env7,'address',  V8,  Env8),
    update(Env8,off(0xbbbb123), V30, Env9),     
    update(Env9,'balance',     V30, Env10), 
    Cmd = cmd('subO_external_fun_releasable_259_Block2_3', fun_call(subO_fun_releasable_259, [num(0xabc123)], [])),
    Cf0 = cf(Cmd,Env10).
%%%%
:- retract(
  at('start_contract', fun_call(init_contract, [], []))
).
:- assert(
  at('start_contract', 
    fun_call(obj_constructor_Splitter_355,[num(30), num(0xdef456), num(20), num(0xcba321), num(50), num(0xabc123)],[]))
).
:- retract(
  at('subO_fun_releasable_259_ret', ret([var(v86)]))
).
:- assert( 
  at('subO_fun_releasable_259_ret', ret([]))
).    