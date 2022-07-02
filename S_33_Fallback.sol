// SPDX-License-Identifier: GPL-3.0
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

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
 }