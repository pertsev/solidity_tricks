pragma solidity 0.4.18;

/* Abstract class of Smith contract */
contract Smith {
    function obtainDamage (uint256 value);
}

contract Neo {
    uint8 public health = 100;

    function () {
        Smith(msg.sender).obtainDamage(100);
    }

    function obtainDamage (uint8 value) {
        health -= value;
    }
}