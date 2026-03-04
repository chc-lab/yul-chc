// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Operation {
    function positiveDifference(uint256 x, uint256 y) public pure returns (uint256) {
        require(x > 0 && y > 0 && x != y, "Inputs must be non-zero and different");

        uint256 diff;
        
        assembly {
            switch gt(x, y)
            case 0 {
                diff := sub(y, x)
            }
            default { //bug: sub(y, x) insted of sub(x, y)
                diff := sub(y, x)
            }
        }

        assert(diff > 0);

        return diff;
    }
}
