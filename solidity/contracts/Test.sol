pragma solidity ^0.4.23;

contract Test {
    uint v;

    function add(uint a, uint b) pure public returns (uint) {
        return a + b;
    }

    function setval(uint _v) public {
        v = _v + 1;
    }

    function getval() view public returns (uint) {
        return v;
    }
}