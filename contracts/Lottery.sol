pragma solidity >=0.4.22 <0.6.0;

contract Lottery {

    address public manager; //defines new variable
    address[] public players;


    constructor () public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);

        players.push(msg.sender);
    }


    function random() private view returns (uint) {
       return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }

    function pickWinner() public restricted {
        // index of a person who is going to win
        uint index = random() % players.length;
        address payable winner = address(uint160(players[index]));
        winner.transfer(address(this).balance);
        players = new address[](0);
    }

    //reset a contract to run the lottery again and again

    //function modifier - feature in solidity so that we do not repeat code
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

}
