// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7 <0.9.0;

/**
 * 只读函数
 */
contract VuewAndPureFunctions06 {
    uint public num;

    // view 函数可以读取链上的信息
    function ViewFunc() external view returns (uint) {
        return num;
    }

    // pure 不能读取链上信息
    function PureFunc() external pure returns (uint) {
        return 1;
    }

    function AddToNum(uint x) external view returns (uint) {
        return num + x;
    }

    function Add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}