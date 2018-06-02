pragma solidity^0.4.18;

import "./contracts.sol";

contract BidChain is AuctionHouse {
    
    function transferItem(uint _itemId, address _newOwner) public {
        //require will return an error and exit if the condition is not met.
        //here we are making sure whoever executes this function is the owner of the item 
        //if he/she is not require will through error.
        require(msg.sender == itemToOwnerMapping[_itemId]);
        itemToOwnerMapping[_itemId] = _newOwner;
    }
}
