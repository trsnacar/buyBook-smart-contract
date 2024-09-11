# buyBook Smart Contract

This is a Solidity smart contract for a simple book-selling mechanism on the Ethereum blockchain. The contract allows a buyer to purchase a digital book for 10 USD worth of Ether.

## Features
- Buyers can purchase a digital book by sending at least 10 USD worth of Ether.
- Any excess amount is refunded.
- Only one purchase per address is allowed.
- The writer (contract owner) receives the payment.
  
## Prerequisites
- Node.js
- Truffle
- Ganache (for local development)
- Solidity

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/your-username/buyBook-smart-contract.git
   cd buyBook-smart-contract
   ```

2. Install the dependencies:
   ```
   npm install
   ```

3. Compile the contracts:
   ```
   truffle compile
   ```

4. Migrate the contracts:
   ```
   truffle migrate
   ```

5. Run the tests:
   ```
   truffle test
   ```

## License
This project is licensed under the MIT License.
