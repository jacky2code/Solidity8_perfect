// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Functions keywords view and pure
contract ViewAndPureFunctions{
    // 状态变量 num
    uint public num;

    // view 函数可以读取链上的信息（状态变量 num）
    function ViewFunc() external view returns (uint) {
        return num;
    }

    // pure 不能读取链上信息，只能声明局部变量
    function PureFunc() external pure returns (uint) {
        return 1;
    }

    function AddToNum(uint x) external view returns (uint) {
        return num + x;
    }

    // 使用pure关键字，只对参数做了计算没有引用状态变量或全局变量
    function Add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}