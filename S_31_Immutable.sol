// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 必须部署的时候赋值
contract Immutable {
    // 45718 gass
    // address public owner = msg.sender;

    // 43585 gas 使用 immutable 关键字更节省gas
    // address public immutable owner = msg.sender;

    address public immutable owner;

    // 构造函数赋值
    constructor() {
        owner = msg.sender;
    }

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}