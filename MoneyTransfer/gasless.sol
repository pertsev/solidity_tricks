pragma solidity 0.4.18;

contract Wallet {
    mapping (address => uint) public balances;

    function() payable public {
        balances[msg.sender] = msg.value;
    }

    function withdraw() public {
        msg.sender.send(balances[msg.sender]);
        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint) {
        return this.balance;
    }
}

contract Attacker {
    Wallet public wallet;

    function Attacker(address _wallet) public {
        wallet = Wallet(_wallet);
    }

    function attack() payable public {
        wallet.call.value(msg.value)();
        wallet.withdraw();
    }

    function () payable public {
        revert();
    }

    function getBalance() public view returns (uint) {
        return this.balance;
    }
}