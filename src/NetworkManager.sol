// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract NetworkManager {
    mapping(string => string) private networks;

    constructor() {
        networks["mainnet"] = "https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID";
        networks["goerli"] = "https://goerli.infura.io/v3/YOUR_INFURA_PROJECT_ID";
        networks["polygon"] = "https://polygon-rpc.com";
        networks["binance"] = "https://bsc-dataseed.binance.org/";
    }

    function getNetworkUrl(string memory network) public view returns (string memory) {
        return networks[network];
    }

    function setNetworkUrl(string memory network, string memory url) public {
        networks[network] = url;
    }
}
