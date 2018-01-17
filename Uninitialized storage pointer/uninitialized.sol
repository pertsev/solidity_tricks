pragma solidity 0.4.18;

contract Uninitialized {
    address public owner;
    uint public balance;
    struct Billy {
    address where;
    }

    function rewriteOwner(address _where) public {
        Billy tmp;
        tmp.where = _where;
    }

    function rewriteBoth(bytes s) public {
        uint8[64] copy;
        for (uint8 i = 0; i < 64; i++)
        copy[i] = uint8(s[i]);
    }
}