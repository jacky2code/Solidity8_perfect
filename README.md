# Solidity 8.0 perfect



## 1. 环境部署

部署开发环境，及本地的发布测试环境
### 1.1 开发环境

本教程使用 vscode ，在插件市场中下载 Ethereum Remix 插件，自动安装所需插件。编译版本选择 0.8.7及以上

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421163804.png" align="center" style="width:500px"/>

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421170404.png" align="center" style="width:500px"/>

### 1.2 发布测试环境

下载安装 Ganache 选择 quickstart 部署本地发布测试环境

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421163640.png" align="center" style="width:500px" />

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421170417.png" align="center" style="width:500px" />

## 2. HelloWorld

- 代码部分
  创建文件夹 solidity8_perfect，在根目录创建 HelloWorld.sol 文件

  ``` solidity
  // SPDX-License-Identifier: GPL-3.0
  
  pragma solidity >=0.8.7 <0.9.0;
  
  contract HelloWorld {
      string public myString = "hello world!";
  }
  ```

- 发布 (compile)

  - 点击 Run & Deploy 先连接本地测试环境，获取 Ganache 中RPC Server 地址，默认 http://127.0.0.1:7545

    <img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421164855.png" align="center" style="width:500px"/>

  - 发布

    <img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421165112.png" align="center" style="width:500px"/>

    输出显示成功

    ``` bash
    [4:51:24 PM]: Loading remote version v0.8.7+commit.e28d00a7... please wait
    [4:51:35 PM]: Remote version v0.8.7+commit.e28d00a7 loaded.
    [4:51:36 PM]: Compilation finished for token/solidity/solidity8_perfect/HelloWorld.sol with solidity version 0.8.7+commit.e28d00a7.Emscripten.clang.
    ```

- 部署 (deploy)

  - ABI 其中生成合约的 ABI，可复制用于其他 Dapp 项目

  - 合约地址：Deployed Contranct Address

    <img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421165706.png" align="center" style="width:500px"/>
  
  - CALL 输出内容：
  
    ``` bash
    [5:00:11 PM]: Calling method 'myString' with [] from 0xa1A59E6D9B69D50aaF7ead540f5bE888B6ee47b3 at contract address 0x64342db66D48fd4e7923828608aa3ee77BFc76e9
    [5:00:11 PM]: "hello world!"
    ```
  
    

##  3. 变量类型

bool, uint, int, address, bytes32

``` solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7 <0.9.0;

/**
 * 类型
 */
contract Types {
    bool public b = true;

    // uint = uint256 0 to 2**256 -1
    //        uint8   0 to 2**8 - 1
    //        uint16  0 to 2**16 - 1
    uint public u = 123;

    // int = int256 -2**255 to 2**255 -1 
    int public i = -123;

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;

    bytes32 public b32 = 0x657468657265756d000000000000000000000000000000000000000000000000;
}
```



## 4. 函数

关键字

- external 外部函数
- pure 纯函数，不能够读写状态变量，只能拥有局部变量
- view 能读写状态变量

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 函数
 */
contract Functions {
    // external : 外部函数
    // pure : 纯函数，不能够读写状态变量，只能拥有局部变量
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }
}
```



## 5. 变量

- 状态变量：写入区块链的变量数据

  ``` solidity
  uint public myUint = 123;
  uint public i;
  bool public b;
  address public myAddress;
  ```

- 局部变量

  ``` solidity
  function foo() external {
      uint x = 123;
      bool f = false;
      
      x += 456;
      f = true;
  
      // 修改上文中的状态变量的值
      i = 123;
      b = true;
      myAddress = address(1);
  }
  ```

- 全局变量

  ``` solidity
  function globalVars() external view returns (address, uint, uint) {
      address sender = msg.sender;
      uint timestamp = block.timestamp;
      uint blockNum = block.number;
  
      return (sender, timestamp, blockNum);
  }
  ```



## 6. 只读函数

``` solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7 <0.9.0;

/**
 * 只读函数
 */
contract VuewAndPureFunctions06 {
    uint public num;

    // view 函数可以读取链上的信息
    function ViewFunc() external view returns (uint) {
        return num;
    }

    // pure 不能读取链上信息
    function PureFunc() external pure returns (uint) {
        return 1;
    }

    function AddToNum(uint x) external view returns (uint) {
        return num + x;
    }

    function Add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}
```



## 7. 计数器合约

对一个状态变量进行增加、减少的操作，编译部署后测试。

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 计数器合约
 * 对状态变量进行增加、减少操作
 */
contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }

}
```



