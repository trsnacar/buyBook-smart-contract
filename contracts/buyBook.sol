// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract buyBook {
    
    address payable public writer;
    uint public bookPrice = 10 * (10**18); // 10 USD in Wei (Ether)
    mapping(address => bool) public buyers;
    
    event BookPurchased(address buyer);
    
    constructor() {
        writer = payable(msg.sender); // Contract creator is the writer
    }
    
    function buy() external payable {
        require(msg.value >= bookPrice, "Not enough Ether to buy the book.");
        require(!buyers[msg.sender], "You already own this book.");
        
        writer.transfer(bookPrice);
        buyers[msg.sender] = true;
        
        emit BookPurchased(msg.sender);
        _sendDigitalBook(msg.sender);
        
        if (msg.value > bookPrice) {
            payable(msg.sender).transfer(msg.value - bookPrice);
        }
    }
    
    function _sendDigitalBook(address buyer) internal {
        // Logic to send the digital book, e.g., via IPFS or a simple URI.
    }
}
