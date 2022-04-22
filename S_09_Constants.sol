// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 常量
 * 读取常量消耗的gas会比较小，编译部署，运行下面合约看看调用address分别消耗多少gas（详细需要部署到页面端Remix查看）
 */
contract Constants {
    address public constant MY_ADDRESS = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
    uint public constant MY_UINT = 123;
}

contract NormalVar {
    address public NorAddress = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
}

