// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "./Pool.sol";

// import the necessary items from current directory
import {getArea, PoolDimensions} from "./Pool.sol";

contract House {
    // Initialize Pool.sol
    Pool public pool = new Pool();

    // Test Pool.sol by getting it's name.
    function getPoolArea() public view returns (uint256) {
        return getArea(pool.getLength(), pool.getWidth());
    }


}