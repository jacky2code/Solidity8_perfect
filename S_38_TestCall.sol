// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) external payable returns (bool, uint){
        message = _message;
        x = _x;
        return (true, 999);
    }
    receive() external payable{}
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 111, gas: 5000}(
            abi.encodeWithSignature("foo(string, uint256)", 
            "call foo", 
            123));

        require(success, "called failed");
        data = _data;
    }
    // 调用合约不存在的函数
    function callDoesNotExitFunc(address _test) external {
        (bool success, ) = _test.call(abi.encodeWithSignature("DoesNotExit()"));
        require(success, "call failed");
    }
}