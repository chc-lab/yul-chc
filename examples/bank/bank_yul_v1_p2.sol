//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract Bank {
    
    uint256 balance_a;
    address a;

    constructor () {
       a = msg.sender;
    }

    function deposit() public payable {
        uint256 newb;

        assembly {

            // require(msg.value > 0)
            if iszero(gt(callvalue(), 0)) { revert(0, 0) }

            // bal = balance_a 
            let bal := sload(0)
		
	    // val = msg.value
            let val := callvalue()

	    //newbal = balance_a + msg.value
            let newbal := add(bal, val)

	    // balance_a = newbal
            sstore(0, newbal)

            // uint256 newb = address(this).balance;
            newb := balance(address())
        }

        assert(newb >= balance_a);
    }

    function withdraw(uint amount) public {
    	
    	//inserted outside the assembly because otherwise you get: Assembly access to immutable variables is not supported.
	address recipient = a; 
        	
       assembly {

	    //require(msg.sender == a);
            if iszero(eq(caller(), recipient)) { revert(0, 0) }

            //require(amount > 0);
	    if iszero(gt(amount, 0)) { revert(0, 0) }

            //require(amount <= balance_a);
            let bal := sload(0)
	    if lt(bal, amount) { revert(0, 0) }

            // newbal = balance_a - amount
            let newbal := sub(bal, amount)

	    // balance_a = newbal
            sstore(0, newbal)
	    
	    // call
            let success := call(gas(), caller(), amount, 0, 0, 0, 0)
            if iszero(success) { revert(0, 0) }

        }
    }

}
