## Fuzz Testing Usefulness
Fuzz testing generates random inputs to rigorously test smart contract functions. It is especially useful for:

* Uncovering Edge Cases: Detects unexpected behaviors and vulnerabilities in extreme or uncommon scenarios.
* Improving Security: Identifies potential issues like overflows, underflows, or re-entrancy attacks that may not be caught with regular unit testing.
* Ensuring Robustness: Verifies the contract's resilience by testing it against a wide range of inputs.

### Deployment Scripts Setup:
The deployment script uses Foundry’s scripting feature to deploy smart contracts across different networks. With the NetworkManager contract, you can easily manage and switch between networks by fetching the appropriate RPC URL. The process involves:

Broadcasting transactions with vm.startBroadcast() to deploy the contract.
Flexibility in deploying on various networks using Foundry’s command-line tools.

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/DeployBank.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
