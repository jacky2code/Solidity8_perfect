// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * MultiSignWallet 多签钱包
 * 多个人同意的情况下才能转出主币
 */
contract MultiSignWallet {
    // 收款事件 
    event Deposit(address indexed sender, uint amount);
    // 提交交易申请
    event Submit(uint indexed txId);
    // 签名人批准
    event Approve(address indexed owner, uint indexed txId);
    // 撤销
    event Revoke(address indexed owner, uint indexed txId);
    // 执行发送主币
    event Execute(uint indexed txId);

    // 交易结构体
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    // 保存所有的合约拥有者
    address[] public owners;
    // 判断是否签名人
    mapping (address=>bool) public isOwner;
    // 最小确认数
    uint public required;
    // 交易列表
    Transaction[] public transactions;
    // 某个交易下，签名人是否同意
    mapping (uint=>mapping(address=>bool)) public approved;
    // 验证拥有者
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }
    /**
     * 验证交易id是否存在
     * _txId: 交易id
     */
    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx does not exist!");
        _;
    }
    /**
     * 验证交易是否被该合约调用者同意
     * _txId: 交易id
     */
    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "tx was approved!");
        _;
    }
    /**
     * 验证交易是否被执行过
     * _txId: 交易id
     */
    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "tx was executed");
        _;
    }

    /**
     * 构造方法
     * _owners: 添加多签地址
     * _required: 最小同意数
     */
    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required");
        require(_required > 0 && _required <= _owners.length, "invalid required number of owners");
        // 判断地址的有效性
        for (uint index = 0; index < _owners.length; index++) {
            address owner = _owners[index];
            // 非 0 地址
            require(owner != address(0), "invalid owner");
            // 不能是已存在地址
            require(!isOwner[owner], "owner is not unique");
            // 更新所有者映射
            isOwner[owner] = true;
            // 加入所有者中
            owners.push(owner);
        }
        required = _required;
    }

    /**
     * 收款方法
     */
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    /**
     * 提交交易
     * _to : 目标地址
     * _value : 交易数量
     * _data : 如果目标地址是合约可以在此调用合约函数 (低级calldata)
     */
    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner{
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));
        emit Submit(transactions.length - 1);
    }

    /**
     * 批准
     * 条件 conditions
     *  1.管理员
     *  2.交易id存在
     *  3.交易没有被批准
     *  4.交易没有被执行
     */
    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    /**
     * 获取交易管理员同意数
     * _txId: 交易id
     */
    function _getApprovalCount(uint _txId) private view returns (uint count) {
        for (uint i = 0; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }

    /**
     * 执行
     * _txId: 交易id
     */
    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovalCount(_txId) >= required, "approvals < required!");
        Transaction storage transaction = transactions[_txId];

        (bool success, ) = transaction.to.call{value:transaction.value}(
            transaction.data
            );

        require(success, "tx failure!");
        transaction.executed = true;
        emit Execute(_txId);
    }

    /**
     * 撤销
     * _txId: 交易id
     */
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx was approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}