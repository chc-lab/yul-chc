%il contratto deve partire con un proprietario (primo msg.sender =  0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fd3) 
%questo è memorizzato nella posizione off(0x00)
% il valore passato come input nella funzione di chiamata sarà un address corrispondente al nuovo proprietario 

%se si vuole far fallire, si possono fare due cose: 
%1. passare un valore errato come input (più grande) 
%2. mettere come msg.sender un valore diverso da quello memorizzato in off(0x00)


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

    Cmd = cmd('subO_external_fun_transferOwnership_82_Block0_3', fun_call(subO_fun_transferOwnership_82, [num(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)], [])),                       %correct - commit

    Cf0 = cf(Cmd,Env6).

%%%
:- initialization(detect_jps).
