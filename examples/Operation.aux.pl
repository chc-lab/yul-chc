% used EVM variable
evm_globals(['msg.value']).
% property
prop(Env1, Cf0, []) :-
    Cmd = cmd('subO_external_fun_PositiveDifference_45_Block2_3', fun_call(subO_fun_PositiveDifference_45, [num(25), num(99)], [])),
    Cf0 = cf(Cmd,Env1).
:- retract(
  at('subO_fun_PositiveDifference_45_ret', ret([var(v27)]))
).
:- assert( 
  at('subO_fun_PositiveDifference_45_ret', ret([]))
).        