// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Splitter {

    // payees
    address payable public payee0;
    address payable public payee1;
    address payable public payee2;

    // fixed shares (amount each must deposit every time)
    uint256 public share0;
    uint256 public share1;
    uint256 public share2;

    // cumulative deposits
    uint256 public amountp0;
    uint256 public amountp1;
    uint256 public amountp2;

    // amount already released to each
    uint256 public released0;
    uint256 public released1;
    uint256 public released2;

    // control data
    // sum of share0 + share1 + share2
    uint256 private totalShares; 
    // sum of released0 + released1 + released2
    uint256 private totalReleased; 
    

    constructor(address payable p0, uint256 s0, address payable p1, uint256 s1, address payable p2, uint256 s2) {
        require(p0 != address(0) && p1 != address(0) && p2 != address(0), "zero addr");
        require(s0 > 0 && s1 > 0 && s2 > 0, "min share");

        payee0 = p0;  
        share0 = s0;
        payee1 = p1; 
        share1 = s1;
        payee2 = p2;  
        share2 = s2;

        totalShares = s0 + s1 + s2;

    }

    receive() external payable {
        // each must deposit EXACTLY their share
        if (msg.sender == payee0) {
            require(msg.value == share0, "wrong share");
            amountp0 += msg.value;
        } else if (msg.sender == payee1) {
            require(msg.value == share1, "wrong share");
            amountp1 += msg.value;
        } else if (msg.sender == payee2) {
            require(msg.value == share2, "wrong share");
            amountp2 += msg.value;
        } else {
            revert("not a payee");
        }
    }

    // Returns how much msg.sender can still withdraw
    function releasable(address account) public view returns (uint256) {
	require(msg.sender == account);
	require(account == payee0 || account == payee1 || account == payee2);
        require(totalShares > 0, "not initialized");
	require(amountp0 >= released0 && amountp1 >= released1 && amountp2 >= released2);

	uint256 sumReleased;
        uint256 yours;
        

        assembly {
            // i := 0..2
            for { let i := 0 } lt(i, 3) { i := add(i, 1) } {
                // load the i-th payee
                let payee := sload(add(0, i))
                // load amountp[i]
                let amount := sload(add(6, i))
                // load released[i]
                let released := sload(add(9, i))
                // pending = amount still withdrawable
                let pending := sub(amount, released)

		sumReleased := add(sumReleased, released)		

                // if it's the caller, save their pending amount
                if eq(payee, account) {
                    yours := pending
                }
            }
        }
        // check: 
        assert(sumReleased == totalReleased);

        return yours;
    }

    // Withdraws the available funds for msg.sender
    function release(uint256 payment) external {
	require(msg.sender == payee0 || msg.sender == payee1 || msg.sender == payee2);
	require(address(this).balance >= payment, "insufficient balance");
    	require(payment > 0, "no payment");
	require(payment <= releasable(msg.sender));

    	if (msg.sender == payee0) {
	    released0 += payment;
    	} else if (msg.sender == payee1) {
	    released1 += payment;
    	} else {
	    released2 += payment;
    	} 

    	totalReleased += payment;

    	(bool ok, ) = msg.sender.call{value: payment}("");
    	require(ok, "transfer failed");
}
}
