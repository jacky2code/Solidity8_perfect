// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7 <0.9.0;

contract HelloWorld {
    string public myString = "hello world!";
    
    /** 1. 类型
    bool public b = true;

    // uint = uint256 0 to 2**256 -1
    //        uint8   0 to 2**8 - 1
    //        uint16  0 to 2**16 - 1
    uint public u = 123;

    // int = int256 -2**255 to 2**255 -1 
    int public i = -123;

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;

    bytes32 public b32 = 0x657468657265756d000000000000000000000000000000000000000000000000;
    */
    
    /** 2. 函数
    // external : 外部函数
    // pure : 纯函数，不能够读写状态变量，只能拥有局部变量
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }
    */

    /** 3. 变量 
    // 3.1 状态变量 StateVariables ： 写入区块链的变量数据
    uint public myUint = 123;
    uint public i;
    bool public b;
    address public myAddress;

    // 3.2 局部变量
    function foo() external {
        
        uint x = 123;
        bool f = false;
        
        x += 456;
        f = true;

        // 修改状态变量的值
        i = 123;
        b = true;
        myAddress = address(1);
    }
    
    // 3.3 全局变量
    function globalVars() external view returns (address, uint, uint) {
        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint blockNum = block.number;

        return (sender, timestamp, blockNum);
    }
    */


}
