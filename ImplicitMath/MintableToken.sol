import "./StandardToken.sol";
import "./Ownable.sol";

contract MintableToken is StandardToken, Ownable {
    event Mint(address indexed to, uint256 amount);
    event MintFinished();

    bool public mintingFinished = false;
    uint public MAX_SUPPLY;

    modifier canMint() { require(!mintingFinished); _; }

    function mint(address _to, uint256 _amount) onlyOwner canMint public returns(bool success) {
        require(totalSupply.add(_amount) <= MAX_SUPPLY);

        totalSupply = totalSupply.add(_amount);
        balances[_to] = balances[_to].add(_amount);

        Mint(_to, _amount);
        Transfer(address(0), _to, _amount);

        return true;
    }

    function finishMinting() onlyOwner public returns(bool success) {
        mintingFinished = true;

        MintFinished();

        return true;
    }
}