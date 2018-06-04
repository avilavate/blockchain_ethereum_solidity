pragma solidity^0.4.18;

import "./BidChain.sol";

contract BidHelper is BidChain {
    
    modifier itemOwner(uint _itemId) {
        require(msg.sender == itemToOwnerMapping[_itemId]);
        _;
    }
    
    function flagUser(uint _itemId, address _flaggedUser) public itemOwner(_itemId){
        require(itemToBiddingMap[_itemId].initialized == true);
        itemToBiddingMap[_itemId].flaggedUsers[_flaggedUser] = true;
    }
    
    function getItemDetail(uint _itemId) view public returns (string, uint, ItemState) {
        uint counter = 0;
        for(counter = 0; counter< items.length; counter++){
            if(items[counter].itemId == _itemId){
                return(items[counter].itemName, items[counter].basePrice, items[counter].state);
            }
        }
        return("",0,ItemState.uninitialized);
    }
    
    function getItemByOwner() view external returns (uint[]) {
        uint[] memory itemIdArray = new uint[](ownerToItemCount[msg.sender]);
        
        uint counter = 0;
        for(uint i=0;i<items.length;i++){
            if(itemToOwnerMapping[items[i].itemId] == msg.sender){
                itemIdArray[counter] = items[i].itemId;
                counter++;
            }
        }
        
        return itemIdArray;
    }
}
