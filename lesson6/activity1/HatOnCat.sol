// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Token {
    string public name = "ERC20";

    function getName() public view returns (string memory) {
        return name;
    }
}


contract HatOnCat is Token {
    // PUT YOuR CODE BELOW HERE

}
