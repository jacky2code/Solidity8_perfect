# Solidity 8.0 perfect

## 1. 环境部署
部署开发环境，及本地的发布测试环境
### 1.1 开发环境
本教程使用 vscode ，在插件市场中下载 Ethereum Remix 插件，自动安装所需插件。
### 1.2 发布测试环境
下载安装 Ganache 选择 quickstart 部署本地发布测试环境

## 2. HelloWorld
- 代码部分
创建文件夹 solidity8_perfect，在根目录创建 HelloWorld.sol 文件
``` csharp
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7 <0.9.0;

contract HelloWorld {
    string public myString = "hello world!";
}
```
- 发布 (compile)
- 部署 (deploy)