// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}
// 在工厂合约内创建账户合约
contract AccountFactory {
    
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        // 创建账户合约并返回地址, value 传入主币
        Account account = new Account{value: 123}(_owner);
        accounts.push(account);
    }
}