// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 *   IterableMapping 可迭代映射
 */
contract IterableMapping {
    // 地址/余额
    mapping(address => uint) public balances;
    // 地址/是否存在
    mapping(address => bool) public isInserted;
    // 所有存在地址
    address[] public keys;

    /** 添加地址 */
    function set(address _key, uint _val) external {
        // 给地址赋值余额
        balances[_key] = _val;
        // 判断地址是否在映射中
        if (!isInserted[_key]) {
            // 添加映射
            isInserted[_key] = true;
            // 添加存在地址
            keys.push(_key);
        }
    }

    /** 获取地址数组长度 */
    function getSize() external view returns (uint) {
        return keys.length;
    }

    /** 获取第一个地址余额 */
    function getFirstAddressBal() external view returns (uint) {
        return balances[keys[0]];
    }

    /** 获取最后一个地址的余额 */
    function getLastAddressBal() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    /** 获取任意位置地址的余额 */
    function getAddressBalAtIndex(uint _index) external view returns (uint)
    {
        return balances[keys[_index]];
    }

    /** 遍历所有地址余额，getSize +  getAddressBalAtIndex 结合使用 */
}
