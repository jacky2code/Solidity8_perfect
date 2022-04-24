// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * Ownable 权限管理合约 
 * 重新设置合约拥有者
 * 只有合约拥有者能调用的函数
 * 其他人可以调用的函数
 */
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    // 设置新的所有者
    function setNewOwner(address _newOwner) external onlyOwner {
        // 不可以是 0 地址
        require(_newOwner != address(0), "address invalid");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() external onlyOwner {

    }

    function anyOneCanCallThisFunc() external {

    }
}