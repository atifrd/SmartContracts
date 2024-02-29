// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.2 <0.9.0;

contract Vendingmachin {
    mapping(address => uint256) public donutBallances;
    address owner;

    constructor() {
        donutBallances[address(this)] = 100;
        owner = msg.sender;
    }

    function getVendingmachinBalance() public view returns (uint256, uint256) {
        return (donutBallances[address(this)], address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function restock(uint256 amount) public onlyOwner {
        donutBallances[address(this)] += amount;
    }

    function purchase(uint256 amount) public payable {
      ///  require(msg.sender.balance > amount * 2 ether, "");
        require(
            msg.value >= amount * 2 ether,
            "You must pay 2eth for each donut"
        );
        require(
            amount <= donutBallances[address(this)],
            "not enough donut in stock"
        );

        donutBallances[address(this)]-=amount;
        donutBallances[msg.sender]+=amount;
    }


   
}
