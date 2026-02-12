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
        uint256 oldc; 

        assembly {

            //require(msg.value == 0.01 ether);
            if iszero(eq(callvalue(), 10000000000000000)) {
                revert(0, 0)
            }

            //require(block.number < start + duration);
            let st := sload(1)
            let dur := sload(2)
            if iszero(lt(number(), add(st, dur))) {
                revert(0, 0)
            }

            // require(playerCount < 300);
            let pl_c := sload(0)
            if iszero(lt(pl_c, 300)) {
                revert(0, 0)
            }

            //uint256 oldc = playerCount;
            oldc := pl_c

            //players[playerCount] = msg.sender;
            // players is fixed array at base slot 4, element i is stored at slot (4 + i)
            let slot := add(4, pl_c)
            sstore(slot, caller())

            //playerCount += 1;
            sstore(0, add(pl_c, 1))
        }

        assert(playerCount == oldc + 1);
    }
 

    function pickWinner() public {
        assembly {
            //require(block.number >= start + duration);
            let st := sload(1)
            let dur := sload(2) 
            if lt(number(), add(st, dur)) {
                revert(0, 0)
            }

            //require(address(this).balance > 0);
            if iszero(gt(balance(address()), 0)) {
                revert(0, 0)
            }

            //require(playerCount > 0);
            if iszero(gt(sload(0), 0)) {
                revert(0, 0)
            }
	    
	    }
	    
	   //lasciamo la chiamata alla funzione random in solidity
	    uint idx = random() % playerCount;

	     assembly {

            //address winner = players[idx];
            let winnerSlot := add(4, idx)
            let winner := sload(winnerSlot)

            // fee = address(this).balance / 100;
            let bal := balance(address())
            let computedFee := div(bal, 100)
            sstore(3, computedFee)

            // (bool success,) = msg.sender.call{value: fee}("");
            let success := call(gas(), caller(), computedFee, 0, 0, 0, 0)
            if iszero(success) {
                revert(0, 0)
            }

            // (bool success_winner,) = winner.call{value: address(this).balance}("");
            let newBal := balance(address())
            let succ2 := call(gas(), winner, newBal, 0, 0, 0, 0)
            if iszero(succ2) {
                revert(0, 0)
            }
        }
    }


        function random() private view returns (uint r) {
        assembly {
            // return uint(keccak256(abi.encode(block.prevrandao)));
            let ptr := mload(0x40)        // puntatore alla memoria libera
            mstore(ptr, prevrandao())    // salva block.prevrandao in memoria
            r := keccak256(ptr, 0x20)    // keccak256 
        }
    }
}
