// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Control Structures 结构控制
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

    // 三元运算
    function ternary(uint x) external pure returns (uint) {
        return x < 10 ? 1 : 2;
    }
}