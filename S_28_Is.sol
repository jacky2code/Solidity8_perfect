// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    function baz() public pure returns (string memory) {
        return "A";
    }
}

// B 继承 A
// A 合约中的逻辑，复用到B合约中，节省代码量
// 父合约关键字 virtual，子合约关键字 override
contract B is A {
    function foo() public pure override returns (string memory) {
        return "B";
    }

    function bar() public pure override returns (string memory) {
        return "B";
    }

    // B合约因为继承A合约仍然包含 baz() 函数
}