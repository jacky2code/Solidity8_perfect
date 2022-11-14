// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * @name: Receiver 
 * @desc: 函数签名，代表虚拟机如何找到合约中的函数
 */
contract Receiver {
    event Log(bytes data);

    /**
     * @name: transfer
     * @desc: 发送主币
     * @param {address} _to
     * @param {uint} _amount
     * @return {*}
     */    
    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
        // 取出data前面数值：0xa9059cbb,这是虚拟机对函数名和参数（"transfer(address,uint256)"）进行的哈希加密得到的bytes4返回值
    }
}

/**
 * @name: FunctionSelector 
 * @desc: 验证上面的函数签名,通过验证"transfer(address,uint256)",得到0xa9059cbb
 */
contract FunctionSelector {
    /**
     * @name: getSelector
     * @desc: 验证函数签名
     * @param {string calldata} _funcStr，example: "transfer(address,uint256)"
     * @return {*} result: 0xa9059cbb
     */    
    function getSelector(string calldata _funcStr) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_funcStr)));
    }
}