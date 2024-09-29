// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    address public owner;

    struct Item {
        uint256 id;
        string name;
        string lecturer;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
    }

    mapping(uint256 => Item) public items;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    //list products
    function list(
        uint256 _id,
        string memory _name,
        string memory _lecturer,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint _rating
    ) public onlyOwner {
        //create item
        Item memory item = Item(
            _id,
            _name,
            _lecturer,
            _category,
            _image,
            _cost,
            _rating
        );

        //save item to blockchain
        items[_id] = item;
    }

    //buy products

    //Withdraw products
}
