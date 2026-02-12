//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract Bank {
    address immutable a;
    uint256 balance_a;

	constructor () {
	   a = msg.sender;
	}

    function deposit() public payable {
	require(msg.value > 0);
	        
	balance_a += msg.value;
	
	uint256 newb = address(this).balance;	
	
	//controllo che il saldo del contratto sia 
	//almeno pari ai fondi versati
	assert(newb >= balance_a);

    }

    function withdraw(uint amount) public {
	require(msg.sender == a);
        require(amount > 0);
        require(amount <= balance_a);

        balance_a -= amount;

        (bool success,) = a.call{value: amount}("");
        require(success);
    }

}
