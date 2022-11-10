// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
A calls B, sends 100 wei
        B calls C, sends 50 wei
A --> B --> C
            msg.sender = B
            msg.value = 50
            execute code on C's state variables 改变C合约的状态变量
            use ETH in C

A calls B, sends 100 wei
        B delegatecall C
A --> B --> C
            msg.sender = A
            msg.value = 100
            execute code on B's state variables 改变B合约的状态变量
            use ETH in B
 */

 contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;
    address public owner;

    function setVars(uint _num) external payable {
        num = 2*_num;
        sender = msg.sender;
        value = msg.value;
    }
 }

// 用于升级合约，代理合约状态变量要和被调用合约状态变量顺序要一致。
 contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;
    function setVars(address _test, uint _num) external payable{
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );

        require(success, "delegatecall failed");
    }
 }