// Capsule Escrow smart contract
const Capsule = artifacts.require("./CapsuleEscrow.sol");

contract('Capsule Escrow', (accounts) => {
	it("capsule flow", async() => {
		const capsule = await Capsule.new();

		// add some capsule – 1
		const fee       = 1000000000000000;
		const deposit   = 1000000000000000000;
		const szabo     = 1000000000000;
		await capsule.add(1, fee, deposit, {from: accounts[1]});

		// verify its state
		assert(await capsule.exists(1), "capsule doesn't exist");
		assert(await capsule.fresh(1), "capsule is not fresh");
		assert.equal(fee, (await capsule.capsules(1))[1], "wrong fee");
		assert.equal(deposit, (await capsule.capsules(1))[2], "wrong deposit");

		// check in and check out functions
		const checkIn = async(acc_id) => await capsule.checkIn(1, {from: accounts[acc_id], value: 2000000000000000000});
		const checkOut = async(acc_id) => await capsule.checkOut(1, {from: accounts[acc_id]});

		const checkIn2 = async() => await checkIn(2);
		const checkIn3 = async() => await checkIn(3);
		const checkOut2 = async() => await checkOut(2);
		const checkOut3 = async() => await checkOut(3);

		// check in and check out flows
		await checkIn2();
		await assertThrowsAsync(checkIn3);
		await assertThrowsAsync(checkOut3);
		await checkOut2();

		assert.equal(accounts[2], (await capsule.checkIns(1))[0], "wrong customer");
		assert.equal(fee + deposit, web3.eth.getBalance(capsule.address), "wrong escrow balance");

		await checkIn3();
		assert.equal(2 * fee + deposit, web3.eth.getBalance(capsule.address), "wrong escrow balance (2)");
		await assertThrowsAsync(checkIn2);
		await assertThrowsAsync(checkOut2);
		await checkOut3();

		// report an issue with the capsule
		await capsule.reportAnIssue(1, "very dirty!");

		await assertThrowsAsync(checkIn2);
		await assertThrowsAsync(checkIn3);
		await assertThrowsAsync(checkOut2);
		await assertThrowsAsync(checkOut3);

		assert(await capsule.bad(1), "capsule is not bad");
		assert(await capsule.reason(1), "no reason");

		// remove bad capsule
		await capsule.remove(1, {from: accounts[1]});

		// withdraw the funds
		await capsule.withdraw({from: accounts[1]});
		assert.equal(0, web3.eth.getBalance(capsule.address), "wrong escrow balance (3)");
	});
});

// auxiliary function to ensure function `fn` throws
async function assertThrowsAsync(fn, ...args) {
	let f = () => {};
	try {
		await fn(...args);
	}
	catch(e) {
		f = () => {
			throw e;
		};
	}
	finally {
		assert.throws(f);
	}
}
