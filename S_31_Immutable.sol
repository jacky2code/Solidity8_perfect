// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 必须部署的时候赋值
contract Immutable {
    // 方法一，不适用immutable关键字 消耗 45718 gass
    // address public owner = msg.sender;

    // 方法二 使用 immutable 关键字消耗 43585 gas，更节省gas
    // address public immutable owner = msg.sender;

    address public immutable owner;

    // 方法二-2，也可以构造函数中赋值
    constructor() {
        owner = msg.sender;
    }

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}