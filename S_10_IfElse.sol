// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 结构控制
 */
contract IfElse {
    function example (uint x) external pure returns (uint) {
        if(x < 10) {
            return 1;
        } else if (x < 20) {
            return 2;
        } else {
            return 3;
        }
    }

    function ternary(uint x) external pure returns (uint) {
        // 三目运算
        return x < 10 ? 1 : 2;
    }
}