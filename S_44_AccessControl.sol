// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 权限控制合约
 */
contract AccessControl {

    event GrantRole(bytes32 indexed role, address indexed addr);
    event RevokeRole(bytes32 indexed role, address indexed addr);

    // role nick name => address => bool 角色映射
    mapping(bytes32 => mapping(address => bool)) public roles;
    // role name hash
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    // 管理员权限
    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    // 通过构造函数给部署合约者授予管理员权限
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    /**
     * grant role
     */
    function _grantRole(bytes32 _role, address _addr) internal {
        roles[_role][_addr] = true;
        // 向外部抛出执行状态事件
        emit GrantRole(_role, _addr);
    }
    function grantRole(bytes32 _role, address _addr) external onlyRole(ADMIN){
        roles[_role][_addr] = true;
        // 向外部抛出执行状态事件
        emit GrantRole(_role, _addr);
    }

    /**
     * revoke role
     */
    function revokeRole(bytes32 _role, address _addr) external onlyRole(ADMIN) {
        roles[_role][_addr] = false;
        // 向外部抛出执行状态事件
        emit RevokeRole(_role, _addr);
    }
}