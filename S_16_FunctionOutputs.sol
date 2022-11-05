// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 函数返回值
 */
contract FunctionOutputs {

    // 普通返回值函数
    function returnManay() public pure returns (uint, bool) {
        return (1, true);
    }

    // 返回值命名
    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    // 隐式返回，直接通过参数名赋值
    function namedAssigned() public pure returns (uint x, bool b) {
        x = 1;
        b = false;
    }

    // 获取返回值
    function destructingAssigments() public pure {
        (uint x, bool b) = returnManay();
        // 只取一个返回值
        (, bool c) = returnManay();
    }
}