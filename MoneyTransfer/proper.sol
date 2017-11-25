pragma solidity 0.4.18;

contract Wallet {
    mapping (address => uint) public balances;

    function() payable public {
        balances[msg.sender] = msg.value;
    }

    /**
    Use withdraw function for transfer ether only! Any other logic should be avoid to prevent DOS.
    https://consensys.github.io/smart-contract-best-practices/known_attacks/#dos-with-unexpected-revert
    **/
    function withdraw() public {
        balances[msg.sender] = 0;
        msg.sender.transfer(balances[msg.sender]);
    }

    function getBalance() public view returns (uint) {
        return this.balance;
    }
}