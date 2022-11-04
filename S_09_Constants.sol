// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//  Constants 常量
//  变量名约定俗成大写
//  读取常量消耗的gas会比较小，编译部署，运行下面合约看看调用address分别消耗多少gas（详细需要部署到页面端Remix查看）
contract Constants {
    // 管理员地址通常定义为常量，变量名约定俗成大写
    address public constant MY_ADDRESS = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
    uint public constant MY_UINT = 123;
}

contract NormalVar {
    address public NorAddress = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
}