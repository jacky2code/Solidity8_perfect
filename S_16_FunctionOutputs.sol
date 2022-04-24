// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 函数返回值
 */
contract FunctionOutputs {
    function returnManay() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    // 隐式返回
    function namedAssigned() public pure returns (uint x, bool b) {
        x = 1;
        b = false;
    }

    // 获取返回值
    function destructingAssigments() public pure {
        (uint x, bool b) = returnManay();
        // 只取一个返回值
        (, bool c) = returnManay();

        x = x + 1;
        if(b)
        {
            x = x * 1;
        }
        if(c)
        {
            x = x * 2;
        }
    }
}
