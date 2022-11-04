// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Data types -- value and references
contract Types {
    // bool
    bool public b = true;

    // uint = uint256 范围 0 to 2**256 -1
    //        uint8   范围 0 to 2**8 - 1
    //        uint16  范围 0 to 2**16 - 1
    uint256 public u256 = 2 ** 256 - 1;
    uint8 public u8 = 2 ** 8 - 1;
    uint16 public u16 = 2 ** 16 -1;

    // int = int256 范围 -2**255 to 2**255 -1 
    int256 public i256 = -123;

    // int 最小值
    int public minInt = type(int).min;
    // int 最大值
    int public maxInt = type(int).max;

    // address 是一个16进制数字，通过私钥公钥计算出来
    address public addr = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
    bytes32 public b32 = 0x657468657265756d000000000000000000000000000000000000000000000000;
}