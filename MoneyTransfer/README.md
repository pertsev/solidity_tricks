# Reentrancy. 

## Description:
The most famous attack. There are two things to take in account - 
[fallback function](http://solidity.readthedocs.io/en/develop/contracts.html#fallback-function) and
[call](https://ethereum.stackexchange.com/questions/3667/difference-between-call-callcode-and-delegatecall).

### To reproduce:

1. Copy-paste `reentrancy.sol` to remix (or use `Connect to localhost` feature) and deploy `Wallet` contract.
2. Send to Wallet a little bit ether from other account (10 e.g.).
3. Grab Wallet address and use it for deploy Attacker smart contract.
4. Call `attack` function with 1 ether.
5. Call `kill` function and check balance (it should be 1 + 10)


# Gasless send. 

## Description:
Build-in `send` function is just wrapper on `call` with limited gas (2300). And as `call`, it returns `false` when something goes wrong. 
The "something" is:
1. `out-of-gas` exception
2. explicit `throw` (or `revert()`) 

This example illustrate Gasless send problem.

### To reproduce:

1. Copy-paste `gasless.sol` to remix (or use `Connect to localhost` feature) and deploy `Wallet` contract.
2. Grab Wallet address and use it for deploy Attacker smart contract.
3. Call `attack` function with 10 ether.
4. Check Wallet and Attacker balance. 

Attacker should have 0 via `Attacker.getBalance` func and `Wallet.balances` getter. But `Wallet.getBalance` returns 10 ether.
So, ethers of attacker are locked forever (for him).

# Proper way to send ether. 

## Description:
Example of `withdraw` function with some tip to avoid DOS.
