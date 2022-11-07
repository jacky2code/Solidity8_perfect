// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Enum 枚举
contract Enum {
    enum Status {
        None,       // 第一个值是默认值
        Pending,    // 处理中
        Shipped,    // 装载
        Completed,  // 已完成
        Rejected,   // 拒绝
        Canceled    // 取消
    }

    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status; // 恢复默认值 None
    }
}
