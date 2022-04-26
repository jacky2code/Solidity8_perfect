// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 数组
 * - dynamic or fixed size 动态数组或者固定长度数组
 * Initialization
 * Insert(push), get, update, delete, pop, length
 * Creating array in memory
 * Returning array from function
 */
contract Array {
    uint[] public nums = [1, 2, 3];
    uint[5] public numsFixed = [4, 5, 6, 7, 8];

    function examples() external {
        // 向数组尾部推入数据
        nums.push(4);   // [1, 2, 3, 4]
        uint x = nums[0];   // x = 1
        nums[2] = 777;  // [1, 2, 777, 4]
        // 删除数组的值，但不会更改长度，赋 0
        delete nums[1]; // [1, 0, 777, 4]
        // 弹出数组最后一位数据
        nums.pop(); // [1, 2, 777]
        uint len = nums.length;

        // create array in memory
        uint[] memory a = new uint[](5);    
        // 内存中只能定义定长数组，根据索引赋值。
        a[1] = 123;
    }

    // 返回数组所有内容，内存类型
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}