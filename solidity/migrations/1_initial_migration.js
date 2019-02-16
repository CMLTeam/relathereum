const Migrations = artifacts.require("./Migrations.sol");
const Test = artifacts.require("./Test.sol");
const CapsuleEscrow = artifacts.require("./CapsuleEscrow");

module.exports = async function (deployer, network, accounts) {
    if (network === "test") {
        console.log("[deploy capsule] test network - skipping the migration script");
        return;
    }
    if (network === "coverage") {
        console.log("[deploy capsule] coverage network - skipping the migration script");
        return;
    }

    await deployer.deploy(CapsuleEscrow);
    await deployer.deploy(Test);

    // get deployed instance
    const capsule = await CapsuleEscrow.deployed();
    const test = await CapsuleEscrow.deployed();

    // deployment successful, print capsule address
    console.log("________________________________________________________________________");
    console.log("capsule_escrow_address " + capsule.address);
    console.log("test_address " + test.address);
};
