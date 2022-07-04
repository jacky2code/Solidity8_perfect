// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 不知道合约代码或者合约代码太庞大，写接口进行调用
interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}