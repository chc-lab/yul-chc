// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.18;
 
contract Lottery {
    
    uint256 private playerCount;            // slot 0
    uint256 private start;                  // slot 1
    uint256 private duration;               // slot 2
    uint256 private fee;                    // slot 3
    address[300] private players;           // base slot 4 (elements at 4..303)

    constructor(uint duration_) {
        start = block.number;
        duration = duration_;
    }
    
 
    function enter() public payable {
    	require(msg.value == 0.01 ether);
    	require(block.number < start + duration);
    	require(playerCount < 300);

    	players[playerCount] = msg.sender;
    	playerCount += 1;
	
    }   
 
 	function random() private view returns (uint) {
        	return uint(keccak256(abi.encode(block.prevrandao)));
    }
    
        function pickWinner() public {

        require(block.number >= start + duration);
	require(address(this).balance > 0);
	require(playerCount > 0);
	
	uint256 oldBalance = address(this).balance;

	uint idx = random() % playerCount;
       
	address winner = players[idx]; 

        fee = address(this).balance / 100;
	
        (bool success,) = msg.sender.call{value: fee}("");
        require(success); 
        
	assert (address(this).balance == oldBalance - fee);

        (bool success_winner,) = winner.call{value: address(this).balance}("");
        require(success_winner);    

    }


}
