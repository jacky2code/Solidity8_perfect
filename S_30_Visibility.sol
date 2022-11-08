// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Visibility 可视范围
// private 私有的- only inside contract
// internal 内部的 - only inside contract and child contracts
// public 公开的 - inside and outside contract
// external 外部的 - only from outside contract

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();

        // 外部函数可以使用this关键字访问，比较浪费gas，不建议使用
        this.externalFunc();
    }
}

// 外部合约继承于父合约
contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        y + z;
        // 可以调用内部方法
        internalFunc();
        // 可以调用公开方法
        publicFunc();
    }
}
