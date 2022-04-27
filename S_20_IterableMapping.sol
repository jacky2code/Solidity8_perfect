// SPDX-License-Identifier: GPL-2.0
pragma solidity >=0.8.7 <0.9.0;

/**
 *   IterableMapping
 */
contract IterableMapping {
    // 余额
    mapping(address => uint256) public balances;
    // 某地址是否存在映射中
    mapping(address => bool) public inserted;
    // 所有存在地址
    address[] public keys;

    /** 添加地址 */
    function set(address _key, uint256 _val) external {
        // 给地址赋值余额
        balances[_key] = _val;
        // 判断地址是否在映射中
        if (!inserted[_key]) {
            // 添加映射
            inserted[_key] = true;
            // 添加存在地址
            keys.push(_key);
        }
    }

    /** 获取地址数组长度 */
    function getSize() external view returns (uint256) {
        return keys.length;
    }

    /** 获取第一个地址余额 */
    function getFirstAddressBal() external view returns (uint256) {
        return balances[keys[0]];
    }

    /** 获取最后一个地址的余额 */
    function getLastAddressBal() external view returns (uint256) {
        return balances[keys[keys.length - 1]];
    }

    /** 获取任意位置地址的余额 */
    function getAddressBalAtIndex(uint256 _index)
        external
        view
        returns (uint256)
    {
        return balances[keys[_index]];
    }

    /** 遍历所有地址余额，getSize +  getAddressBalAtIndex 结合使用 */
}
