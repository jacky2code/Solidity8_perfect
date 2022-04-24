// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * Constructor 
 * - 构造函数：只在合约部署的时候调用一次，之后不再调用
 */
contract Constructor {
    address public owner;
    uint public x;

    constructor(uint _x) {
        // 让 owner 是合约的部署者
        owner = msg.sender;
        // 用户输入 x 值
        x = _x;
    }
}