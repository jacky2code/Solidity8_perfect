// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 数据存储位置
 * - storage，用于状态变量
 * - memory，用于局部变量
 * - calldata，只用于输入参数,可以节约gas
 */
contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint[] memory y, string memory s) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct(123, "bar");

        MyStruct storage myStruct = myStructs[msg.sender];
        // 修改后，状态变量的值随之改变
        myStruct.text = "newBar";

        MyStruct memory myStructMem = myStructs[msg.sender];
        // 修改后，状态变量不改变，只不过是局部变量myStructMem改变，并随着函数执行完而从内存中消失
        myStructMem.foo = 235;

        uint[] memory memArr = new uint[](3);
        memArr[0] = 345;
        return memArr;
    }

    function examples2(uint[] calldata y, string calldata s) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct(123, "bar");

        MyStruct storage myStruct = myStructs[msg.sender];
        // 修改后，状态变量的值随之改变
        myStruct.text = "newBar";

        MyStruct memory myStructMem = myStructs[msg.sender];
        // 修改后，状态变量不改变，只不过是局部变量myStructMem改变，并随着函数执行完而从内存中消失
        myStructMem.foo = 235;

        _internal(y);

        uint[] memory memArr = new uint[](3);
        memArr[0] = 345;
        return memArr;
    }

    function _internal(uint[] calldata y) private pure {
        uint x = y[0];
        x++;
    }
}
