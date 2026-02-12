// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.18;
 
contract Lottery {
    
    uint256 private playerCount;            
    uint256 private start;                  
    uint256 private duration;               
    uint256 private fee;                    
    address[300] private players;           

    constructor(uint duration_) {
        start = block.number;
        duration = duration_;
    }
    
 
    function enter() public payable {
        require(msg.value == 0.01 ether);
        require(block.number < start + duration);
	require(playerCount < 300);
	
	uint256 oldc = playerCount;
	
	players[playerCount] = msg.sender;
	
        playerCount +=1;

	assert ( playerCount == oldc +1 );
    }   
 
 
    function random() private view returns (uint) {
        return uint(keccak256(abi.encode(block.prevrandao)));
    }

    
        function pickWinner() public {

        require(block.number >= start + duration);
	require(address(this).balance > 0);
	require(playerCount > 0);

	uint idx = random() % playerCount;
       
	address winner = players[idx]; 

        fee = address(this).balance / 100;
	
        (bool success,) = msg.sender.call{value: fee}("");
        require(success); 
        
        (bool success_winner,) = winner.call{value: address(this).balance}("");
        require(success_winner);     
          

    }

 
} 