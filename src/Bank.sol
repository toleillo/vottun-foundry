// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Bank {
    mapping(address => uint256) private balances;

    function deposit() public payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(address(this).balance >= amount, "Contract has insufficient ether");

        balances[msg.sender] -= amount;

        bool success = payable(msg.sender).send(amount);
        require(success, "Transfer failed");
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
