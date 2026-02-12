// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >=0.8.2;

contract Crowdfund {

    uint end_donate;    		// slot 0 
    uint goal;          		// slot 1
    address owner;     			// slot 2
    uint256 public totalHeld;     	// slot 3
    address donor;      		// slot 4

    constructor (address payable owner_, uint end_donate_, uint256 goal_, address _donor) {
        assembly {
            sstore(0, end_donate_)
            sstore(1, goal_)
            sstore(2, owner_)
            sstore(4, _donor)
        }
    }

    function donate() public payable {
        assembly {

            // require(block.number <= end_donate)
            let endd := sload(0)
            if gt(number(), endd) {
                revert(0, 0)
            }

            // totalHeld += msg.value
            let current := sload(3)
            sstore(3, add(current, callvalue()))
        }


        assert(address(this).balance >= totalHeld);
    }

    function withdraw() public {
        assembly {

            // require(block.number > end_donate)
            let endd := sload(0)
            if iszero(gt(number(), endd)) {
                revert(0, 0)
            }

            // require(address(this).balance >= goal)
            let g := sload(1)
            if lt(balance(address()), g) {
                revert(0, 0)
            }

            // totalHeld = 0
            sstore(3, 0)

            // prepare call to owner with full balance
            let bal := balance(address())
            let ownerAddr := sload(2)

            // (bool succ,) = owner.call{value: bal}("");
            let success := call(gas(), ownerAddr, bal, 0, 0, 0, 0)
            if iszero(success) {
                revert(0, 0)
            }
        }
    }

    function reclaim() public {
        assembly {

            // require(block.number > end_donate)
            let endd := sload(0)
            if iszero(gt(number(), endd)) {
                revert(0, 0)
            }

            // require(address(this).balance < goal)
            let g := sload(1)
            if iszero(lt(balance(address()), g)) {
                revert(0, 0)
            }

            // require(totalHeld > 0)
            let th := sload(3)
            if iszero(gt(th, 0)) {
                revert(0, 0)
            }

            // amount = totalHeld; totalHeld = 0
            let amount := th
            sstore(3, 0)

            // (bool succ,) = donor.call{value: amount}("");
            let donorAddr := sload(4)
            let success := call(gas(), donorAddr, amount, 0, 0, 0, 0)
            if iszero(success) {
                revert(0, 0)
            }
        }
    }
}
