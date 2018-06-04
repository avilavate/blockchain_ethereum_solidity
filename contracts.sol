pragma solidity^0.4.18;

contract AuctionHouse {

    enum ItemState {uninitialized, initialized, soldOut}

    struct Item {
        string itemName;
        uint basePrice;
        uint itemId;
        ItemState state;
    }

    Item[] public items;

    mapping (uint => address) itemToOwnerMapping;
    mapping (address => uint) ownerToItemCount;
    
    function _generateItemId(string _str) internal pure returns (uint) {
        uint hashOfName = uint(keccak256(_str));
        return hashOfName;
    }

    function _createItem(string _name, uint _price, uint _itemId) internal {
        items.push(Item(_name, _price, _itemId, ItemState.initialized));
        itemToOwnerMapping[_itemId] = msg.sender;
        ownerToItemCount[msg.sender]++;
    }

    function addItem(string _name, uint _price) public {
        uint itemId = _generateItemId(_name);
        _createItem(_name, _price, itemId);
    }
}
