var Migrations = artifacts.require("./Migrations.sol");
var CapsuleEscrow = artifacts.require("./CapsuleEscrow.sol");
var Test = artifacts.require("./Test.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(CapsuleEscrow);
  deployer.deploy(Test);
};
