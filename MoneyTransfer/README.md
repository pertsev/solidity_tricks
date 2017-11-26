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

# Send ether via selfdestruct. 

## Description:
The another way to send ether to contract is `selfdestruct` func. There is no way for contract-recipient to avoid it!
Not by `throw` in fallback func or by destructing recipient-contract itself even. 

Notice, ether can be sent to non-existent contract also ([Address of future contract can be computed easily](https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed)) 

### To reproduce:

1. Copy-paste `selfdestruct.sol` to remix (or use `Connect to localhost` feature) and deploy all contracts 
(don't forget send a few ethers with `Sender` contract creation).
2. Call `Receiver.kill`.
3. Call `Sender.attack` with `Receiver` address.
4. Check `Sender` balance (should be above zero).

 