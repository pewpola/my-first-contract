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

}
