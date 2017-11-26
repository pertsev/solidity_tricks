pragma solidity 0.4.18;

/* Abstract class of Neo contract */
contract Neo {
    function obtainDamage (uint256 value);
}

contract Smith {
    uint public health = 100;

    function doDamage (address who) {
        Neo(who).obtainDamage(100);
    }

    function obtainDamage (uint256 value) {
        health -= value;
    }
}