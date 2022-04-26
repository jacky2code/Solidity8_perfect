// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

// Mapping
// How to declare mapping (simple and nested)
// Set, get, delete
contract Mapping {
    // 地址，余额映射
    mapping(address => uint) public balances;
    // 多重映射
    mapping(address => mapping(address => bool)) public isFirend;

    function examples() external {
        // 赋值
        balances[msg.sender] = 1234;
        // 获取值
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)];   // 不存在应设置，默认返回 uint 默认值0
        balances[msg.sender] += 456;    // 123 + 456
        delete balances[msg.sender];    // 删除后，变成默认值 0
        isFirend[msg.sender][address(this)] = true;
    }
}