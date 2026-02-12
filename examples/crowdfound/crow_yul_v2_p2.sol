// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

contract Crowdfund {
    uint  end_donate;       		 // slot 0
    uint  goal;              		 // slot 1
    address  owner;          		 // slot 2
    uint256 public totalHeld; 		 // slot 3
    uint256 public totDonors; 		 // slot 4
    address[10] public donors;   	 // slots 5..14
    uint256[10] public donations;	 // slots 15..24

    constructor (address payable owner_, uint end_donate_, uint256 goal_) {
        owner = owner_;
        end_donate = end_donate_;
        goal = goal_;
    }

    function donate() public payable {
        assembly {
            // require(block.number <= end_donate)
            let bn := number()
            let end := sload(0)
            if gt(bn, end) { revert(0,0) }

            // require (totDonors < 10)
            let td := sload(4)
            if iszero(lt(td, 10)) { revert(0,0) }

            // donations[totDonors] += msg.value
            let donations_slot := add(15, td)
            let prev := sload(donations_slot)
            let newdon := add(prev, callvalue())
            sstore(donations_slot, newdon)

            // donors[totDonors] = msg.sender
            let donors_slot := add(5, td)
            sstore(donors_slot, caller())

            // totalHeld += msg.value
            let th := sload(3)
            sstore(3, add(th, callvalue()))

            // totDonors += 1
            sstore(4, add(td, 1))
        }
    }



    function withdraw() public {
        assembly {
            // require(block.number > end_donate)
            let bn := number()
            let end := sload(0)
            if iszero(gt(bn, end)) { revert(0,0) }

            // require(address(this).balance >= goal)
            let bal := balance(address())
            let g := sload(1)
            if lt(bal, g) { revert(0,0) }

            // totalHeld = 0
            sstore(3, 0)

            // owner.call{value: address(this).balance}("")
            let ownerAddr := sload(2)
            let sendVal := balance(address())

            // perform the call: call(gas, to, value, inMem, inSize, outMem, outSize)
            let success := call(gas(), ownerAddr, sendVal, 0, 0, 0, 0)
            if iszero(success) { revert(0,0) }
        }
    }



    function reclaim() public {
        assembly {
            // require(block.number > end_donate)
            let bn := number()
            let end := sload(0)
            if iszero(gt(bn, end)) { revert(0,0) }

            // require(address(this).balance < goal)
            let bal := balance(address())
            let g := sload(1)
            if iszero(lt(bal, g)) { revert(0,0) }

            // local vars in Yul
            let amount := 0
            let i := 0
            let td := sload(4)

            // for (i=0; i<totDonors; i++) { ... }
            for { } lt(i, td) { i := add(i, 1) } {
                // if (donors[i] == msg.sender)
                let donors_slot := add(5, i)
                let d := sload(donors_slot)
                if eq(d, caller()) {
                    // amount += donations[i]
                    let donations_slot := add(15, i)
                    let donated := sload(donations_slot)
                    amount := add(amount, donated)

                    // donations[i] = 0
                    sstore(donations_slot, 0)

                    // donors[i] = address(0)
                    sstore(donors_slot, 0)
                }
            }

        }

	for(uint i=0; i<totDonors; i++){assert(donors[i] != msg.sender);}

    }
}
