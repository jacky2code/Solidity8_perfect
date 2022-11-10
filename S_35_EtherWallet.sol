// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherWallet {
    // 管理员
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }
    // 只发送主币，不带任何参数，用receive
    receive() external payable {

    }

    // 提取主币
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);

        // 方法二
        (bool sent,) = msg.sender.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}