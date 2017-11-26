# Type Confusion. 

## Description:
EVM doesn't check any types at runtime, it just call bytecode of func by signature. So, if the signature not found - fallback func will be called.

### To reproduce:

1. Copy-paste `neo.sol` and `smith.sol` to separate tabs at Remix (or use `Connect to localhost` feature)
2. Deploy `Neo` and `Smith` contracts. 
3. Call `Smith.doDamage` function with an address of `Neo`.

Check `health` of `Neo` (it should be 100) and `Smith` - 0.

_P.S._ Similar effect can be reached if someone use ABI that not match with actual ABI of smart contract. 