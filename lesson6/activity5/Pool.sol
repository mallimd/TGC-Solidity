// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

struct PoolDimensions {
    uint256 length;
    uint256 width;
}

function getArea(uint256 x, uint256 y) pure returns (uint256) {
    return x * y;
}

contract Pool {
    PoolDimensions public dimensions;

    constructor() {
        dimensions.length = 10;
        dimensions.width = 10;
    }

    function getLength() public view returns (uint256) {
        return dimensions.length;
    }

    function getWidth() public view returns (uint256) {
        return dimensions.width;
    }
}
