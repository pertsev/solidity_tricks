# Non obvious inheritance. 

## Description:
Solidity use C3 linearization algorithm to make call graph.
So, multiple inheritance may be non obvious. 
Check code to clarification.

### To reproduce:

1. Copy-paste `inheritance.sol` to remix (or use `Connect to localhost` feature) and deploy Son contract. 
2. Then call `sonWannaHome` function.
