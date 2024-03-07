// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Fixed Deposit Box
 * @dev Fixed Deposit Box
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract FixedDepositBox_Medium {
    uint256 constant SECONDS_IN_MINUTE = 60;
    uint256 durationInMinutes;
    uint256 amountInvested;
    uint8 interestRate;

    // Array to keep track of user's addresses that
    address[] usersAddress;

    // Map to keep track of user's passwords
    mapping (address=>string) passwordMap;

    // Map to keep track of user's invested amount
    mapping (address=>uint256) amountDepositedMap;

    // Map to keep track of when each user invested
    mapping (address=>uint256) timeDepositedMap;

    constructor(uint256 initialAmount, uint256 durationInput, uint8 interestRateInput) {
        // Throw and error if the durationInput is not 5, 10 or 15
        require(
            durationInput == 5 || durationInput == 10 || durationInput == 15,
            "Duration should be 5, 10 or 15 minutes in seconds"
        );

        // Setting the state variables
        amountInvested = initialAmount;
        durationInMinutes = durationInput;
        interestRate = interestRateInput;
    }

    function userExist(address userAddress) public view returns (bool) {
        for (uint i = 0; i < usersAddress.length; i++) {
            if (usersAddress[i] == userAddress) {
                return true;
            }
        }

        return false;
    }

    function getUserAddressIndex(address user) public view returns (int256) {
        for (uint256 idx = 0; idx < usersAddress.length; idx++) {
            if (usersAddress[idx] == user) {
                return int(idx);
            }
        }
        return -1;
    }

    function removeAddress(int256 index) public {
        if (index == -1) {
            return;
        }

        // Move the last element into the place to delete
        usersAddress[uint(index)] = usersAddress[usersAddress.length - 1];
        // Remove the last element
        usersAddress.pop();
    }

    function deposit(uint256 amount, string calldata password) external {
        address userAddress = msg.sender;

        // Require the user not to have already deposited,
        require(!userExist(userAddress), "You have already deposited!");

        require(amount > 0, "Did not receive anything");

        uint256 amountReceived = amount;

        // Add User to usersAddress array
        usersAddress.push(userAddress);

        // Add User's password to passwordMap
        passwordMap[userAddress] = password;

        // Add User's time deposited to timeDepositedMap
        timeDepositedMap[userAddress] = block.timestamp;

        // Add User's amount deposited to amountDepositedMap
        amountDepositedMap[userAddress] = amountReceived;
    }

    function widthdrawal(string memory passwordInput) public returns (uint256) {
        address userAddress = msg.sender;

        // Require the user to have already deposited
        require(userExist(userAddress), "You have not already deposited!");

        // Get the user's password from the passwordMap
        string memory userPassword = passwordMap[userAddress];

        // Require the passwordInput is equal to the userPassword from the passwordMap
        require(
            keccak256(abi.encodePacked(userPassword)) == keccak256(abi.encodePacked(passwordInput)),
            "The password inputed was not the same as the one we have"
        );

        // Get the user's amount deposited from the amountDepositedMap
        uint256 userAmount = amountDepositedMap[userAddress];

        // Get the user's time deposited from the timeDepositedMap
        uint256 userTimeDeposited = timeDepositedMap[userAddress];

        // Find out what is the time now
        uint256 timeNow = block.timestamp;

        // Set the haveWeWaitedLongEnough variable to be true if the time now is passed the "unlock time"
        bool haveWeWaitedLongEnough = timeNow > userTimeDeposited + durationInMinutes;

        // Require that we have waited long enough
        require(haveWeWaitedLongEnough, "You have not waited long enough!");

        // Check if enough time has passed so that the user can withdraw
        if(haveWeWaitedLongEnough) {
            // Calculate the interest earned
            uint256 interestEarned = userAmount * interestRate / 100 * durationInMinutes / 60;

            // Calculate the total amount to be returned to the user
            uint256 totalAmount = interestEarned + userAmount;

            // Remove the user address from the user address array
            removeAddress(getUserAddressIndex(userAddress));

            // Return the initial amount invested plus the interest earned
            return totalAmount;
        }
        return 0;
    }
}