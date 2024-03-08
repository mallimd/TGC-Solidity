// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// Activity for Events

contract Auction {
    event HighestBidderReceived(address bidder); // Event

    // Create a new event called HighestBidReceived

    uint256 highestBid;

    modifier notZeroPaid() {
        require(msg.value > 0, "You must bid an amount more than 0!");
        _;
    }

    modifier () {
        // Start of Code Block

        // End of Code Block
        _;
    }

    function bid() public payable notZeroPaid {

        if(msg.value > highestBid) {
            emit HighestBidderReceived(msg.sender); // Triggering event

            // Emit the new HighestBidReceived event


            highestBid = msg.value;
        }
    }
}
