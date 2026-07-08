// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title buyBook - a simple digital book purchase contract
/// @notice Allows a buyer to purchase a single digital book copy for a fixed price in Ether.
/// @dev bookPrice is a fixed amount of Ether (not a live USD price feed).
contract buyBook {

    /// @notice Address of the writer (contract owner) who receives payments.
    address payable public immutable writer;

    /// @notice Fixed price of the book, in wei (equivalent to 10 Ether).
    uint public constant bookPrice = 10 * (10**18);

    /// @notice Tracks which addresses have already purchased the book.
    mapping(address => bool) public buyers;

    /// @notice Emitted when an address successfully purchases the book.
    event BookPurchased(address indexed buyer);

    /// @notice Sets the deployer as the writer who will receive payments.
    constructor() {
        writer = payable(msg.sender);
    }

    /// @notice Purchase the digital book by sending at least `bookPrice` in Ether.
    /// @dev Follows checks-effects-interactions to guard against reentrancy;
    ///      excess Ether sent above bookPrice is refunded to the caller.
    function buy() external payable {
        require(msg.value >= bookPrice, "Not enough Ether to buy the book.");
        require(!buyers[msg.sender], "You already own this book.");

        // Effects
        buyers[msg.sender] = true;
        uint refund = msg.value - bookPrice;

        // Interactions
        (bool paidWriter, ) = writer.call{value: bookPrice}("");
        require(paidWriter, "Payment to writer failed.");

        emit BookPurchased(msg.sender);
        _sendDigitalBook(msg.sender);

        if (refund > 0) {
            (bool refunded, ) = payable(msg.sender).call{value: refund}("");
            require(refunded, "Refund of excess Ether failed.");
        }
    }

    /// @dev Hook for delivering the digital book (e.g. via IPFS or a URI) to the buyer.
    function _sendDigitalBook(address buyer) internal {
        // Logic to send the digital book, e.g., via IPFS or a simple URI.
    }
}
