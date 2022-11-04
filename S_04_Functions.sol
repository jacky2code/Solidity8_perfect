// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Functions
//  函数类型有两类：
//  函数类型默认是内部函数，因此不需要声明 internal 关键字
//      内部函数类型（internal）
//          内部函数只能在当前合约内被调用（在当前代码块内，包括内部库函数和继承的函数中），因为它们不能在当前合约上下文的外部被执行。
//      外部函数类型（external）
//          外部函数由一个地址和一个函数签名组成，可以通过外部函数调用传递或者返回。            
contract Functions {
    
    // external : 外部函数，只能在外部读取的函数
    // pure : 纯函数，不能够读写状态变量，只能拥有局部变量
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }

    function sub(uint256 x, uint256 y) external pure returns (uint256) {
        if(x<y)
        {
            return 0;
        }
        else
        {
            return x - y;
        }
    }
}