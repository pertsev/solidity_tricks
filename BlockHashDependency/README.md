# BlockHash Dependency. 

## Description:
Accoding to a Solidity documentation:
`block.blockhash(uint blockNumber) returns (bytes32): hash of the given block` - 
**only works for 256 most recent blocks excluding current.** 

In other words, `block.blockhash(X) == 0` where `X ∈ [0,block.number - 256) ∪ [block.number, 2**256-1]`

### To reproduce:

1. Copy-paste `lottery.sol` to remix (or use `Connect to localhost` feature) and deploy `Lottery` contract with more than 6 ether. 
2. Call `doBet("0", "<block number at near future>")` with 1 ether as value.
3. Wait more than 256 blocks.
4. Call `takePrize`. 

Lottery smart contract should award you by value * 6 ether.

*Inspired by [SmartBillions lottery](https://etherscan.io/address/0x5ace17f87c7391e5792a7683069a8025b83bbd85#code)