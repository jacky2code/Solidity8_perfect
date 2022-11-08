// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 向合约发送主币
contract Payable {
    // 地址可以发送ETH主币，使用关键字
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 向合约发送主币
    function deposit() external payable {

    }
    // 当前合约余额
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}