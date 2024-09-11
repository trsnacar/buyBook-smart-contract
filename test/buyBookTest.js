const buyBook = artifacts.require("buyBook");

contract('buyBook', (accounts) => {
  const writer = accounts[0];
  const buyer = accounts[1];
  const price = web3.utils.toWei('10', 'ether');

  it('should allow buying a book if enough Ether is sent', async () => {
    const instance = await buyBook.deployed();
    await instance.buy({ from: buyer, value: price });
    
    const buyerStatus = await instance.buyers(buyer);
    assert.equal(buyerStatus, true, "The buyer should have purchased the book");
  });

  it('should fail if not enough Ether is sent', async () => {
    const instance = await buyBook.deployed();
    try {
      await instance.buy({ from: buyer, value: web3.utils.toWei('5', 'ether') });
      assert.fail("Should have thrown an error");
    } catch (err) {
      assert.include(err.message, "Not enough Ether to buy the book", "Expected error message not received");
    }
  });
});
