// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * selfdestruct 自毁合约
 * - delete contract
 * - force send Ether to any address
 */
 contract Kill {

    constructor() payable{}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
 }

 contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    // 调用合约的自毁方法，将被调用合约的主币发送至此合约
    function kill(Kill _kill) external {
        _kill.kill();
    }
 }