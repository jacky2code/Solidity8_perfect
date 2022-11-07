// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 通过合约部署合约
contract TestContract1 {
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == _owner, "not owner");
        owner = _owner;
    }
}

contract TestContract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    event Deploy(address);

    function deploy(bytes memory _code) external payable returns (address addr) {
        // 内联汇编
        assembly {
            // create(v,p,n)
            // v = amount of ETH to send
            // p = pointer in memory to start of code
            // n = size of code
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        require(addr != address(0), "deploy failed!");
        // 向链外汇报部署合约的地址
        emit Deploy(addr);
    }
}
