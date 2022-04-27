/**
 * 通过合约部署合约
 */
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

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
    // function deploy(bytes memory _code) external payable {
    //     new TestContract1();
    // }
}
