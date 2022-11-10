// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 返回最大值
library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint _x, uint _y) external pure returns (uint) {
        return Math.max(_x, _y);
    }
}

// 查找对应索引
library ArrayLib {
    function findIndex(uint[] storage arr, uint x) internal view returns (uint) {
        for (uint i = 0; i< arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    // 应用库函数
    using ArrayLib for uint[];
    uint[] public arr = [3, 2, 1];
    // 查找数字在数组中的索引
    function testFind() external view returns (uint i) {
        // return ArrayLib.find(arr, 2);
        return arr.findIndex(2);
    }
}