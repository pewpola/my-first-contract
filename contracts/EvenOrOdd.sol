// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/Strings.sol";

contract OddOrEven {
    string public choicePlayer1 = ""; //EVEN OR ODD
    address public player1;
    uint8 private numberPlayer1;
    string public status = "";

    function compare(string memory str1, string memory str2) private pure returns(bool) {
        bytes memory arrA = bytes(str1);
        bytes memory arrB = bytes(str2);
        return arrA.length == arrB.length && keccak256(arrA) == keccak256(arrB);           
    }

    function choose(string memory newChoice) public {
        require(compare(newChoice, "EVEN") || compare(newChoice, "ODD"), "Choose EVEN OR ODD");

        string memory message = string.concat("Player 1 already choose ", choicePlayer1);
        require(compare(choicePlayer1, ""));

        choicePlayer1 = newChoice;
        player1 = msg.sender;
        status = string.concat("Player 1 is ", player1, " and choose ", choicePlayer1);
    }

    /*
    function ramdom() private view returns(uint256) {
        return uint(keccak256(abi.encodePacked(block.timestamp, choice)));
    }
    */

    function play(uint8 number) public {
        require(!compare(choicePlayer1, ""), "Choose your option first. EVEN or ODD");

        if(msg.sender) {
            numberPlayer1 = number;
            status = "Player 1 already played. Waiting player 2.";
        } else {
            uint256 cpuNumber = ramdom();
            bool isEven = (number + cpuNumber) % 2 == 0;
            string memory message = string.concat("Player choose ", choice , 
            " and plays ", Strings.toString(number), 
            ". CPU plays ", Strings.toString(cpuNumber));

            if(isEven && compare(choicePlayer1, "EVEN")) {
                return string.concat(message, ". Player won.");
            } else if(!isEven && compare(choicePlayer1, "ODD")) {
                return string.concat(message, ". Player won.");
            } else {
                return string.concat(message, ". Player won.");
            }
        }
    }
}