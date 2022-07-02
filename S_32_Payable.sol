// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 向合约发送主币
contract Payable {
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