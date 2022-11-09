// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 3 ways to send ETH
// transfer - 2300 gas, reverts
// send - 2300 gas, returns bool
// call - all gas, returns bool and data
/**
    三种方法发送 ETH 主币
    1. transfer，消耗 2300 gas，如果失败 revert
    2. send，消耗 2300 gas，返回 boll 值表示是否成功
    3. call，消耗剩余所有gas，返回boll值和数据
 */
contract SendETH {
    // 接收主币方法1
    constructor() payable {}
    // 接收主币方法2
    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(9);
    }
    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(8);
        require(sent, "send failed");
    }
    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 7}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}