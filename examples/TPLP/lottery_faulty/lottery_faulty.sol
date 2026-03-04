// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.18;

import {Ownable} from "./ownable_modified.sol";
 
contract Lottery is Ownable {
    
    uint256 private playerCount;   // slot 0
    uint256 private start;         // slot 1
    uint256 private duration;      // slot 2
    address[300] private players;  // base slot 3 (elements at 3..303)

	constructor(uint duration_) {
		start = block.number;
		duration = duration_;
		_setOwner(msg.sender);
	}

 
	function enter() public payable {
		require(msg.value == 0.01 ether);
		require(block.number < start + duration);
		require(playerCount < 300);

		assembly {
			let count := sload(0x00) // playerCount
			let playerSlot := add(count, 0x03) // players[playerCount]
			sstore(playerSlot, caller()) // players[playerCount] = msg.sender
			count := add(count, 0x01) // 
			sstore(0x00, count) // counter += 1
		}
		assert(players[playerCount - 1] == msg.sender);

	}   

    
	function pickWinner() public onlyOwner {
		require(block.number >= start + duration);
		require(address(this).balance > 0);
		require(playerCount > 0);

		address winner;
		uint256 pick_fee;

		assembly {
			function random() -> rand {
				// Load pointer to free memory
        		let ptr := mload(0x40)
        
        		// Prevrandao as a source of randomness (could be improved)
        		let v := prevrandao()
        
        		// Store the value at the pointer
        		mstore(ptr, v)
        
		        // Compute the hash value of prevrandao
        		rand := keccak256(ptr, 0x20)
        	}

			let rand := random()
			let countValue := sload(0x00) // playerCount
			let winnerIdx := mod(rand, countValue) // random() % playerCount
			winner := sload(add(0x03, winnerIdx)) // players[idx]
			let balan := selfbalance() // address(this).balance
			pick_fee := div(balan, 100) // address(this).balance / 100
		}

		// Pays a fee of balance / 100
		(bool success,) = msg.sender.call{value: pick_fee}("");
		require(success); 

		// Remaining funds are transferred to the winner
		(bool success_winner,) = winner.call{value: address(this).balance}("");
		require(success_winner);     
		
	}
}
