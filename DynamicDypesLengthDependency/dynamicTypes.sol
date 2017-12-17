pragma solidity 0.4.19;

contract DynamicTypes {
    uint public strLength;
    uint public bytsLength;
    uint public arrayLength;
    
    string public str;
    bytes public byts;
    address[] public array;
    
    function callme(string _str, bytes _byts, address[] _array) public {
        strLength = bytes(_str).length;
        str = _str;
        
        bytsLength = _byts.length;
        byts = _byts;
        
        arrayLength = _array.length;
        array = _array;
    }
}