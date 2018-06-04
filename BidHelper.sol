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

    event newBidPlaced(uint itemId, uint bidAmount, address bidder);
    
    function initiateBid(uint _itemId, uint _endTime) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        itemToBiddingMap[_itemId] = biddingData(_endTime, 0, msg.sender, true);
    }
    
    function flagUser(uint _itemId, address _flaggedUser) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        require(itemToBiddingMap[_itemId].initialized == true);
        itemToBiddingMap[_itemId].flaggedUsers[_flaggedUser] = true;
    }
    
    //1. add payable modifier to this function
    //2. remove _bidAmount from parameter list
    function placeBid(uint _itemId, uint _bidAmount) public {
        require(now < itemToBiddingMap[_itemId].endTime);
        
        //3. change _bidAmount to msg.value 
        require(_bidAmount > itemToBiddingMap[_itemId].highestBid);
        itemToBiddingMap[_itemId].highestBid = _bidAmount;
        itemToBiddingMap[_itemId].bidder = msg.sender;
        
        //4. change _bidAmount to msg.value
        emit newBidPlaced(_itemId, _bidAmount, msg.sender);
    }
    
    function transferItem(uint _itemId, address _newOwner) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        itemToOwnerMapping[_itemId] = _newOwner;
    }
}
    