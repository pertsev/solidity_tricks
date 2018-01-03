
import "./MintableToken.sol";

contract Token is MintableToken {
    string public name = "Division";
    string public symbol = "DIV";
    uint256 public decimals = 18;

    function Token() {
        MAX_SUPPLY = 10000000000 * 1 ether;
    }
}