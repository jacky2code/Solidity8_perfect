// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Data types -- value and references
contract Types {
    bool public b = true;

    // uint = uint256 范围 0 to 2**256 -1
    //        uint8   范围 0 to 2**8 - 1
    //        uint16  范围 0 to 2**16 - 1
    uint public u = 123;

    // int = int256 -2**255 to 2**255 -1 
    int public i = -123;

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
    bytes32 public b32 = 0x657468657265756d000000000000000000000000000000000000000000000000;
}