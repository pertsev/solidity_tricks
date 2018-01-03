# Implicit Math. 

## Description:
Does the [SafeMath](https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/math/SafeMath.sol) really safe? 
Yes, more or less... there is one thing developer should remember - *SafeMath cares about [overflows](https://github.com/pertsev/solidity_tricks/tree/master/Underflow) only*. 
But for division of integers, some kind of [round-off error](https://en.wikipedia.org/wiki/Round-off_error) is also
 possible - usual behavior of EVM is just discard fraction part of quotient. So, if developer doesn't consider it, 
 he may(will) make a mistake like in this example.  

### To reproduce:
1. Copy-paste contracts to remix (or use `Connect to localhost` feature) and deploy `Crowdsale` contract. 
2. Call `purchase` with `0.444444444444444444` ether as value.
3. Check your balance. It is `88` instead of `88.8888888888888888`.

Notice, this bug is no easy to detect by testing even.
It's just because people seek to choose numbers for division to avoid fraction part at all (especially before a deadline).

**Fix**: swap `div` and `mul` at line 44. 

*the example inspired by actual practice of smart contract code audit.