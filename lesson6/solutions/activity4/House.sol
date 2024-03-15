// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract House {
    event Log(string message);

    function call(string memory number) public {
        string memory output = string.concat("Someone from phone number ", number, " is calling me");
        emit Log(output);
    }

}

contract Phone {
    function callFromHouse(House _house, string memory number) public {
        // Call the house
        _house.call(number);
    }

    function callFromHouseAddress(address _addr, string memory number) public {
        // Change th address of a house into a house type
        House abcHouse = House(_addr)
        // Call the house
        abcHouse.call(number);
    }
}
