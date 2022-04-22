// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 计数器合约
 * 对状态变量进行增加、减少操作
 */
contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }

}