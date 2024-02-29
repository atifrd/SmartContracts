// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Wallet {
    address payable public owner; // The owner of the wallet
    mapping(address => uint256) balances;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    receive() external payable {}

    // Allow the owner to deposit funds into the wallet
    // function deposit() public payable onlyOwner {
    //     // No additional logic needed for deposits
    // }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    // Allow the owner to withdraw funds from the wallet
    function withdraw(uint256 amount) external onlyOwner {
        if (address(this).balance <= amount)
            revert InsufficientBalance({
                balance: address(this).balance,
                withdrawAmount: amount
            });

        payable(owner).transfer(amount);
    }

    function getWalletBalance() external view returns (uint256 balance) {
        return address(this).balance;
    }
}
