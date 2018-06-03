pragma solidity^0.4.18;

import "./BidChain.sol";

contract BidHelper is BidChain {
    
    function flagUser(uint _itemId, address _flaggedUser) public {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        require(itemToBiddingMap[_itemId].initialized == true);
        itemToBiddingMap[_itemId].flaggedUsers[_flaggedUser] = true;
    }
    
    //1. create a helper function, getItemDetail, which returns itemName, basePrice and state
    function getItemDetail(uint _itemId) view public returns(string, uint, ItemState) {
        uint counter = 0;
        for(counter = 0; counter < items.length; counter++){
            if(items[counter].itemId == _itemId){
                return (items[counter].itemName, items[counter].basePrice, items[counter].state);
            }
        }
        return ("",0,ItemState.uninitialized);
    }
}