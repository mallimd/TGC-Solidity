// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Math
 * @dev Does Math for you
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract FixedDepositBox_Easy {
    bool hasBeenWithdrawn = false;
    uint256 constant SECONDS_IN_MINUTE = 60;
    uint256 durationInMinutes;
    uint256 amountInvested;
    uint256 investedTime;
    uint8 interestRate;

    constructor(uint256 amountInput, uint256 durationInput, uint8 interestRateInput) {
        // Throw and error if the durationInput is not 5, 10 or 15
        require(

            "Duration should be 5, 10 or 15 minutes in seconds"
        );

        // Setting the state variables
        amountInvested =
        durationInMinutes =
        interestRate =

        // Setting the investedTime to the time when the smart contract is deployed
        investedTime =
    }

    function widthdrawal() public returns (uint256) {
        // Find out what is the time now
        uint256 timeNow =

        // Set the haveWeWaitedLongEnough variable to be true if the time now is passed the "unlock time"
        bool haveWeWaitedLongEnough =

        if(!hasBeenWithdrawn && haveWeWaitedLongEnough) {

            // Calculate the interest earned
            uint256 interestEarned =

            // Setting the flag variable hasBeenWithdrawn to be true so that function widthdrawal
            // will not return a positive number after the Fixed Deposit Box has been withdrawn
            hasBeenWithdrawn =

            // Return the initial amount invested plus the interest earned
            return interestEarned + amountInvested;
        }
        return 0;
    }
}