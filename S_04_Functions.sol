// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 函数
 */
contract Functions {
    // external : 外部函数
    // pure : 纯函数，不能够读写状态变量，只能拥有局部变量
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }
}