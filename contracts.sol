pragma solidity^0.4.18;
contract AuctionHouse {

    struct Item {
        string itemName;
        uint basePrice;
        uint itemId;
    }

    Item[] public items;

    function _generateItemId(string _str) private view returns (uint) {
        uint hashOfName = uint(keccak256(_str));
        return( hashOfName );
    }

    function _createItem(string _name, uint _price, uint _itemId) private {
        items.push(Item(_name, _price, _itemId));
    }
}