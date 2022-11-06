// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 *  Mapping 映射
 *  How to declare mapping (simple and nested)/如果声明映射简单和嵌套
 *  set:设置数据
 *  get:获取数据
 *  delete:删除数据
 */
contract Mapping {
    // 地址-余额 映射
    mapping(address => uint) public balances;
    // 多重映射
    mapping(address => mapping(address => bool)) public isFirend;

    function examples() external {
        
        balances[msg.sender] = 1234;    // 赋值
        uint bal = balances[msg.sender];    // 获取值
        uint bal2 = balances[address(1)];   // 不存在映射值，默认返回 uint 默认值0
        balances[msg.sender] += 456;    // 123 + 456
        delete balances[msg.sender];    // 删除后，变成默认值 0，并返回
        isFirend[msg.sender][address(this)] = true;
    }
}