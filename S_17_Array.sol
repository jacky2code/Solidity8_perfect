// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 数组
 * 数组分类
 * - Dynamic Array 动态数组
 * - Fixed size Array 定长数组
 * 数组操作
 * Initialization 初始化
 * push 插入
 * get 获取
 * update 更新
 * delete 删除
 * pop 弹出
 * length 长度
 * Creating array in memory 内存中创建数组
 * Returning array from function 函数返回数组
 */
contract Array {
    // 动态数组
    uint[] public nums = [1, 2, 3];
    // 定长数组
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

        // 内存中创建数组
        uint[] memory a = new uint[](5);    
        // 内存中只能定义定长数组，根据索引赋值，不能pop或push
        a[1] = 123;
    }

    // 返回数组所有内容，内存类型
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}