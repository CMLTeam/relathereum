pragma solidity ^0.4.23;

contract Test {
    uint v;
    uint money;

    function add(uint a, uint b) pure public returns (uint) {
        return a + b;
    }

    function setval(uint _v) public {
        v = _v + 1;
    }

    function getval() view public returns (uint) {
        return v;
    }

    function getMoney() view public returns (uint) {
        return money;
    }

    function pay() public payable returns (uint) {
//        require(false);
        money = msg.value;
        return money;
    }
}