// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;


contract Crowdfund {
    uint  end_donate;    	// last block in which users can donate
    uint  goal;          	// amount of ETH that must be donated for the crowdfunding to be succesful
    address  owner;      	// receiver of the donated funds
    uint256 public totalHeld; 		// ghost
    address  donor;

    constructor (address payable owner_, uint end_donate_, uint256 goal_, address _donor) {
        owner = owner_;
        end_donate = end_donate_;
	goal = goal_;
	donor = _donor;	
    }
    
    function donate() public payable {
        require (block.number <= end_donate);
	
	totalHeld += msg.value;
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
        require (totalHeld > 0);

        uint256 amount = totalHeld;
	totalHeld = 0;

        (bool succ,) = donor.call{value: amount}("");
        require(succ);
    }


    function _check_invariants() public payable {
        require(block.number > end_donate);
	
	uint256 oldb = totalHeld;
	//donate();
        (bool success, ) = address(this).call{value: msg.value}(abi.encodeWithSelector(this.donate.selector));
	
	assert(totalHeld == oldb);
    }
}
