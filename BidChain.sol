pragma solidity^0.4.18;

import "./contracts.sol";

contract BidChain is AuctionHouse {
    
    struct biddingData {
        uint endTime;
        uint highestBid;
        address bidder;
        bool initialized;
        mapping (address => bool) flaggedUsers;
    }
    
    mapping (uint => biddingData) itemToBiddingMap;
    
    function initiateBid(uint _itemId, uint _endTime) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        itemToBiddingMap[_itemId] = biddingData(_endTime, 0, msg.sender, true);
    }
    
    function placeBid(uint _itemId, uint _bidAmount) public {
        require(now < itemToBiddingMap[_itemId].endTime);
        require(_bidAmount > itemToBiddingMap[_itemId].highestBid);
        itemToBiddingMap[_itemId].highestBid = _bidAmount;
        itemToBiddingMap[_itemId].bidder = msg.sender;
    }
    
    function transferItem(uint _itemId, address _newOwner) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        itemToOwnerMapping[_itemId] = _newOwner;
    }
}
