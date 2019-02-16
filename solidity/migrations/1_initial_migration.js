var Migrations = artifacts.require("./Migrations.sol");
var CapsuleEscrow = artifacts.require("./CapsuleEscrow.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(CapsuleEscrow);
};
