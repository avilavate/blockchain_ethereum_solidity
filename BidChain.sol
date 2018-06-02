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
    
    function flagUser(uint _itemId, address _flaggedUser) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        require(itemToBiddingMap[_itemId].initialized == true);
        itemToBiddingMap[_itemId].flaggedUsers[_flaggedUser] = true;
    }
    
    //1. create function placeBid
    
    function transferItem(uint _itemId, address _newOwner) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        itemToOwnerMapping[_itemId] = _newOwner;
    }
}
