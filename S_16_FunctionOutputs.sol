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
}
