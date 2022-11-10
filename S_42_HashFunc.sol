// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
    哈希算法特性
    1.输入值相同，输出值一定相同
    2.不管输入值有多大，输出值是定长的，不可逆
    通常用在签名的运算或获取一个特定的ID

    abi.encode() 和 abi.encodePacked() 区别
    后者不同的输入值可能造成相同的输出值，如('AAAA','BBB')和('AAA','ABBB')输出值相同，
    因为后者在运算结果时，没有给字符间隔补0。

    解决办法是给中间添加数字
 */
contract HashFunc {
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encode(text, num, addr));
    }

    function encode(string memory text1, string memory text2) external pure returns (bytes memory) {
        return abi.encode(text1, text2);
    }
    function encodePacked(string memory text1, string memory text2) external pure returns (bytes memory) {
        return abi.encodePacked(text1, text2);
    }

    // 解决函数
    function collision(string memory text1, uint x, string memory text2) external pure returns (byte32) {
        return keccak256(abi.encodePacked(arg);)
    }
    
}