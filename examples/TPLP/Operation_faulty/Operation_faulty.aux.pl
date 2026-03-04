% bug: sub(y, x) insted of sub(x, y) when y > x 
% here x = 25 and y = 99
% should fail and stop at panic_error

% used EVM variable
evm_globals(['msg.value']).
% property
prop(Env1, Cf0, []) :-
    Cmd = cmd('subO_external_fun_positiveDifference_38_Block2_3', fun_call(subO_fun_positiveDifference_38, [num(25), num(99)], [])),
    Cf0 = cf(Cmd,Env1).

:- retract(
 at('subO_fun_positiveDifference_38_ret', ret([var(v25)]))
).
:- assert( 
 at('subO_fun_positiveDifference_38_ret', ret([]))
).

:- initialization(detect_jps).