// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

abstract contract Vehicle {
    uint256 speed;

    constructor(uint256 _speed) {
        speed = _speed;
    }

    function distanceTravelled(uint256 timeTravelled) virtual public returns (uint256){}
}

contract Car is Vehicle {
    constructor(uint256 _speed) Vehicle(_speed){}

    function distanceTravelled(uint256 timeTravelled) override public view returns (uint256){
        return speed * timeTravelled;
    }
}