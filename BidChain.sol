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
    
    function returnBidAmount(address _sendee, uint _amount) internal {
        _sendee.transfer(_amount);  
    }

    function placeBid(uint _itemId) public payable{
        require(now < itemToBiddingMap[_itemId].endTime);
        require(msg.value > itemToBiddingMap[_itemId].highestBid);

        returnBidAmount(itemToBiddingMap[_itemId].bidder, itemToBiddingMap[_itemId].highestBid);
        
        itemToBiddingMap[_itemId].highestBid = msg.value;
        itemToBiddingMap[_itemId].bidder = msg.sender;
    }
    
    function transferItem(uint _itemId, address _newOwner) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        itemToOwnerMapping[_itemId] = _newOwner;
    }
}
