// SPDX-License-Identifier: GPL-3.0
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

contract B is A {
    function foo() public pure override returns (string memory) {
        return "B";
    }

    function bar() public pure override returns (string memory) {
        return "B";
    }

    // B合约因为继承A合约仍然包含 baz() 函数
}