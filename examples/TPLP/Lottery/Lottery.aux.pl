%versione corretta
%la proprietà controlla che i giocatori vengano scritti nella posizione corretta quando vengono registrati


% used EVM variable
evm_globals(['msg.value', 'calldata', 'msg.sender', 'bnumber', 'balance', 'gas']).

% property
prop(Env1, Cf0, [

  V100 = 80,				% gas
	V101 = 10000000000000000, 		% 0.01 eth
	V20 = 20000000000000000,		% 2 * 10000000000000000   (2 partecipanti che hanno versato esattamente 0.01 eth) 
	V22 = 0xa6606acb,			% calldata 
	V00 = 2,				% num partecipanti 
	V01 = 100,				% start = 100
	V02 = 100,				% durata = 100
	V03 = 130,				% num blocco corrente
	V04 = 0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fd3,	%player 1 
  V05 = 0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fd3, 	%player 2
  V6 = 0xabc1237

]):-    	

  update(Env1,'gas', V100 , Env2), 
  update(Env2,'msg.value', V101 ,Env3),     % deve essere esattamente 0.01 eth
  update(Env3,'msg.sender', V6 ,Env4), 
  update(Env4,'balance', V20 ,Env5),
  update(Env5,'calldata', V22 ,Env6),
  update(Env6, off(0x00), V00 , Env7),  %correct		%impostiamo playerCount = 2
  update(Env7, off(0x01), V01 , Env8), 		%impostiamo start = 100
  update(Env8, off(0x02), V02 , Env9), 		%impostiamo duration = 100    
  update(Env9,'bnumber', V03 , Env10), 		%impostiamo bnumber = 130 (il numero del blocco corrente)  
  update(Env10, off(0x03), V04 , Env11), 		%impostiamo dei valori per i players  
  update(Env11, off(0x04), V05 , Env12), 		%impostiamo dei valori per i players  

  Cmd = cmd('subO_external_fun_enter_64_Block0_3', fun_call(subO_fun_enter_64, [], [])),

  Cf0 = cf(Cmd,Env12).

%%%%
:- retract(
  at('start_contract', fun_call(init_contract, [], []))
).
:- assert(
  at('start_contract', fun_call(obj_constructor_Lottery_132, [num(30)], [])) 
).

:- initialization(detect_jps).
