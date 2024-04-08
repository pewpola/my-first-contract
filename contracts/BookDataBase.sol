// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract BookDataBase {
    
    struct Book {
        string title;
        uint16 year;
    }

    mapping (uint32 => Book) public books;
}