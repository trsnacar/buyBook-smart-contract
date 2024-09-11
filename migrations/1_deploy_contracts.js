const buyBook = artifacts.require("buyBook");

module.exports = function(deployer) {
  deployer.deploy(buyBook);
};
