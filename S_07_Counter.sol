// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Summary 小结；
// Counter 计数器合约，对状态变量进行增加、减少操作
contract Counter {
    uint public count;

    // 自增，external外部可视函数，在合约中的内部函数不能调用，只能通过外部读取
    function inc() external {
        count += 1;
    }
    // 自减
    function dec() external {
        count -= 1;
    }
}