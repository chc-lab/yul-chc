// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    uint public bid = 0;
    uint public cash = 0;
    address payable public winner;

    constructor() {
        winner = payable(address(0));
    }

    function offer() public payable {
        uint new_bid = msg.value - 1015 wei;
        require(new_bid > bid);

        if (winner != payable(address(0))) {
            assert(bid <= cash);
            winner.transfer(bid);
            cash -= bid;
        }

        bid = new_bid;
        cash += msg.value;
        winner = payable(msg.sender);
    }
}

