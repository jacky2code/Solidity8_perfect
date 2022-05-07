// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7;

/**
 * 简单存储
 * - 
 */
contract SimpleStorage {
    string public text;

    // calldata 89626 gas
    // memory 90114 gas
    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns (string memory) {
        return text;
    }
}