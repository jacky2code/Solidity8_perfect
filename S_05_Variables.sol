// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 变量
 */
contract Variables {
    // 3.1 状态变量 StateVariables ： 写入区块链的变量数据
    uint public myUint = 123;
    uint public i;
    bool public b;
    address public myAddress;

    // 3.2 局部变量
    function foo() external {
        
        uint x = 123;
        bool f = false;
        
        x += 456;
        f = true;

        // 修改状态变量的值
        i = 123;
        b = true;
        myAddress = address(1);
    }
    
    // 3.3 全局变量
    function globalVars() external view returns (address, uint, uint) {
        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint blockNum = block.number;

        return (sender, timestamp, blockNum);
    }
}