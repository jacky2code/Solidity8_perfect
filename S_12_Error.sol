// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * require, revert, assert
 * - gas refund, state updates are reverted
 * custom error
 * - save gas
 */
contract Error {
    function testErquire(uint i) public pure {
        // 需要 i <= 10 才能执行后面代码，否则报错 i > 10
        require(i <= 10, "i > 10");
        // code
    }

    function testRevert(uint i) public pure {
        if(i > 10) {
            // 直接抛出错误信息
            revert("i > 10");
        }
    }

    uint public num = 123;

    function testAssert() public view {
        // 断言，成功则执行后面代码，否则报错
        assert(num == 123);
    }


    error MyError(adress caller, uint i);
    function testCustomError(uint i) public view {
        if(i> 10)
        {
            revert MyError(msg.sender, i);
        }
    }
}