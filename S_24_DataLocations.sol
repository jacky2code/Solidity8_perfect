// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 数据存储位置
 * - storage, memory and calldata(只用于输入参数)
 */
contract DataLocations {
    struct MyStruct {
        uint256 foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint256[] calldata y)
        external
        returns (uint256[] memory)
    {
        myStructs[msg.sender] = MyStruct(123, "bar");

        MyStruct storage myStruct = myStructs[msg.sender];
        // 修改后，状态变量的值随之改变
        myStruct.text = "newBar";

        MyStruct memory myStructMem = myStructs[msg.sender];
        // 修改后，状态变量不改变，只不过是局部变量myStructMem改变，并随着函数执行完而从内存中消失
        myStructMem.foo = 235;

        _internal(y);

        uint256[] memory memArr = new uint256[](3);
        memArr[0] = 345;
        return memArr;
    }

    function _internal(uint256[] calldata y) private pure {
        uint256 x = y[0];
        x++;
    }
}
