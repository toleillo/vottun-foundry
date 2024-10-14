// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../src/Bank.sol";

contract DeployBank is Script {
    function run() external {
        vm.startBroadcast();
        new Bank();
        vm.stopBroadcast();
    }
}
