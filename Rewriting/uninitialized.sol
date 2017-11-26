pragma solidity 0.4.18;

contract Uninitialized {
    address public owner; // 0xaaaaa...
    uint public balance;  // 1337

    function rewrite(bytes s) {
        uint8[64] copy;
        for (uint8 i = 0; i < 64; i++)
        copy[i] = uint8(s[i]);
    }
}

/* Fixed version
contract Uninitialized {
    address public owner; // 0x0
    uint public balance;  // 0

    function rewrite(bytes s) pure {
        uint8[64] memory copy;
        for (uint8 i = 0; i < 64; i++)
        copy[i] = uint8(s[i]);
    }
}
*/