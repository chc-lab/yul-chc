%faulty version

%the contract must start with an owner (first msg.sender = 0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fd3) 
%this is stored in the off position (0x00)
%the value passed as input to the call function will be a bytes32 
%(instead of an address). This leads to the assert failing. 

%anche questo può far fallire modificando l'msg.sender


% used EVM variable
evm_globals(['msg.value', 'msg.sender', 'gas', 'balance']).

% property
prop(Env1, Cf0, [


    V1 = 0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fd3, 	%owner
    V4 = 1025, % wei
   	V5 = 0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fd3, 
	  %V5 = 0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fc2,   %msg.sender - revert
    V6 = 0xabc123abc123,
    V7 = 1025 % wei

]) :-    	

	update(Env1, off(0x00),   V1, Env2), 			%owner
  update(Env2,'msg.value',  V4 ,Env3), 
  update(Env3,'msg.sender', V5 ,Env4), 
  update(Env4,'gas',        V6 ,Env5),
	update(Env5,'balance',    V7 ,Env6),

  Cmd = cmd('subO_external_fun_unsafeTransferOwnership_99_Block0_3', fun_call(subO_fun_unsafeTransferOwnership_99, [num(0x1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b)], [])),                       %faulty - revert

  Cf0 = cf(Cmd,Env6).

%%%
:- initialization(detect_jps).       
