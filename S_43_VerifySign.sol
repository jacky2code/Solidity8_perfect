// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
    Verify Sign 验证签名
    步骤
    1.message to sign 消息签名
    2.hash(message) 将消息进行哈希值
    3.sign(hash(message), private key) | offchain 消息和私钥进行签名，线下完成
    4.ecrecover(hash(message), signature) == signer 恢复签名，如果签名地址等于想要的地址则正确
 */
 contract VerifySign {
    /**
     verify function
     param:
     _signer: signer address
     _message: message context
     _sign: sign
     */
    function verify(address _signer, string memory _message, bytes memory _sign) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMsgHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMsgHash, _sign) == _singer;
    }

    // 将消息进行哈希运算
    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }
    // ETH 签名消息哈希
    function getEthSignedMessageHash(bytes32 _msgHas) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _msgHas));
    }
    // 恢复签名地址
    function recover(bytes32 _ethSignedMsgHash, bytes memory _sign) public pure returns (address) {
        // 非对称加密
        (bytes32 r, bytes32 s, uint8 v) = _split(_sign);
        // 恢复签名
        return ecrecover(_ethSignedMsgHash, v, r, s);
    }

    // 分割签名
    function _split(bytes memory _sign) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sign.length == 65, "error sign length!");
        assembly {
            // 内存读取，每次跳过32位，读取之后的32位
            r := mload(add(_sign, 32))
            s := mload(add(_sign, 64))
            v := byte(0, mload(add(_sign, 96)))
        }
        return (r, s, v);
    }
 }