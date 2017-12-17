# Dynamic Types Length Dependency. 

## Description:
The example concerns the length of ABI-encoded arrays, strings, bytes. The length is part of the ABI payload, and can be set by caller(!) to almost arbitrary values.
So EVM initialize type by length father then content.

### To reproduce:

0. Setup local Ethereum node (geth e.g.), initialize private blockchain and run node with rpc interface.
1. Copy-paste `dynamicTypes.sol` to remix (or use `Connect to localhost` feature) and deploy `DynamicTypes` contract to your blockchain . 
2. `npm install`
3. Grab contract address and change `contractAdd` in `exploit.js`.
4. `node exploit.js`.
5. See at `str`, `byts`, `array` variables.

*Inspired by [Roundtable](https://github.com/Arachnid/uscc/tree/master/submissions-2017/martinswende)