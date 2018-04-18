pragma solidity ^0.4.21;

contract Hoisting {

    uint public one;

    struct Storage {
        uint someNum;
    }

    mapping (uint => Storage) public strg;

    function main(uint _id) public {
        require(c.someNum < 10);  // looks similar, yep? "All requires should be on top"

        Storage c = strg[_id]; // actually this line should be first
        one += 1;
    }

    function someNumSetter(uint id, uint _someNum) public {
        strg[id].someNum = _someNum;
    }
}