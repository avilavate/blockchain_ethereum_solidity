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
    
    //1. add itemOwner modifier
    function initiateBid(uint _itemId, uint _endTime) public itemOwner(_itemId) {
        //2. refactor
      
        itemToBiddingMap[_itemId] = biddingData(_endTime, 0, msg.sender, true);
    }
    
    //3. add itemOwner modifier
    function flagUser(uint _itemId, address _flaggedUser) public  itemOwner(_itemId) {
        //4. refactor
    
        require(itemToBiddingMap[_itemId].initialized == true);
        itemToBiddingMap[_itemId].flaggedUsers[_flaggedUser] = true;
    }
    
    function placeBid(uint _itemId) public payable {
        require(now < itemToBiddingMap[_itemId].endTime);
        require(msg.value > itemToBiddingMap[_itemId].highestBid);
        
        returnBidAmount(itemToBiddingMap[_itemId].bidder, itemToBiddingMap[_itemId].highestBid);
        
        itemToBiddingMap[_itemId].highestBid = msg.value;
        itemToBiddingMap[_itemId].bidder = msg.sender;
           
        emit newBidPlaced(_itemId, msg.value, msg.sender);
    }
    
    function returnBidAmount(address _sendee, uint _amount) internal {
        _sendee.transfer(_amount);
    }
    
    //5. add itemOwner modifier
    function transferItem(uint _itemId, address _newOwner) public itemOwner(_itemId) {
        //6. refactor
        
        require(now > itemToBiddingMap[_itemId].endTime);
        
        itemToOwnerMapping[_itemId] = _newOwner;
        ownerToItemCount[_newOwner]++;
        ownerToItemCount[msg.sender]--;
        
        msg.sender.transfer(itemToBiddingMap[_itemId].highestBid);
    }
    
    //We already moved this modifier here for you
    modifier itemOwner(uint _itemId) {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        _;
    }
}
