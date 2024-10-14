// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/Bank.sol";

contract BankTest is Test {
    Bank bank;

    function setUp() public {
        bank = new Bank();
    }

    function testDeposit() public {
        uint256 depositAmount = 1 ether;
        bank.deposit{value: depositAmount}();
        assertEq(bank.getBalance(), depositAmount);
    }

    function testWithdraw() public {
        uint256 depositAmount = 2 ether;
        uint256 withdrawAmount = 1 ether;

        // Simulate a specific user (msg.sender)
        address user = address(0x123);
        vm.startPrank(user);

        vm.deal(user, depositAmount);

        bank.deposit{value: depositAmount}();

        uint256 userBalanceAfterDeposit = bank.getBalance();
        assertEq(userBalanceAfterDeposit, depositAmount, "User balance mismatch after deposit");

        bank.withdraw(withdrawAmount);

        uint256 contractBalanceAfterWithdraw = address(bank).balance;
        assertEq(contractBalanceAfterWithdraw, depositAmount - withdrawAmount, "Contract ether balance mismatch");

        uint256 userBalanceAfterWithdraw = bank.getBalance();
        assertEq(userBalanceAfterWithdraw, depositAmount - withdrawAmount, "User balance mismatch after withdrawal");

        vm.stopPrank();
    }

    function testFailWithdrawInsufficientFunds() public {
        uint256 depositAmount = 1 ether;
        uint256 withdrawAmount = 2 ether;

        bank.deposit{value: depositAmount}();
        bank.withdraw(withdrawAmount); // This should revert
    }

    function testFuzzDeposit(uint256 depositAmount) public {
        // Bound depositAmount between 1 wei and 1000 ether
        depositAmount = bound(depositAmount, 1, 10000 ether);

        // Assign ether to the sender to allow them to deposit
        vm.deal(msg.sender, depositAmount);

        // Perform the deposit
        bank.deposit{value: depositAmount}();
        assertEq(bank.getBalance(), depositAmount);
    }

    function testFuzzWithdraw(uint256 depositAmount, uint256 withdrawAmount) public {
        // Bound depositAmount between 1 wei and 1000 ether
        depositAmount = bound(depositAmount, 1, 10000 ether);

        // Ensure withdrawAmount is between 0 and depositAmount
        withdrawAmount = bound(withdrawAmount, 0, depositAmount);

        // Simulate a specific user (msg.sender)
        address user = address(0x123);
        vm.startPrank(user);

        vm.deal(user, depositAmount);

        bank.deposit{value: depositAmount}();

        uint256 userBalanceAfterDeposit = bank.getBalance();
        assertEq(userBalanceAfterDeposit, depositAmount, "User balance mismatch after deposit");

        bank.withdraw(withdrawAmount);

        uint256 contractBalanceAfterWithdraw = address(bank).balance;
        assertEq(contractBalanceAfterWithdraw, depositAmount - withdrawAmount, "Contract ether balance mismatch");

        uint256 userBalanceAfterWithdraw = bank.getBalance();
        assertEq(userBalanceAfterWithdraw, depositAmount - withdrawAmount, "User balance mismatch after withdrawal");

        vm.stopPrank();
    }

    function testWithWallet() public {
        Vm.Wallet memory wallet = vm.createWallet("test wallet");
        
        address walletAddress = wallet.addr;
        uint256 privateKey = wallet.privateKey;

        console.log("Wallet address:", walletAddress);
        console.logBytes32(bytes32(privateKey));
    }
}
