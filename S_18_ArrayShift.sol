// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayShift {
    uint[] public arr;

    function example() public {
        arr = [1, 2, 3];
        delete arr[1];  // [1, 0, 3]
    }

    // 实现 remove 数组中的某个值。(数组的顺序不变，但是比较消耗gas)
    // 例如
    // [1, 2, 3] --> remove(1) --> [1, 3, 3] --> [1, 3]
    // 实现思路 先把 index 后的值前移 1 位，然后再 pop 最后一位
    function remove(uint _index) public {
        require(_index < arr.length, "index out of array range!");
        for (uint i = _index; i < arr.length; i++) {
            // 从需要替换的位置开始，后一个值赋值给前一个值
            arr[i] = arr[i + 1];
        }
        // 弹出最后一个值，实现数组顺序不变
        arr.pop();
    }

    // 实现方法二：比较少消耗gas，但是顺序打乱了
    // 实现思路：把要删除的数据用最后一个数据替换，最后再pop掉最后一个数据
    // [1, 2, 3, 4] --> removeNew(1) --> [1, 4, 3, 4] --> [1, 4, 3]
    function removeNew(uint _index) public {
        require(_index < arr.length, "index out of array range!");
        // 数组最后一个值，赋值给要删除的值
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    // 测试
    function testNew() external {
        arr = [1, 2, 3, 4];

        // remove(1);
        removeNew(1);

        assert(arr.length ==3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);
    }
}