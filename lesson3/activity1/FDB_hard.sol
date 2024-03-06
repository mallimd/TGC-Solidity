// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Fixed Deposit Box
 * @dev Fixed Deposit Box
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract FixedDepositBox_Hard {
    uint256 constant SECONDS_IN_MINUTE = 60;
    uint256 public durationInMinutes;
    uint256 public amountInvested;
    uint8 public interestRate;

    // Array to keep track of user's addresses that
    address[] usersAddress;

    // Map to keep track of user's passwords
    mapping (address=>string) passwordMap;

    // Map to keep track of user's invested amount
    mapping (=>uint256) amountDepositedMap;

    // Map to keep track of when each user invested
    mapping (address=>) timeDepositedMap;

    constructor(uint256 initialAmount, uint256 durationInput, uint8 interestRateInput) {
        // Throw and error if the durationInput is not 5, 10 or 15
        require(
            durationInput == 5 || durationInput == 10 || durationInput == 15,
            "Duration should be 5, 10 or 15 minutes in seconds"
        );

        // Setting the state variables
        amountInvested =
        durationInMinutes =
        interestRate =
    }

    function userExist(address userAddress) public view returns (bool) {
        for (uint i = 0; i < usersAddress.length; i++) {
            if (usersAddress[i] == userAddress) {
                return true;
            }
        }

        return false;
    }

    // Receive function to handle the receiving of ether
    receive() external {
        address userAddress = msg.sender;

        uint256 amountReceived =

        // Add the amount received to teh amount state variable amountInvested
        amountInvested +=

        // Add User's amount deposited to amountDepositedMap
        amountDepositedMap[userAddress] =
    }


    function deposit(string calldata password) external payable {
        address userAddress = msg.sender;

        // Require the user not to have already deposited,
        require(, "You have already Despoited!");

        // Add User to usersAddress array
        usersAddress.push();

        // Add User's password to passwordMap
        passwordMap[userAddress] =

        // Add User's time deposited to timeDepositedMap
        timeDepositedMap[userAddress] = block.timestamp;
    }

    function widthdrawal(string memory passwordInput) public {
        address userAddress = msg.sender;

        // Require the user to have already deposited
        require(, "You have not already Despoited!");

        // Get the user's password to passwordMap
        string memory userPassword =

        // Require the passwordInput is equal to the userPassword from the passwordMap
        require(
            keccak256(abi.encodePacked(userPassword)) == keccak256(abi.encodePacked(passwordInput)),
            "The password inputed was not the same as the one we have"
        );

        // Get the user's amount deposited to amountDepositedMap
        uint256 userAmount =

        // Get the user's time deposited to timeDepositedMap
        uint256 userTimeDeposited =

        // Find out what is the time now
        uint256 timeNow =

        // Set the haveWeWaitedLongEnough variable to be true if the time now is passed the "unlock time"
        bool haveWeWaitedLongEnough =

        // Check if enough time has passed so that the user can withdraw
        if(haveWeWaitedLongEnough) {
            // Calculate the interest earned
            uint256 interestEarned =

            // Calculate the total amount to be returned to the user
            uint256 totalAmount =

            // Decrease the contract's amount by the total amount calculated above
            amountInvested -=

            // Pay the initial amount invested plus the interest earned to the user
            (bool success, ) = payable(userAddress).call{value: 0}("");
            require(success, "Withdrawal failed");
        }
    }
}