// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/Strings.sol";

contract OddOrEven {
    string public choicePlayer1 = ""; //EVEN OR ODD

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
    }

    function ramdom() private view returns(uint256) {
        return uint(keccak256(abi.encodePacked(block.timestamp, choice)));
    }

    function play(uint8 number) public view returns(string memory) {
        require(number >= 0 && number <= 2 , "Play, 0, 1 or 2");
        require(!compare(choice, ""), "Choose your option first. EVEN or ODD");

        uint256 cpuNumber = ramdom();
        bool isEven = (number + cpuNumber) % 2 == 0;
        string memory message = string.concat("Player choose ", choice , 
        " and plays ", Strings.toString(number), 
        ". CPU plays ", Strings.toString(cpuNumber));

        if(isEven && compare(choice, "EVEN")) {
            return string.concat(message, ". Player won.");
        } else if(!isEven && compare(choice, "ODD")) {
            return string.concat(message, ". Player won.");
        } else {
            return string.concat(message, ". Player won.");
        }
    }
}