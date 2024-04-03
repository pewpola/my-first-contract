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

    function update(string memory newResult) private {
        result = newResult;
        player1 = address(0);
        choice1 = Options.NONE;
    }

    function play(Options newChoice) public {
        require(newChoice != Options.NONE, "Invalid choice");
        require(player1 != msg.sender, "Wait the another player.");

        if (choice1 == Options.NONE) {
            player1 = msg.sender;
            choice1 = newChoice;
            result = "Player 1 choose his/her option. Waiting player 2.";
        } else if (choice1 == Options.ROCK && newChoice == Options.SCISSORS) {
            result = "Rock breaks scissors. Player 1 won.";
            player1 = address(0);
            choice1 = Options.NONE;
        } else if (choice1 == Options.PAPER && newChoice == Options.ROCK) {
            result = "Paper wraps rock. Player 1 won.";
            player1 = address(0);
            choice1 = Options.NONE;
        } else if (choice1 == Options.SCISSORS && newChoice == Options.PAPER) {
            result = "Scissores cuts paper. Player 1 won.";
            player1 = address(0);
            choice1 = Options.NONE;
        } else if (choice1 == Options.SCISSORS && newChoice == Options.ROCK) {
            result = "Rock breaks scissors. Player 2 won.";
            player1 = address(0);
            choice1 = Options.NONE;
        } else if (choice1 == Options.ROCK && newChoice == Options.PAPER) {
            result = "Paper wraps rock. Player 2 won.";
            player1 = address(0);
            choice1 = Options.NONE;
        } else if (choice1 == Options.PAPER && newChoice == Options.SCISSORS) {
            result = "Scissores cuts paper. Player 2 won.";
            player1 = address(0);
            choice1 = Options.NONE;
        } else {
            result = "Draw game.";
            player1 = address(0);
            choice1 = Options.NONE;
        }
    }
}
