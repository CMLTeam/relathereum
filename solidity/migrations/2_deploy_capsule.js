// Dutch Auction Helper
const Capsule = artifacts.require("./CapsuleEscrow");

module.exports = async function(deployer, network, accounts) {
	if(network === "test") {
		console.log("[deploy capsule] test network - skipping the migration script");
		return;
	}
	if(network === "coverage") {
		console.log("[deploy capsule] coverage network - skipping the migration script");
		return;
	}


	// deploy auction capsule sale
	await deployer.deploy(Capsule);

	// get deployed instance
	const capsule = await Capsule.deployed();

	// deployment successful, print capsule address
	console.log("________________________________________________________________________");
	console.log("capsule: " + capsule.address);
};
