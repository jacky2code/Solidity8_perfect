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



## 8. 默认值

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 默认值
 */
contract DefaultValues {
    bool public b;  // default: false
    uint public u;  // default: 0
    int public i;   // default: 0
    address public a;   // default: 0x0000000000000000000000000000000000000000
    bytes32 public b32; // default: 0x0000000000000000000000000000000000000000000000000000000000000000

    // mapping, structs, enums, fixed sized arrays
}
```

编译部署后，运行

``` bash
[2:17:10 PM]: Calling method 'b32' with [] from 0x821251076b7B613AEF850A84a79977C4d7C2E329 at contract address 0xDED404CE158A48a8A0cFBA66eEA67327aFf69D9b
[2:17:10 PM]: "0x0000000000000000000000000000000000000000000000000000000000000000"
[2:17:35 PM]: Network is a local or custom network!
[2:17:35 PM]: Calling method 'a' with [] from 0x821251076b7B613AEF850A84a79977C4d7C2E329 at contract address 0xDED404CE158A48a8A0cFBA66eEA67327aFf69D9b
[2:17:35 PM]: "0x0000000000000000000000000000000000000000"
[2:17:58 PM]: Network is a local or custom network!
[2:17:58 PM]: Calling method 'i' with [] from 0x821251076b7B613AEF850A84a79977C4d7C2E329 at contract address 0xDED404CE158A48a8A0cFBA66eEA67327aFf69D9b
[2:17:58 PM]: "0"
[2:18:01 PM]: Network is a local or custom network!
[2:18:01 PM]: Calling method 'u' with [] from 0x821251076b7B613AEF850A84a79977C4d7C2E329 at contract address 0xDED404CE158A48a8A0cFBA66eEA67327aFf69D9b
[2:18:02 PM]: "0"
[2:18:11 PM]: Network is a local or custom network!
[2:18:11 PM]: Calling method 'b' with [] from 0x821251076b7B613AEF850A84a79977C4d7C2E329 at contract address 0xDED404CE158A48a8A0cFBA66eEA67327aFf69D9b
[2:18:11 PM]: false
```



## 9. 常量

使用常量消耗gas比变量少

``` solidity
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
```



## 10. 结构控制

 使用 if else 进行结构控制，或者使用三元运算符

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 结构控制
 */
contract IfElse {
    function example (uint x) external pure returns (uint) {
        if(x < 10) {
            return 1;
        } else if (x < 20) {
            return 2;
        } else {
            return 3;
        }
    }

    function ternary(uint x) external pure returns (uint) {
        // 三目运算
        return x < 10 ? 1 : 2;
    }
}
```



## 11. 循环

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 循环
 */
contract ForAndWhileLoops {
    function forLoops () external pure {
        for(uint i = 0; i < 10; i++) {
            // code ...
            if(i == 3) 
            {
                // 跳过之后的代码
                continue;
            }
            // more code ...
            if(i == 5)
            {
                // 跳出循环
                break;
            }
        }
    }

    function whileLoops() external pure {
        uint j = 0;

        while(j < 10)
        {
            j++;
        }
    }

    // s 加 n 次
    function sum(uint n) external pure returns (uint) {
        uint s;

        for(uint i = 1; i <= n; i++)
        {
            s += i; 
        }
        return s;
    }
}
```



## 12. 报错控制

报错用法

- require; 
- revert; 
- assert

自定义报错，节省gas

- custom error

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * require, revert, assert
 * - gas refund, state updates are reverted
 * custom error
 * - save gas
 */
contract Error {
    function testErquire(uint i) public pure {
        // 需要 i <= 10 才能执行后面代码，否则报错 i > 10
        require(i <= 10, "i > 10");
        // code
    }

    function testRevert(uint i) public pure {
        if(i > 10) {
            // 直接抛出错误信息
            revert("i > 10");
        }
    }

    uint public num = 123;

    function testAssert() public view {
        // 断言，成功则执行后面代码，否则报错
        assert(num == 123);
    }


    error MyError(adress caller, uint i);
    function testCustomError(uint i) public view {
        if(i> 10)
        {
            revert MyError(msg.sender, i);
        }
    }
}
```



## 13. 函数修改器

复用代码，注意代码执行顺序。

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * Function modifier 
 * - reuse code before and / or after function
 * Basic, inputs, sandwich
 */
contract FunctionModifier {
    bool public paused;
    uint public count;

    
    function setPause(bool _paused) external {
        paused = _paused;
    }
    // ------ 原始函数 ------
    function inc() external {
        require(!paused, "paused");
        count += 1;
    }

    function dec() external {
        require(!paused, "paused");
        count -= 1;
    }
    // ------ end -------

    // ------ 使用函数修改器 ------
    modifier whenNotPaused() {
        require(!paused, "paused");
        _;
    }
    function incNew() external whenNotPaused {
        count += 1;
    }
    function decNew() external whenNotPaused {
        count -= 1;
    }
    // ------ end -------

    // ----- inputs：带参数的函数修改器-原始函数 ------
    function incBy(uint _x) external whenNotPaused {
        require(_x < 100, "x >= 100");
        count += _x;
    }
    // ------ end -------

    // ----- inputs：带参数的函数修改器 ------
    modifier cap(uint _x) {
        // 在修改器中检查
        require(_x < 100, "x >= 100");
        _;
    }

    function incByNew(uint _x) external whenNotPaused cap(_x) {
        count += _x;
    }
    // ------ end -------

    // ------ sandwich ------
    modifier sandwich() {
        // code here
        count += 10;
        _;
        // more code here
        count *= 2;
    }

    // 代码运行顺序
    // 0: 先运行sandwich修改器中 _ 以上的代码
    // 1: 运行foo函数中的代码
    // 2: 运行sandwich修改器中 _ 以下的代码
    function foo() external sandwich {
        count += 1;
    }
    // ------ end -------
}
```

