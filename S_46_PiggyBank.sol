// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * PiggyBank 小猪存钱罐
 * 其他人可以发送主币，拥有者可以取出主币同时毁掉合约
 */
contract PiggyBank {

    // 收款数量事件
    event Deposit(uint amount);
    // 取款数量事件
    event Withdraw(uint amount);
    address public owner = msg.sender;

    // 接收主币
    receive() external payable {
        emit Deposit(msg.value);
    }
    // 提取主币
    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        // 自毁将主币发送给拥有者
        selfdestruct(payable(msg.sender));
    }
}