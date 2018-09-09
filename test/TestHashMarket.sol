pragma solidity ^0.4.20;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HashMarket.sol";


contract TestHashMarket {

    function testAddingNewProduct() public {
        // DeployedAddresses.HashMarket() handles contract address
        // management for us
        HashMarket market = HashMarket(DeployedAddresses.HashMarket());

        bytes32 expectedName = "T";
        uint expectedPrice = 1000;

        uint itemID = market.addNewItem(expectedName, expectedPrice);

        bytes32 name;
        uint price;
        address seller;
        uint status;

        (name, price, seller, status) = market.getItem(itemID);

        Assert.equal(name, expectedName, "Item name should match");
        Assert.equal(price, expectedPrice, "Item price should match");
        Assert.equal(status, uint(HashMarket.ItemStatus.active), "Item status at creation should be .active");
        Assert.equal(seller, this, "The function caller should be the seller");
    }

}
