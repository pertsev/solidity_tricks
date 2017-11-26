pragma solidity 0.4.18;

contract Receiver {

    function Receiver() payable {

    }

    function kill() {
        selfdestruct(msg.sender);
    }

    function () {
        revert();
    }
}

contract Sender {

    function Sender() payable {

    }

    function kill(address who) {
        selfdestruct(who);
    }
}

contract BalanceChecker {

    function getBalance(address who) view returns(uint256) {
        return who.balance;
    }
}