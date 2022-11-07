// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 简单存储
contract SimpleStorage {
    string public text;

    // 存储字符串：aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    // 使用 calldata 花费 89626 gas
    // 使用 memory 花费 90114 gas
    function set(string calldata _text) external {
        text = _text;
    }
    // 智能合约将状态变量拷贝到内存中再返回
    function get() external view returns (string memory) {
        return text;
    }
}