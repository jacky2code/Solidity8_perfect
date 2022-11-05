// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * Ownable 权限管理合约 
 * 重新设置合约拥有者
 * 只有合约拥有者能调用的函数
 * 其他人可以调用的函数
 */
contract Ownable {
    address public owner;

    // 构造函数
    constructor() {
        owner = msg.sender;
    }

    // 函数修改器
    modifier onlyOwner() {
        // 调用者必须是合约拥有者
        require(msg.sender == owner, "not owner");
        _;
    }

    // 设置新的所有者
    function setNewOwner(address _newOwner) external onlyOwner {
        // 不可以是 0 地址
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    // 只有管理员可以调用
    function onlyOwnerCanCallThisFunc() external onlyOwner {
        // more code
    }

    // 任何人可以调用
    function anyOneCanCallThisFunc() external {
        // more code
    }
}