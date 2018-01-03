pragma solidity 0.4.19;

import "./SafeMath.sol";
import "./Token.sol";
import "./Ownable.sol";

contract Crowdsale is Ownable {
    using SafeMath for uint;

    Token public token;
    address public beneficiary;

    uint public collectedWei;
    uint public tokensSold;

    uint public tokensForSale = 7000000000 * 1 ether;
    uint public priceTokenWei = 1 ether / 200;

    bool public crowdsaleFinished = false;

    event LogNewContribution(address indexed holder, uint256 tokenAmount, uint256 etherAmount);
    event LogCloseICO();

    function Crowdsale() {
        token = new Token();
        beneficiary = msg.sender;
    }

    function() payable {
        purchase();
    }

    function setTokenPrice(uint _value) onlyOwner {
        require(!crowdsaleFinished);
        priceTokenWei = 1 ether / _value;
    }

    function purchase() payable {
        require(!crowdsaleFinished);
        require(tokensSold < tokensForSale);
        require(msg.value >= 0.001 ether);

        uint sum = msg.value;
        uint amount = sum.div(priceTokenWei).mul(1 ether);  // hint
        uint retSum = 0;

        if(tokensSold.add(amount) > tokensForSale) {
            uint retAmount = tokensSold.add(amount).sub(tokensForSale);
            retSum = retAmount.mul(priceTokenWei).div(1 ether);

            amount = amount.sub(retAmount);
            sum = sum.sub(retSum);
        }

        tokensSold = tokensSold.add(amount);
        collectedWei = collectedWei.add(sum);

        beneficiary.transfer(sum);
        token.mint(msg.sender, amount);

        if(retSum > 0) {
            msg.sender.transfer(retSum);
        }

        LogNewContribution(msg.sender, amount, sum);
    }

    function closeCrowdsale() onlyOwner {
        require(!crowdsaleFinished);

        token.transferOwnership(beneficiary);
        token.finishMinting();
        crowdsaleFinished = true;
        LogCloseICO();
    }

    function balanceOf(address _owner) constant returns(uint256 balance) {
        return token.balanceOf(_owner);
    }
}