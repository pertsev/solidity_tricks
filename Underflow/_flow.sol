pragma solidity 0.4.18;

contract _flow {
    uint public umax = 2**256 - 1;
    uint public umin = 0;
    int public max = int(~((uint(1) << 255)));
    int public min = int((uint(1) << 255));

    function overflow() {
        umax++;
        max++;

        //  += 1;
        //  *= 2;
    }

    function underflow() {
        umin--;
        min--;

        // -= 1;
    }
}