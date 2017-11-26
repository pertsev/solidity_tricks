pragma solidity 0.4.18;

contract Array {
    uint[] public array;
    address public owner;

    function Array() {
        owner = msg.sender;
        array.push(0xaa);
        array.push(0xbb);
    }

    function underflow() {
        array.length--;
    }

    function modify(uint index, uint value) {
        array[index] = value;
    }
}