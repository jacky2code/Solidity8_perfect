// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
Fallback executed when
 - function does't exist
 - directly send ETH

fallback() or receive()?

    eth is send to contract
            |
        is msg.data empty?
            /  \
          yes  no
          /      \
receive() exist?  fallback()
           / \
         yes  no
         /      \
     receive()   fallback() 
 */

 contract Fallback {

    event Log(string func, address sender, uint value, bytes data);

    // 调用不存在函数和直接发送以太币都可以用
    fallback() external payable {
        // 参数：调用的方法，调用地址，发送数量，调用数据
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    // 单独发送以太币使用
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
 }