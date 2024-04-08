// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract BookDataBase {
    
    struct Book {
        string title;
        uint16 year;
    }

    uint32 private nextId = 0;
    mapping (uint32 => Book) public books;

    function addBook(Book memory newBook) public {
        nextId++;
        books[nextId] = newBook;
    } 
}