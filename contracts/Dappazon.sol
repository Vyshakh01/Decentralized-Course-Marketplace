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

    struct Order {
        uint256 time;
        Item item;
    }
    mapping(uint256 => Item) public items;
    mapping(address => uint256) public orderCount;
    mapping(address => mapping(uint256 => Order)) public orders;

    event Buy(address buyer, uint256 orderId, uint256 itemId);
    event List(string name, uint256 cost);

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

        //emit
        emit List(_name, _cost);
    }

    //buy products
    function buy(uint256 _id) public payable {
        //fetch item
        Item memory item = items[_id];
        //require enough item to buy item
        require(msg.value >= item.cost);

        //create order
        Order memory order = Order(block.timestamp, item);

        //save order to chain
        orderCount[msg.sender]++;
        orders[msg.sender][orderCount[msg.sender]] = order;

        //Emit event
        emit Buy(msg.sender, orderCount[msg.sender], item.id);
    }

    //Withdraw products

    function withdraw() public onlyOwner {
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success);
    }
}
