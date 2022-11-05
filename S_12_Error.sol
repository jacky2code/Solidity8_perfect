// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * Error handling 报错处理
 * Solidity 使用状态恢复异常来处理错误。
 * 这种异常将撤消对当前调用（及其所有子调用）中的状态所做的所有更改，并且还向调用者标记错误。
 *
 * require 检查错误(Error)，需要满足某种条件后才能执行后面代码，否则抛出引号内报错内容
 * revert 直接触发回退，在控制代码中直接抛出错误
 * assert 检查异常(Panic)，断言，成功则执行后面代码，否则不执行（不包含报错信息），一般用智能合约写测试
 * - gas refund, state updates are reverted 退还gas费，状态变量回滚
 * custom error 自定义错误（8.0新增功能）
 * - save gas 节省gas费
 */
contract Error {

    // 需要满足某种条件后才能执行后面代码，否则抛出引号内报错内容
    function testRequire(uint i) public pure {
        // 需要 i <= 10 才能执行后面代码，否则报错 i > 10
        require(i <= 10, "i > 10");
        // more code...
    }

    // 在控制代码中直接抛出错误
    function testRevert(uint i) public pure {
        if(i > 10) {
            // 直接抛出错误信息
            revert("i > 10");
        }
    }

    uint public num = 123;
    // 断言，成功则执行后面代码，否则不执行（不包含报错信息），一般用智能合约写测试
    function testAssert() public view {
        assert(num == 123);
        // more code...
    }

    // custom error
    error MyError(address caller, uint i);
    function testCustomError(uint _i) public view {
        if(_i > 10)
        {
            revert MyError(msg.sender, _i);
        }
    }
}