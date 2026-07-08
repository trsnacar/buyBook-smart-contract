# buyBook Smart Contract

A minimal Solidity smart contract that lets a single "writer" (the contract
deployer) sell a digital book to buyers on the Ethereum blockchain. Each
address may purchase the book once, for a fixed price, with any excess Ether
automatically refunded.

## Overview

The contract (`contracts/buyBook.sol`) implements a simple pay-to-unlock
pattern:

- The account that deploys the contract becomes the **writer** and is the
  sole recipient of payments.
- A buyer calls `buy()` and sends at least `bookPrice` (10 Ether, expressed
  in wei) to purchase the book.
- Payment is forwarded to the writer, the buyer's address is recorded as
  having purchased the book, and a `BookPurchased` event is emitted.
- Any Ether sent above `bookPrice` is refunded to the buyer in the same
  transaction.
- Each address can only purchase the book once.

## Key Features

- **Fixed-price purchase flow** — `buy()` is `payable` and requires
  `msg.value >= bookPrice`.
- **One purchase per address** — enforced via the `buyers` mapping.
- **Automatic refund** of any overpayment.
- **Checks-effects-interactions pattern** — buyer state is updated before
  any external calls, and external calls use `call` with explicit success
  checks to guard against reentrancy and failed transfers.
- **Immutable writer address and constant price** for gas efficiency and
  clarity that these values never change after deployment.
- **`BookPurchased` event** for off-chain tracking of purchases.

## Tech Stack

- [Solidity](https://soliditylang.org/) `^0.8.0`
- [Truffle](https://trufflesuite.com/) for compilation, migration, and testing
- [Web3.js](https://web3js.readthedocs.io/) as the Ethereum client library
- [Mocha](https://mochajs.org/) / [Chai](https://www.chaijs.com/) for test
  assertions
- [Ganache](https://trufflesuite.com/ganache/) recommended for local
  development

## Prerequisites

- [Node.js](https://nodejs.org/) (npm)
- Truffle (`npm install -g truffle`, or use the local dependency via `npx`)
- A local Ethereum development chain such as Ganache, running on
  `127.0.0.1:7545` (see `truffle-config.js`)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/trsnacar/buyBook-smart-contract.git
   cd buyBook-smart-contract
   ```

2. Install the dependencies:
   ```bash
   npm install
   ```

3. Start a local blockchain (e.g. Ganache) listening on port `7545`, matching
   the `development` network defined in `truffle-config.js`.

## Compiling

```bash
npx truffle compile
```

## Deploying / Migrating

```bash
npx truffle migrate
```

This runs `migrations/1_deploy_contracts.js`, which deploys the `buyBook`
contract to the configured network. The deploying account becomes the
`writer` and receives all payments.

## Testing

```bash
npx truffle test
```

Tests are located in `test/buyBookTest.js` and cover:

- Successful purchase when sufficient Ether is sent.
- Rejection of purchases with insufficient Ether.

## Project Structure

```
contracts/               Solidity source (buyBook.sol)
migrations/               Truffle deployment scripts
test/                      Truffle/Mocha test suite
truffle-config.js          Network and compiler configuration
package.json                Project dependencies and scripts
```

## Deployed Addresses

No contract addresses are currently published for this project. Deploy
locally using the steps above, or update this section once the contract is
deployed to a public network.

## License

This project is licensed under the MIT License.
