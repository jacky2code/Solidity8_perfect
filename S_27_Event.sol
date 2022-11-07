// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 事件：记录当前智能合约运行状态
 * 事件存储更节约gas
 */
contract Event {
    // 声明事件
    event Log(string message, uint val);
    // 带有索引的事件，最多不超过3个索引
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        // 触发事件
        emit Log("foo", 123);
        emit IndexedLog(msg.sender, 345);
    }

    event Message(address _from, address _to, string message);
    
    function sendMsg(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}