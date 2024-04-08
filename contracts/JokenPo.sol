// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract JokenPo {
    
    enum Options {
        NONE,
        ROCK,
        PAPER,
        SCISSORS
    }

    Options private choice1 = Options.NONE;
    address private player1;
    string public result = "";

    address payable private immutable owner;

    struct Player {
        address wallet;
        uint32 wins;
    }

    Player[] public players;

    constructor() {
        owner = payable(msg.sender);
    }

    function contains(address winner) private view returns(bool){
        for (uint i = 0; i < players.length; i++) {
            if (players[i].wallet == winner) {
                return true;
            }
        }
        return false;
    }

    function finishGame(string memory newResult, address winner) private {
        address contractAddress = address(this);

        payable(winner).transfer((contractAddress.balance / 100) * 90);
        owner.transfer(contractAddress.balance);

        if (!contains(winner)) {
            players.push(Player(winner, 1));
        }

        result = newResult;
        player1 = address(0);
        choice1 = Options.NONE;
    }

    function getBalance() public view returns(uint) {
        require(owner == msg.sender, "You don't have this permission");
        return address(this).balance;
    }

    function secretFunction() public view returns(string memory) {
        require(owner == msg.sender, "You don't have permissions to do this.");
        return "passing";
    }

    function play(Options newChoice) public payable {
        require(newChoice != Options.NONE, "Invalid choice");
        require(player1 != msg.sender, "Wait the another player.");
        require(msg.value >= 0.01 gwei, "Invalid bid.");

        if (choice1 == Options.NONE) {
            player1 = msg.sender;
            choice1 = newChoice;
            result = "Player 1 choose his/her option. Waiting player 2.";
        } else if (choice1 == Options.ROCK && newChoice == Options.SCISSORS) {
            finishGame("Rock breaks scissors. Player 1 won.", player1);
        } else if (choice1 == Options.PAPER && newChoice == Options.ROCK) {
            finishGame("Paper wraps rock. Player 1 won.", player1);
        } else if (choice1 == Options.SCISSORS && newChoice == Options.PAPER) {
            finishGame("Scissores cuts paper. Player 1 won.", player1);
        } else if (choice1 == Options.SCISSORS && newChoice == Options.ROCK) {
            finishGame("Rock breaks scissors. Player 2 won.", msg.sender);
        } else if (choice1 == Options.ROCK && newChoice == Options.PAPER) {
            finishGame("Paper wraps rock. Player 2 won.", msg.sender);
       } else if (choice1 == Options.PAPER && newChoice == Options.SCISSORS) {
            finishGame("Scissores cuts paper. Player 2 won.", msg.sender);
        } else {
            result = "Draw game. The prize was doubled";
            player1 = address(0);
            choice1 = Options.NONE;
        }
    }
}
