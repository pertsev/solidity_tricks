# Hoisting. 

## Description:
Solidity is considered to be a Javascript-like language. I'm disagree with that point but there is a crowd of frontend developers that wrote most of existing contracts.
So, if that is reason "Javascript-like" - that's ok -_- 

Anyway, Solidity as JS has _hoising_ mechanism. This means an object (variable, function, ...) can be declared after it has been used.
But thing is "Solidity only hoists declarations", not initializations! Strictly speaking, it works for both JS and Solidity. Read more
 about JS [here](https://www.w3schools.com/js/js_hoisting.asp). 

### To reproduce:

1. Copy-paste `hoisting.sol` to remix (or use `Connect to localhost` feature) and deploy Hoisting contract. 
2. Check `strg[0]`, `someNum` should be zero.
3. Call `main(0)`, then `one` should be 1.
4. Set `someNum` of `strg[0]` to 42 by calling `setter(0, 42)`.
5. Call `main(0)`, then `one` should be 2. But revert expected(42 > 10)!  Actually someNum == 0 in both cases. 

That's all :)