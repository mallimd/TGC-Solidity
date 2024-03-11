// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Bird {
    event Log(string message);

    function chirp() public virtual {
        emit Log("Bird is chirpping");
    }
}

contract BigBird is Bird {
    function chirp() public virtual override {
        emit Log("Big Bird has no special chirp, so it goes back to its ancestor's chirp");

        // Put your code below here
    }
}