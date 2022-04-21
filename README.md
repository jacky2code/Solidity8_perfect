# Solidity 8.0 perfect



## 1. 环境部署

部署开发环境，及本地的发布测试环境
### 1.1 开发环境

本教程使用 vscode ，在插件市场中下载 Ethereum Remix 插件，自动安装所需插件。

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421163804.png" align="left" style="width:500px"/>

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421170404.png" align="left" style="width:500px"/>

### 1.2 发布测试环境

下载安装 Ganache 选择 quickstart 部署本地发布测试环境

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421163640.png" align="left" style="width:500px" />

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421170417.png" align="left" style="width:500px" />

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

  - 点击 Run & Deploy 先连接本地测试环境，获取 Ganache 中RPC Server 地址，默认 http://127.0.0.1:7545

    <img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421164855.png" align="left" style="width:500px"/>

  - 发布

    <img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421165112.png" align="left" style="width:500px"/>

    输出显示成功

    ``` bash
    [4:51:24 PM]: Loading remote version v0.8.7+commit.e28d00a7... please wait
    [4:51:35 PM]: Remote version v0.8.7+commit.e28d00a7 loaded.
    [4:51:36 PM]: Compilation finished for token/solidity/solidity8_perfect/HelloWorld.sol with solidity version 0.8.7+commit.e28d00a7.Emscripten.clang.
    ```

- 部署 (deploy)

  - ABI 其中生成合约的 ABI，可复制用于其他 Dapp 项目

  - 合约地址：Deployed Contranct Address

    <img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421165706.png" align="left" style="width:500px"/>
  
  - CALL 输出内容：
  
    ``` bash
    [5:00:11 PM]: Calling method 'myString' with [] from 0xa1A59E6D9B69D50aaF7ead540f5bE888B6ee47b3 at contract address 0x64342db66D48fd4e7923828608aa3ee77BFc76e9
    [5:00:11 PM]: "hello world!"
    ```
  
    

