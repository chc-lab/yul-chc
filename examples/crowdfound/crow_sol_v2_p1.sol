// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;


contract Crowdfund {
    uint  end_donate;    	// last block in which users can donate
    uint  goal;          	// amount of ETH that must be donated for the crowdfunding to be succesful
    address  owner;      	// receiver of the donated funds
    uint256 public totalHeld; 		// ghost
    uint256 public totDonors;
    address[10] public donors;
    uint256[10] public donations;

    constructor (address payable owner_, uint end_donate_, uint256 goal_) {
        owner = owner_;
        end_donate = end_donate_;
	goal = goal_;	
    }
    
    function donate() public payable {
        require (block.number <= end_donate);
	require (totDonors < 10);
	
	//salvo la donazione e il donatore nella stessa posizione nei 2 array
        donations[totDonors] += msg.value;
	donors[totDonors] = msg.sender ;

	totalHeld += msg.value;
	totDonors += 1;

	assert(address(this).balance >= totalHeld);

    }

    function withdraw() public {
        require (block.number > end_donate);
        require (address(this).balance >= goal);

        totalHeld = 0;

	(bool succ,) = owner.call{value: address(this).balance}("");
        require(succ);
    }
    
    function reclaim() public { 
        require (block.number > end_donate);
        require (address(this).balance < goal);

	uint256 amount;
	uint256 i;

        for(i=0; i<totDonors; i++){
		if(donors[i] == msg.sender) {
			amount += donations[i];
			donations[i] = 0;
			donors[i] = address(0);
		}
	}
	
	require( amount > 0);
	totalHeld -= amount;
        (bool succ,) = msg.sender.call{value: amount}("");
        require(succ);
    }
}
