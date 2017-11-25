pragma solidity 0.4.18;

contract Lottery {

    struct Bet {
    uint value;
    uint24 betHash;
    uint blockNum;
    }

    mapping(address => Bet) public players;

    function Lottery() public payable {

    }

    function doBet(uint24 _hash, uint32 _blockNum) payable public {
        require(_blockNum > block.number && players[msg.sender].value == 0 && msg.value > 0);
        players[msg.sender].value = msg.value;
        players[msg.sender].betHash = _hash;
        players[msg.sender].blockNum = _blockNum;
    }

    function takePrize() {
        require(players[msg.sender].blockNum < block.number && players[msg.sender].value > 0);
        msg.sender.transfer(betPrize());
        delete players[msg.sender];
    }

    function betPrize() public view returns (uint) {
        Bet memory player = players[msg.sender];

        uint24 realHash = uint24(block.blockhash(player.blockNum));
        uint24 hit = player.betHash ^ realHash;

        uint matches =
        ((hit & 0xF) == 0 ? 1 : 0 ) +
        ((hit & 0xF0) == 0 ? 1 : 0 ) +
        ((hit & 0xF00) == 0 ? 1 : 0 ) +
        ((hit & 0xF000) == 0 ? 1 : 0 ) +
        ((hit & 0xF0000) == 0 ? 1 : 0 ) +
        ((hit & 0xF00000) == 0 ? 1 : 0 );

        if(matches == 6){
            return(uint(player.value) * 6);
        }
        if(matches == 5){
            return(uint(player.value) * 5);
        }
        if(matches == 3){
            return(uint(player.value) * 3);
        }
        if(matches == 2){
            return(uint(player.value) * 2);
        }
        return(0);
    }
}