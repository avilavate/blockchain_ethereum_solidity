pragma solidity^0.4.18;
contract AuctionHouse {
    struct Item {
        string itemName;
        uint basePrice;
        uint itemId;
    }

    Item[] public items;

    function createItem (string _name, uint _price, uint _itemId) public {
        items.push(Item(_name,_price,_itemId));
    }
}