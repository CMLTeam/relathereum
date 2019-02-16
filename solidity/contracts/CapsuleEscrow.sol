pragma solidity ^0.4.23;

/**
 * Capsule states:
 * [0] doesn't exist: capsules[id].owner == 0
 *      !exists(id)
 * [1] exists but was never used: checkIns[id].customer == 0
 *      fresh(id)
 * [2] occupied: checkIns[id].checkIn != 0
 *      occupied(id)
 * [3] free (free for next check in): checkIns[id].checkedOut != 0
 *      free(id)
 * [4] reported as bad: checkIns[id].reported != 0
 *     bad(id)
 */

contract CapsuleEscrow {
    // TODO: pack capsule struct into 256 bits to occupy single storage slot
    struct Capsule {
        address owner;
        uint128 fee;
        uint128 deposit;
    }

    // check in structure fits into single storage slot
    struct CheckIn {
        address customer;
        uint32 checkedIn;
        uint32 checkedOut;
        uint32 reported;
        string reportReason;
    }

    // capsules are added and removed by their owners
    mapping(uint32 => Capsule) public capsules;

    // anyone can check in into free capsule
    mapping(uint32 => CheckIn) public checkIns;

    // owners get profit for their service
    mapping(address => uint256) public ownerBalances;

    // state [0]
    function exists(uint32 capsuleId) public constant returns(bool) {
        return capsules[capsuleId].owner != address(0);
    }

    // state [1]
    function fresh(uint32 capsuleId) public constant returns(bool) {
        return checkIns[capsuleId].customer == address(0);
    }

    // state [2]
    function occupied(uint32 capsuleId) public constant returns(bool) {
        return checkIns[capsuleId].checkedIn != 0;
    }

    // state [3]
    function free(uint32 capsuleId) public constant returns(bool) {
        return checkIns[capsuleId].checkedOut != 0;
    }

    // state [4]
    function bad(uint32 capsuleId) public constant returns(bool) {
        return checkIns[capsuleId].reported != 0;
    }

    // state [4] reason
    function reason(uint32 capsuleId) public constant returns(string) {
        return checkIns[capsuleId].reportReason;
    }

    function add(uint32 capsuleId, uint128 fee, uint128 deposit) public {
        // verify capsule doesn't exist or is modified by its owner,
        // in case of modification - verify capsule is not under check in
        require(
            !exists(capsuleId)
            || capsules[capsuleId].owner == msg.sender
            && (fresh(capsuleId) || free(capsuleId))
        );

        // send money back to previous customer
        if(free(capsuleId) && !bad(capsuleId)) {
            checkIns[capsuleId].customer.transfer(capsules[capsuleId].deposit);
        }

        // write capsule directly to the storage
        capsules[capsuleId] = Capsule({
            owner: msg.sender,
            fee: fee,
            deposit: deposit
        });
    }

    function remove(uint32 capsuleId) public {
        // ensure capsule is removed by its owner
        // and no one currently lives in that capsule
        require(capsules[capsuleId].owner == msg.sender && (fresh(capsuleId) || free(capsuleId)));

        // send money back to previous customer
        if(free(capsuleId) && !bad(capsuleId)) {
            checkIns[capsuleId].customer.transfer(capsules[capsuleId].deposit);
        }

        // delete capsule from the storage
        delete checkIns[capsuleId];
        delete capsules[capsuleId];
    }

    function checkIn(uint32 capsuleId) public payable {
        // verify capsule exists and is not occupied
        require(exists(capsuleId) && (fresh(capsuleId) || free(capsuleId) && !bad(capsuleId)));

        // how much ETH we need to lock
        uint256 price = capsules[capsuleId].fee + capsules[capsuleId].deposit;

        // verify enough ETH is sent
        require(price <= msg.value);

        // top up owner's balance
        ownerBalances[capsules[capsuleId].owner] += capsules[capsuleId].fee;

        // send the change back if needed
        if (msg.value > price) {
            msg.sender.transfer(msg.value - price);
        }

        if(!fresh(capsuleId)) {
            // return ETH to previously checked out customer
            checkIns[capsuleId].customer.transfer(capsules[capsuleId].deposit);
        }

        // perform the check in, write directly into storage
        checkIns[capsuleId] = CheckIn({
            customer : msg.sender,
            checkedIn : uint32(now),
            checkedOut : 0,
            reported: 0,
            reportReason: ""
        });

    }

    function checkOut(uint32 capsuleId) public {
        // verify sender is checked in
        require(checkIns[capsuleId].customer == msg.sender && !free(capsuleId) && !bad(capsuleId));

        // perform the checkout
        checkIns[capsuleId].checkedOut = uint32(now);
    }

    function reportAnIssue(uint32 capsuleId, string description) public {
        // verify capsule exists and is not occupied
        require(exists(capsuleId) && !fresh(capsuleId) && free(capsuleId) && !bad(capsuleId));

        // top up owner's balance
        ownerBalances[capsules[capsuleId].owner] += capsules[capsuleId].deposit;

        // empty the capsule
        checkIns[capsuleId].reported = uint32(now);
        checkIns[capsuleId].reportReason = description;
    }


    function withdraw() public {
        // withdraw to the owner
        msg.sender.transfer(ownerBalances[msg.sender]);
    }
}