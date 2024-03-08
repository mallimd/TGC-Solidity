// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// Activity for Events

contract Auction {
    event HighestBidderReceived(address bidder); // Event

    // Create a new event called HighestBidReceived

    uint256 highestBid;

    function bid() public payable {

        if(msg.value > highestBid) {
            emit HighestBidderReceived(msg.sender); // Triggering event

            // Emit the new HighestBidReceived event


            highestBid = msg.value;
        }
    }
}
