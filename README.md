# Solidity 8.0 perfect



## 1. Environment 环境部署

部署开发环境，及本地的发布测试环境

### 1.1 Develop 开发环境

本教程使用 vscode ，在插件市场中下载 Ethereum Remix 插件，自动安装所需插件。编译版本选择 0.8.7及以上

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421163804.png" align="center" style="width:500px"/>

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421170404.png" align="center" style="width:500px"/>

### 1.2 Testnet 发布测试环境

下载安装 Ganache 选择 quickstart 部署本地发布测试环境

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421163640.png" align="center" style="width:500px" />

<img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421170417.png" align="center" style="width:500px" />



## 2. HelloWorld

- 代码部分
  创建文件夹 solidity8_perfect，在根目录创建 HelloWorld.sol 文件

  ``` solidity
  // SPDX-License-Identifier: MIT
  pragma solidity ^0.8.7;
  
  contract HelloWorld {
      string public myString = "Hello world!";
  }
  ```
  
- 编译 (compile)

  - 点击 Run & Deploy 先连接本地测试环境，获取 Ganache 中RPC Server 地址，默认 http://127.0.0.1:7545

    <img src="https://markdown-res.oss-cn-hangzhou.aliyuncs.com/mdImgs/2022/04/21/20220421164855.png" align="center" style="width:500px"/>

  - compile

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
  
    

##  3. Types 变量类型

bool, uint, int, address, bytes32

- bool

  ```solidity
  bool public b = true;
  ```

- uint

  - uint 是 uint256 默认缩写，为了好的代码习惯，最好写成uint256，以辨认范围

  - 无符号整数，正整数，没有负数
  - 范围 0 to 2 ** 256 - 1
  - 其他范围
    - uint8: 范围 0 to 2 ** 8 - 1 
    - uint16: 范围 0 to 2 ** 16 - 1 

- int

  - int 是 int256 的缩写
  - 范围 -2 ** 255 to 2 ** 255 - 1 
  - 其他范围
    - int128：-2 ** 127 to 2 ** 127 - 1 

- address

  address 是一个16进制数字，通过私钥公钥计算出来

  ``` solidity
  address public addr = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
  ```

- bytes32

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Data types -- value and references
contract Types {
    // bool
    bool public b = true;

    // uint = uint256 范围 0 to 2**256 -1
    //        uint8   范围 0 to 2**8 - 1
    //        uint16  范围 0 to 2**16 - 1
    uint256 public u256 = 2 ** 256 - 1;
    uint8 public u8 = 2 ** 8 - 1;
    uint16 public u16 = 2 ** 16 -1;

    // int = int256 范围 -2**255 to 2**255 -1 
    int256 public i256 = -123;

    // int 最小值
    int public minInt = type(int).min;
    // int 最大值
    int public maxInt = type(int).max;

    // address 是一个16进制数字，通过私钥公钥计算出来
    address public addr = 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6;
    bytes32 public b32 = 0x657468657265756d000000000000000000000000000000000000000000000000;
}
```



## 4. Functions 函数

函数的类型有两类，默认的是内部函数，因此不需要声明 internal 关键字

- 内部函数类型（internal）

  内部函数只能在当前合约内被调用（在当前代码块内，包括内部库函数和继承的函数中），因为它们不能在当前合约上下文的外部被执行。

- 外部函数类型（external）

  外部函数由一个地址和一个函数签名组成，可以通过外部函数调用传递或者返回。

关键字

- pure 纯函数，不能够读写状态变量，只能拥有局部变量
- view 能读写状态变量、读取全局变量

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Functions
//  函数类型有两类：
//  函数类型默认是内部函数，因此不需要声明 internal 关键字
//      内部函数类型（internal）
//          内部函数只能在当前合约内被调用（在当前代码块内，包括内部库函数和继承的函数中），因为它们不能在当前合约上下文的外部被执行。
//      外部函数类型（external）
//          外部函数由一个地址和一个函数签名组成，可以通过外部函数调用传递或者返回。            
contract Functions {
    
    // external : 外部函数，只能在外部读取的函数
    // pure : 纯函数，不能够读写状态变量，只能拥有局部变量
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }

    function sub(uint256 x, uint256 y) external pure returns (uint256) {
        if(x<y)
        {
            return 0;
        }
        else
        {
            return x - y;
        }
    }
}
```



## 5. Variables 变量

变量类型有状态变量，局部变量，全局变量

- 状态变量：写入区块链的变量数据

- 局部变量：方法内声明的变量

- 全局变量：常用于记录链上信息和账户信息
  - 关键词 view 只读方法，但可以读取状态变量和全局变量的值
  

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//  Variables
//      状态变量
//      局部变量
//      全局变量
contract Variables {
    // 3.1 状态变量 StateVariables ：写入区块链的变量数据
    uint public myUint = 123;
    uint public i;
    bool public b;
    address public myAddress;

    // 3.2 局部变量
    function foo() external {
        
        uint x = 123;
        bool f = false;
        
        x += 456;
        f = true;

        // 修改状态变量的值
        i = 123;
        b = true;
        myAddress = address(1);
    }
    
    // 3.3 全局变量，常用于记录链上信息和账户信息
    function globalVars() external view returns (address, uint, uint) {
        // 调用此函数的地址
        address sender = msg.sender;
        // 出区块时间戳
        uint timestamp = block.timestamp;
        // 当前区块编号
        uint blockNum = block.number;
        return (sender, timestamp, blockNum);
    }
}
```



## 6. Functions keywords 函数关键字

- view

  读取链上数据，如状态变量和全局变量

- pure

  不能赌链上数据，只能声明局部变量

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Functions keywords view and pure
contract ViewAndPureFunctions{
    // 状态变量 num
    uint public num;

    // view 函数可以读取链上的信息（状态变量 num）
    function ViewFunc() external view returns (uint) {
        return num;
    }

    // pure 不能读取链上信息，只能声明局部变量
    function PureFunc() external pure returns (uint) {
        return 1;
    }

    function AddToNum(uint x) external view returns (uint) {
        return num + x;
    }

    // 使用pure关键字，只对参数做了计算没有引用状态变量或全局变量
    function Add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}
```



## 7. Summary 小结

编写一个计数器合约，对一个状态变量进行增加、减少的操作，编译部署后测试。

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Summary 小结；
// Counter 计数器合约，对状态变量进行增加、减少操作
contract Counter {
    uint public count;

    // 自增，external外部可视函数，在合约中的内部函数不能调用，只能通过外部读取
    function inc() external {
        count += 1;
    }
    // 自减
    function dec() external {
        count -= 1;
    }
}
```



## 8. Default values 默认值

基本数据类型的默认值

- bool 默认值是 false
- uint  默认值是 0
- int 默认值是 0
- address 默认值是 0x0000000000000000000000000000000000000000
- bytes32 默认值是 0x0000000000000000000000000000000000000000000000000000000000000000

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Default values 默认值
contract DefaultValues {
    bool public b;  // default value: false
    uint public u;  // default value: 0
    int public i;   // default value: 0
    address public a;   // default value: 0x0000000000000000000000000000000000000000
    bytes32 public b32; // default value: 0x0000000000000000000000000000000000000000000000000000000000000000

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



## 9. Constants 常量

变量名约定俗成大写

读取常量消耗的gas会比较小，编译部署，运行下面合约看看调用address分别消耗多少gas（详细需要部署到页面端Remix查看）

``` solidity
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
```

调用 MY_ADDRESS 消耗的 gas 如下：

```bash

from	0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
to	SimpleStorage.MY_ADDRESS() 0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B
execution cost	21442 gas (Cost only applies when called by a contract)
input	0x3a7...56cec
decoded input	{}
decoded output	{
	"0": "address: 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6"
}
logs	[]
```

调用 NorAddress 消耗的 gas 如下：

``` bash
from	0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
to	NormalVar.NorAddress() 0xf8e81D47203A594245E36C48e151709F0C19fBe8
execution cost	23553 gas (Cost only applies when called by a contract)
input	0xc3c...f5b35
decoded input	{}
decoded output	{
	"0": "address: 0x08655Ac0d18E0a77C04cdec8bd53A38a925d27f6"
}
logs	[]
```



## 10.Control Structures 结构控制

 使用 if else 进行结构控制，或者使用三元运算符

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Control Structures 结构控制
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

    // 三元运算
    function ternary(uint x) external pure returns (uint) {
        return x < 10 ? 1 : 2;
    }
}
```



## 11. Loops 循环

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Loops 循环
contract ForAndWhileLoops {

    uint public num = 0;
    // for 循环
    function forLoops () external returns (uint) {
        for(uint i = 0; i < 10; i++) {
            if(i == 3) 
            {
                // 跳过本次3 运行之后的代码
                continue;
            }
            num = num + i;
            if(i == 5)
            {
                // 彻底跳出循环，不运行5以后代码
                break;
            }
        }
        return num;
    }
    // while 循环
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



## 12. Error handling 报错处理

Solidity 使用状态恢复异常来处理错误。这种异常将撤消对当前调用（及其所有子调用）中的状态所做的所有更改，并且还向调用者标记错误。

报错用法

- require：检查错误(Error)，需要满足某种条件后才能执行后面代码，否则抛出引号内报错内容
- revert：直接触发回退，在控制代码中直接抛出错误
- assert：检查异常(Panic)，断言，成功则执行后面代码，否则不执行（不包含报错信息），一般用智能合约写测试

自定义报错，节省gas

- custom error

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * Error handling 报错处理
 * Solidity 使用状态恢复异常来处理错误。
 * 这种异常将撤消对当前调用（及其所有子调用）中的状态所做的所有更改，并且还向调用者标记错误。
 *
 * require 检查错误(Error)，需要满足某种条件后才能执行后面代码，否则抛出引号内报错内容
 * revert 直接触发回退，在控制代码中直接抛出错误
 * assert 检查异常(Panic)，断言，成功则执行后面代码，否则不执行（不包含报错信息），一般用智能合约写测试
 * - gas refund, state updates are reverted 退还gas费，状态变量回滚
 * custom error 自定义错误（8.0新增功能）
 * - save gas 节省gas费
 */
contract Error {

    // 需要满足某种条件后才能执行后面代码，否则抛出引号内报错内容
    function testRequire(uint i) public pure {
        // 需要 i <= 10 才能执行后面代码，否则报错 i > 10
        require(i <= 10, "i > 10");
        // more code...
    }

    // 在控制代码中直接抛出错误
    function testRevert(uint i) public pure {
        if(i > 10) {
            // 直接抛出错误信息
            revert("i > 10");
        }
    }

    uint public num = 123;
    // 断言，成功则执行后面代码，否则不执行（不包含报错信息），一般用智能合约写测试
    function testAssert() public view {
        assert(num == 123);
        // more code...
    }

    // custom error
    error MyError(address caller, uint i);
    function testCustomError(uint _i) public view {
        if(_i > 10)
        {
            revert MyError(msg.sender, _i);
        }
    }
}
```



## 13.Function modifier 函数修改器

在调用 modifier 的函数中（代码前或者代码后）复用报错代码

- basic：基本用法

  ``` solidity
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
  // 把报错提取出来作为一个复用的函数修改器
  modifier whenNotPaused() {
      require(!paused, "paused");
      // 下划线位置表示，调用函数的其他代码要在修改器的什么位置运行
      _;
  }
  function incNew() external whenNotPaused {
      count += 1;
  }
  function decNew() external whenNotPaused {
      count -= 1;
  }
  // ------ end -------
  ```

  

- inputs：带参数的用法

  ``` solidity
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
  ```

  

- sandwich：三明治用法

  代码执行顺序

  - 先运行sandwich修改器中 _ 以上的代码（count += 10;）
  - 运行foo函数中的代码 （count += 1;）
  - 再运行sandwich修改器中 _ 以下的代码 （count *= 2;）

``` solidity
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
```



完整代码，注意代码执行顺序。

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * Function modifier 函数修改器
 * - reuse code before and / or after function
 * Basic：基本用法
 * inputs：带参数的用法
 * sandwich：三明治用法
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
    // 把报错提取出来作为一个复用的函数修改器
    modifier whenNotPaused() {
        require(!paused, "paused");
        // 下划线位置表示，调用函数的其他代码要在修改器的什么位置运行
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



## 14. Constructor 构造函数

构造函数：只在合约部署的时候调用一次，之后不再调用

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * Constructor - 构造函数
 * 只在合约部署的时候调用一次，之后不再调用
 */
contract Constructor {
    address public owner;
    uint public x;

    constructor(uint _x) {
        // 让 owner 是合约的部署者
        owner = msg.sender;
        // 用户输入 x 值
        x = _x;
    }
}
```



## 15. Ownable 权限管理合约

- 通过构造函数设置合约管理员
- 添加函数修改器，设置必要函数必须通过管理员调用
- 设置新的管理员方法，必须是管理员调用，并且地址不能是0地址，不然会被锁死

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * Ownable 权限管理合约 
 * 重新设置合约拥有者
 * 只有合约拥有者能调用的函数
 * 其他人可以调用的函数
 */
contract Ownable {
    address public owner;

    // 构造函数
    constructor() {
        owner = msg.sender;
    }

    // 函数修改器
    modifier onlyOwner() {
        // 调用者必须是合约拥有者
        require(msg.sender == owner, "not owner");
        _;
    }

    // 设置新的所有者
    function setNewOwner(address _newOwner) external onlyOwner {
        // 不可以是 0 地址
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    // 只有管理员可以调用
    function onlyOwnerCanCallThisFunc() external onlyOwner {
        // more code
    }

    // 任何人可以调用
    function anyOneCanCallThisFunc() external {
        // more code
    }
}
```



## 16. Function outputs 函数返回值

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 函数返回值
 */
contract FunctionOutputs {

    // 普通返回值函数
    function returnManay() public pure returns (uint, bool) {
        return (1, true);
    }

    // 返回值命名
    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    // 隐式返回，直接通过参数名赋值
    function namedAssigned() public pure returns (uint x, bool b) {
        x = 1;
        b = false;
    }

    // 获取返回值
    function destructingAssigments() public pure {
        (uint x, bool b) = returnManay();
        // 只取一个返回值
        (, bool c) = returnManay();
    }
}
```



## 17. Array 数组

数组分类

- Dynamic Array 动态数组
- Fixed size Array 定长数组

数组操作

 * Initialization 初始化
 * push 插入
 * get 获取
 * update 更新
 * delete 删除
 * pop 弹出
 * length 长度
 * Creating array in memory 内存中创建数组
 * Returning array from function 函数返回数组

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 数组
 * 数组分类
 * - Dynamic Array 动态数组
 * - Fixed size Array 定长数组
 * 数组操作
 * Initialization 初始化
 * push 插入
 * get 获取
 * update 更新
 * delete 删除
 * pop 弹出
 * length 长度
 * Creating array in memory 内存中创建数组
 * Returning array from function 函数返回数组
 */
contract Array {
    // 动态数组
    uint[] public nums = [1, 2, 3];
    // 定长数组
    uint[5] public numsFixed = [4, 5, 6, 7, 8];

    function examples() external {
        // 向数组尾部推入数据
        nums.push(4);   // [1, 2, 3, 4]
        uint x = nums[0];   // x = 1
        nums[2] = 777;  // [1, 2, 777, 4]
        // 删除数组的值，但不会更改长度，赋 0
        delete nums[1]; // [1, 0, 777, 4]
        // 弹出数组最后一位数据
        nums.pop(); // [1, 2, 777]
        uint len = nums.length;

        // 内存中创建数组
        uint[] memory a = new uint[](5);    
        // 内存中只能定义定长数组，根据索引赋值，不能pop或push
        a[1] = 123;
    }

    // 返回数组所有内容，内存类型
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}
```



## 18. * Array Shift 删除数组元素通过移位/替换

- 通过移位删除数组元素

  - 实现思路：先把 index 后的值前移 1 位，然后再 pop 掉最后一位元素
  - 示例：[1, 2, 3] --> remove(1) --> [1, 3, 3] --> [1, 3]
  - 优点：数组顺序没有变化
  - 缺点：消耗大量gas

- 通过替换删除数组元素

  - 实现思路：把要删除的元素数据用最后一个元素数据替换，最后再pop掉最后一个数据
  - 示例：[1, 2, 3, 4] --> removeNew(1) --> [1, 4, 3, 4] --> [1, 4, 3]
  - 优点：消耗少量gas
  - 缺点：数组顺序发生变化

  ``` solidity
  // SPDX-License-Identifier: MIT
  pragma solidity ^0.8.7;
  
  contract ArrayShift {
      uint[] public arr;
  
      function example() public {
          arr = [1, 2, 3];
          delete arr[1];  // [1, 0, 3]
      }
  
      // 实现 remove 数组中的某个值。(数组的顺序不变，但是比较消耗gas)
      // 例如
      // [1, 2, 3] --> remove(1) --> [1, 3, 3] --> [1, 3]
      // 实现思路 先把 index 后的值前移 1 位，然后再 pop 最后一位
      function remove(uint _index) public {
          require(_index < arr.length, "index out of array range!");
          for (uint i = _index; i < arr.length; i++) {
              // 从需要替换的位置开始，后一个值赋值给前一个值
              arr[i] = arr[i + 1];
          }
          // 弹出最后一个值，实现数组顺序不变
          arr.pop();
      }
  
      // 实现方法二：比较少消耗gas，但是顺序打乱了
      // 实现思路：把要删除的数据用最后一个数据替换，最后再pop掉最后一个数据
      // [1, 2, 3, 4] --> removeNew(1) --> [1, 4, 3, 4] --> [1, 4, 3]
      function removeNew(uint _index) public {
          require(_index < arr.length, "index out of array range!");
          // 数组最后一个值，赋值给要删除的值
          arr[_index] = arr[arr.length - 1];
          arr.pop();
      }
  
      // 测试
      function testNew() external {
          arr = [1, 2, 3, 4];
  
          // remove(1);
          removeNew(1);
  
          assert(arr.length ==3);
          assert(arr[0] == 1);
          assert(arr[1] == 4);
          assert(arr[2] == 3);
      }
  }
  ```
  
   
## 19. Mapping 映射
如何声明映射

- 声明简单映射

``` solidity
// 地址-余额 映射
mapping(address => uint) public balances;
```

- 声明嵌套映射

```solidity
// 多重映射
mapping(address => mapping(address => bool)) public isFirend;
```

操作映射

- set

```solidity
 balances[msg.sender] = 1234;    // 赋值
```

- get

```solidity
uint bal = balances[msg.sender];    // 获取值
```

- delete

```solidity
delete balances[msg.sender];    // 删除后，变成默认值 0
```

从查找是否有 "tom" 这个值

- 第一种
  - 示例：["jacky1", "jacky2", "jacky3", "jacky4"]
  - 思路：挨个循环查找，消耗大量gas；
- 第二种
  - 示例：["jacky1":true, "jacky2":true, "jacky3":true, "jacky4":true]
  - 思路：键值映射 true，只要判断arr["tom"]是否true就可以。

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

// Mapping
// How to declare mapping (simple and nested)
// Set, get, delete
contract Mapping {
    // 地址，余额映射
    mapping(address => uint) public balances;
    // 多重映射
    mapping(address => mapping(address => bool)) public isFirend;

    function examples() external {
        // 赋值
        balances[msg.sender] = 1234;
        // 获取值
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)];   // 不存在应设置，默认返回 uint 默认值0
        balances[msg.sender] += 456;    // 123 + 456
        delete balances[msg.sender];    // 删除后，变成默认值 0
        isFirend[msg.sender][address(this)] = true;
    }
}
```



## 20. IterableMapping 可迭代映射

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 *   IterableMapping 可迭代映射
 */
contract IterableMapping {
    // 地址/余额
    mapping(address => uint) public balances;
    // 地址/是否存在
    mapping(address => bool) public isInserted;
    // 所有存在地址
    address[] public keys;

    /** 添加地址 */
    function set(address _key, uint _val) external {
        // 给地址赋值余额
        balances[_key] = _val;
        // 判断地址是否在映射中
        if (!isInserted[_key]) {
            // 添加映射
            isInserted[_key] = true;
            // 添加存在地址
            keys.push(_key);
        }
    }

    /** 获取地址数组长度 */
    function getSize() external view returns (uint) {
        return keys.length;
    }

    /** 获取第一个地址余额 */
    function getFirstAddressBal() external view returns (uint) {
        return balances[keys[0]];
    }

    /** 获取最后一个地址的余额 */
    function getLastAddressBal() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    /** 获取任意位置地址的余额 */
    function getAddressBalAtIndex(uint _index) external view returns (uint)
    {
        return balances[keys[_index]];
    }

    /** 遍历所有地址余额，getSize +  getAddressBalAtIndex 结合使用 */
}
```



## 21. Structs 结构体

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Structs 结构体
contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    // 单辆车
    Car public car;
    // 多辆车
    Car[] public cars;
    // 某人有多辆车
    mapping(address => Car[]) public carsByOwner;

    function example() external {
        Car memory ec6 = Car("NIO EC6", 2021, msg.sender);
        Car memory et7 = Car({year: 2022, model: "NIO ET7", owner: msg.sender});
        Car memory es8;
        es8.model = "NIO ES8";
        es8.year = 2019;
        es8.owner = msg.sender;

        cars.push(ec6);
        cars.push(et7);
        cars.push(es8);

        // 取出到内存中
        Car memory _car = cars[1];
        _car.year;

        // 取出到存储中
        Car storage _carModify = cars[0];
        _carModify.year = 2020;
        delete _carModify.owner;

        delete cars[1];
    }
}
```



## 22. Enum 枚举

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Enum 枚举
contract Enum {
    enum Status {
        None,       // 第一个值是默认值
        Pending,    // 处理中
        Shipped,    // 装载
        Completed,  // 已完成
        Rejected,   // 拒绝
        Canceled    // 取消
    }

    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status; // 恢复默认值 None
    }
}
```



## 23. 部署 Constract



## 24. Data Location 数据存储位置

- storage，用于状态变量

- memory，用于局部变量

- calldata，只用于输入参数,可以节约gas

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 数据存储位置
 * - storage，用于状态变量
 * - memory，用于局部变量
 * - calldata，只用于输入参数,可以节约gas
 */
contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint[] memory y, string memory s) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct(123, "bar");

        MyStruct storage myStruct = myStructs[msg.sender];
        // 修改后，状态变量的值随之改变
        myStruct.text = "newBar";

        MyStruct memory myStructMem = myStructs[msg.sender];
        // 修改后，状态变量不改变，只不过是局部变量myStructMem改变，并随着函数执行完而从内存中消失
        myStructMem.foo = 235;

        uint[] memory memArr = new uint[](3);
        memArr[0] = 345;
        return memArr;
    }

    function examples2(uint[] calldata y, string calldata s) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct(123, "bar");

        MyStruct storage myStruct = myStructs[msg.sender];
        // 修改后，状态变量的值随之改变
        myStruct.text = "newBar";

        MyStruct memory myStructMem = myStructs[msg.sender];
        // 修改后，状态变量不改变，只不过是局部变量myStructMem改变，并随着函数执行完而从内存中消失
        myStructMem.foo = 235;

        _internal(y);

        uint[] memory memArr = new uint[](3);
        memArr[0] = 345;
        return memArr;
    }

    function _internal(uint[] calldata y) private pure {
        uint x = y[0];
        x++;
    }
}
```



## 25. Simple storage 简单存储

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 简单存储
contract SimpleStorage {
    string public text;

    // 存储字符串：aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    // 使用 calldata 花费 89626 gas
    // 使用 memory 花费 90114 gas
    function set(string calldata _text) external {
        text = _text;
    }
    // 智能合约将状态变量拷贝到内存中再返回
    function get() external view returns (string memory) {
        return text;
    }
}
```



## 26. Todo list 待办事项列表

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 待办事项列表
 * - Insert, update, read from array of structs
 */
contract TodoList {
    // 事项结构体
    struct Todo {
        string text;
        // 待办状态
        bool completed;
    }
    // 待办数组
    Todo[] public todos;

    /** 创建待办事项 */
    function create(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    }

    /** 
     * 更新待办事项
     * _index: 待办事项索引
     * _text: 更新内容 
     */
    function updateText(uint _index, string calldata _text) external {
        // 35138 gas 如果只更新一个属性，则节省gas，更新多个多次装入内存反而消耗更多gas
        todos[_index].text = _text;
        // todos[_index].text = _text;
        // todos[_index].text = _text;
        // todos[_index].text = _text;

        // 34578 gas 更新多个属性则节省gas
        // Todo storage todo = todos[_index];
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
    }

    /** 
     * 获取待办事项
     * params
     * _index: 事项索引
     */
    function get(uint _index) external view returns (string memory, bool) {
        // storage - 29397 直接从状态变量中拷贝过来
        Todo storage todo = todos[_index];
        // memory - 29480 从状态变量中拷贝到内存
        // Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    /**
     * 更新是否完成
     * _index: 事项索引
     */
    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}
```

## 27. Event 事件

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 事件：记录当前智能合约运行状态
 * 事件存储更节约gas
 */
contract Event {
    // 声明事件
    event Log(string message, uint val);
    // 带有索引的事件，最多不超过3个索引
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        // 触发事件
        emit Log("foo", 123);
        emit IndexedLog(msg.sender, 345);
    }

    event Message(address _from, address _to, string message);
    
    function sendMsg(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
```

## 28. is 继承

B 合约继承 A 合约，A 合约中的逻辑，复用到B合约中，节省代码量

关键字：

- 父合约关键字：virtual
- 子合约关键字：override

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    function baz() public pure returns (string memory) {
        return "A";
    }
}

// B 继承 A
// A 合约中的逻辑，复用到B合约中，节省代码量
// 父合约关键字 virtual，子合约关键字 override
contract B is A {
    function foo() public pure override returns (string memory) {
        return "B";
    }

    function bar() public pure override returns (string memory) {
        return "B";
    }

    // B合约因为继承A合约仍然包含 baz() 函数
}
```

## 29. 多线继承,向父级函数的构造函数传参

- 多线继承，要把继承少的基础合约写在更前面，例如：

  X、Y、Z 三个合约中，Y 继承 X，Z 继承X和Y，这Z合约要写成 contract Z is X,Y {}

- 继承后向父级函数的构造函数传参

  - 方法一：直接在函数定义继承是传递参数

  ```solidity
  contract U is S("s"), T("t") {}
  ```

  - 方法二：在继承函数的构造方法中定义参数

  ``` sol
  contract V is S, T {
      constructor(string memory _name, string memory _text) S(_name) T(_text) {
      }
  }
  ```

- 调用父级合约的函数

  - 方法一：直接使用父级合约的名称调用

  ```solidity
  S.foo();
  ```

  - 方法二：使用super关键字调用，但是执行所有父级合约中包含foo的函数

  ```solidity
  super.foo();
  ```

全部代码

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 多线继承，要把继承少的基础合约写在更前面
// X、Y、Z 三个合约中，Y 继承 X，Z 继承X和Y，这Z合约要写成 contract Z is X,Y {}
// 继承后向父级函数的构造函数传参
contract S {
    string public name;
    event Log(string message);
    constructor(string memory _name) {
        name = _name;
    }

    function foo() public virtual {
        emit Log("s.foo");
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 继承后向构造函数传参
// 方法一
contract U is S("s"), T("t") {

}
// 多线继承，要把继承少的写在更前面
// 方法二
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
    function foo() public override {
        emit Log("V.foo");
        // 调用父级合约的函数
        // 方法一
        S.foo();
        // 方法二，执行所有父级合约中包含foo的函数
        super.foo();
    }
}

contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {
        
    }
}
```

## 30. Visibility 可视范围

- private 私有的 - 合约内部访问
- internal 内部的 - 合约内部和子合约可以访问
- public 公开的 - 内部和外部都可以访问
- external 外部的 - 外部合约可以访问

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Visibility 可视范围
// private 私有的- only inside contract
// internal 内部的 - only inside contract and child contracts
// public 公开的 - inside and outside contract
// external 外部的 - only from outside contract

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();

        // 外部函数可以使用this关键字访问，比较浪费gas，不建议使用
        this.externalFunc();
    }
}

// 外部合约继承于父合约
contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        y + z;
        // 可以调用内部方法
        internalFunc();
        // 可以调用公开方法
        publicFunc();
    }
}
```

## 31. Immutable 赋值常量关键字

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 必须部署的时候赋值
contract Immutable {
    // 方法一，不适用immutable关键字 消耗 45718 gass
    // address public owner = msg.sender;

    // 方法二 使用 immutable 关键字消耗 43585 gas，更节省gas
    // address public immutable owner = msg.sender;

    address public immutable owner;

    // 方法二-2，也可以构造函数中赋值
    constructor() {
        owner = msg.sender;
    }

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}
```

## 32. payable 接收以太坊主币关键字

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 向合约发送主币
contract Payable {
    // 地址可以发送ETH主币，使用关键字
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 向合约发送主币
    function deposit() external payable {

    }
    // 当前合约余额
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
```

## 33. fallback 执行回退

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
Fallback executed when
 - function does't exist
 - directly send ETH

fallback() or receive()?

    eth is send to contract
            |
        is msg.data empty?
            /  \
          yes  no
          /      \
receive() exist?  fallback()
           / \
         yes  no
         /      \
     receive()   fallback() 
 */

 contract Fallback {

    event Log(string func, address sender, uint value, bytes data);

    // 调用不存在函数和直接发送以太币都可以用
    fallback() external payable {
        // 参数：调用的方法，调用地址，发送数量，调用数据
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    // 单独发送以太币使用
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
 }
```

## 34. Send ETH 发送ETH

三种方法发送 ETH 主币

- transfer，消耗 2300 gas，如果失败 revert
- send，消耗 2300 gas，返回 boll 值表示是否成功
- call，消耗所有gas，返回boll值和数据

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 3 ways to send ETH
// transfer - 2300 gas, reverts
// send - 2300 gas, returns bool
// call - all gas, returns bool and data
/**
    三种方法发送 ETH 主币
    1. transfer，消耗 2300 gas，如果失败 revert
    2. send，消耗 2300 gas，返回 boll 值表示是否成功
    3. call，消耗剩余所有gas，返回boll值和数据
 */
contract SendETH {
    // 接收主币方法1
    constructor() payable {}
    // 接收主币方法2
    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(9);
    }
    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(8);
        require(sent, "send failed");
    }
    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 7}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
```

## 35. EtherWalllet

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherWallet {
    // 管理员
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }
    // 只发送主币，不带任何参数，用receive
    receive() external payable {

    }

    // 提取主币
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);

        // 方法二
        (bool sent,) = msg.sender.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
```

## 36. Call Contract 调用其他合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 调用其他合约
contract CallTestContract {

    // set 方法1
    function setX1(address _test, uint _x) external {
        TestContract(_test).setX(_x);
    }
    // set 方法2
    function setX2(TestContract _test, uint _x) external {
        _test.setX(_x);
    }

    function getX (address _test) external view returns (uint x){
        x = TestContract(_test).getX();
    }

    function setXandReceiveEther(address _test, uint _x) external payable {
        TestContract(_test).setXandReceiveEther{ value: msg.value }(_x);
    }

    function getXandValue(address _test) external view returns (uint x, uint value) {
        (x, value)= TestContract(_test).getXandValue();
    }
}

contract TestContract {
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}
```

## 37. Interface 接口合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

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

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 不知道合约代码或者合约代码太庞大，写接口进行调用
interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}
```

## 38. 低级call

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) external payable returns (bool, uint){
        message = _message;
        x = _x;
        return (true, 999);
    }
    receive() external payable{}
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 111, gas: 5000}(
            abi.encodeWithSignature("foo(string, uint256)", 
            "call foo", 
            123));

        require(success, "called failed");
        data = _data;
    }
    // 调用合约不存在的函数
    function callDoesNotExitFunc(address _test) external {
        (bool success, ) = _test.call(abi.encodeWithSignature("DoesNotExit()"));
        require(success, "call failed");
    }
}
```

## 39. 委托调用

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
A calls B, sends 100 wei
        B calls C, sends 50 wei
A --> B --> C
            msg.sender = B
            msg.value = 50
            execute code on C's state variables 改变C合约的状态变量
            use ETH in C

A calls B, sends 100 wei
        B delegatecall C
A --> B --> C
            msg.sender = A
            msg.value = 100
            execute code on B's state variables 改变B合约的状态变量
            use ETH in B
 */

 contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;
    address public owner;

    function setVars(uint _num) external payable {
        num = 2*_num;
        sender = msg.sender;
        value = msg.value;
    }
 }

// 用于升级合约，代理合约状态变量要和被调用合约状态变量顺序要一致。
 contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;
    function setVars(address _test, uint _num) external payable{
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );

        require(success, "delegatecall failed");
    }
 }
```

## 40. 工厂合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}
// 在工厂合约内创建账户合约
contract AccountFactory {
    
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        // 创建账户合约并返回地址, value 传入主币
        Account account = new Account{value: 123}(_owner);
        accounts.push(account);
    }
}
```

## 41. Library 库合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 返回最大值
library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint _x, uint _y) external pure returns (uint) {
        return Math.max(_x, _y);
    }
}

// 查找对应索引
library ArrayLib {
    function findIndex(uint[] storage arr, uint x) internal view returns (uint) {
        for (uint i = 0; i< arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    // 应用库函数
    using ArrayLib for uint[];
    uint[] public arr = [3, 2, 1];
    // 查找数字在数组中的索引
    function testFind() external view returns (uint i) {
        // return ArrayLib.find(arr, 2);
        return arr.findIndex(2);
    }
}
```

## 42. Hash 哈希函数

哈希算法特性

- 1.输入值相同，输出值一定相同

- 2.不管输入值有多大，输出值是定长的，不可逆

  通常用在签名的运算或获取一个特定的ID

abi.encode() 和 abi.encodePacked() 区别

- 后者不同的输入值可能造成相同的输出值，如('AAAA','BBB')和('AAA','ABBB')输出值相同，

  因为后者在运算结果时，没有给字符间隔补0。解决办法是给中间添加数字

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
    哈希算法特性
    1.输入值相同，输出值一定相同
    2.不管输入值有多大，输出值是定长的，不可逆
    通常用在签名的运算或获取一个特定的ID

    abi.encode() 和 abi.encodePacked() 区别
    后者不同的输入值可能造成相同的输出值，如('AAAA','BBB')和('AAA','ABBB')输出值相同，
    因为后者在运算结果时，没有给字符间隔补0。

    解决办法是给中间添加数字
 */
contract HashFunc {
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encode(text, num, addr));
    }

    function encode(string memory text1, string memory text2) external pure returns (bytes memory) {
        return abi.encode(text1, text2);
    }
    function encodePacked(string memory text1, string memory text2) external pure returns (bytes memory) {
        return abi.encodePacked(text1, text2);
    }

    // 解决函数
    function collision(string memory text1, uint x, string memory text2) external pure returns (byte32) {
        return keccak256(abi.encodePacked(arg);)
    }
}
```

## 43. Verify Sign 验证签名

步骤

- message to sign 消息签名
- hash(message) 将消息进行哈希值
- sign(hash(message), private key) | offchain 消息和私钥进行签名，线下完成
- ecrecover(hash(message), signature) == signer 恢复签名，如果签名地址等于想要的地址则正确

```solidity
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
    function verify(address _singer, string memory _message, bytes memory _sign) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMsgHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMsgHash, _sign) == _singer;
    }

    // 将消息进行哈希运算
    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }
    function getEthSignedMessageHash(bytes32 _msgHas) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _msgHas));
    }

    function recover(bytes32 _ethSignedMsgHash, bytes memory _sign) public pure returns (address) {
        // 非对称加密
        (bytes32 r, bytes32 s, uint8 v) = _split(_sign);
        return ecrecover(_ethSignedMsgHash, v, r, s);
    }

    function _split(bytes memory _sign) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sign.length == 65, "error sign length!");
        assembly {
            r := mload(add(_sign, 32))
            s := mload(add(_sign, 64))
            v := byte(0, mload(add(_sign, 96)))
        }
        return (r, s, v);
    }
 }
```

## 44. Access Control 权限控制

```solidity
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
```

## 45. selfdestruct 自毁合约

通过调用自毁合约方法，强制发送主币至调用合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * selfdestruct 自毁合约
 * - delete contract
 * - force send Ether to any address
 */
 contract Kill {

    constructor() payable{}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
 }

 contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    // 调用合约的自毁方法，将被调用合约的主币发送至此合约
    function kill(Kill _kill) external {
        _kill.kill();
    }
 }
```

## 46. Piggy Bank 小猪存钱罐

其他人可以发送主币，拥有者可以取出主币同时毁掉合约

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * PiggyBank 小猪存钱罐
 * 其他人可以发送主币，拥有者可以取出主币同时毁掉合约
 */
contract PiggyBank {

    // 收款数量事件
    event Deposit(uint amount);
    // 取款数量事件
    event Withdraw(uint amount);
    address public owner = msg.sender;

    // 接收主币
    receive() external payable {
        emit Deposit(msg.value);
    }
    // 提取主币
    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        // 自毁将主币发送给拥有者
        selfdestruct(payable(msg.sender));
    }
}
```

## 47. ERC20

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * 合约包含IERC20接口，代表满足标准
 */
interface IERC20 {
    /**
     * 当前合约的 token 总量
     */
    function totalSupply() external view returns (uint);

    /**
     * 某一个账户的当前余额
     */
    function balanceOf(address account) external view returns (uint);

    /**
     * 把账户中的余额，由调用者发送到另一个账户中，并向链外汇报事件
     */
    function transfer(address recipient, uint amount) external returns (bool);

    /**
     * 查询某账户向另一账户批准额度有多少
     */
    function allowance(address owner, address spender) external view returns (uint);

    /**
     * 把账户中的数量批准给另一个账户
     */
    function approve(address spender, uint amount) external returns (bool);

    /**
     * 向另一个合约存款的时候，另一个合约需要调用 transferFrom 把token拿到它的合约中
     */
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);

    event Approval(address indexed owner, address indexed spender, uint amount);

}

contract ERC20 is IERC20 {
    // 当前合约的token总量
    uint public totalSupply;
    // 账本映射
    mapping(address => uint) public balanceOf;
    // 批准映射
    mapping(address => mapping(address => uint)) public allowance;
    // token name
    string public name = "Test";
    string public symbol = "TEST";
    // token 精度
    uint8 public decimals = 18;

    /**
     * 把账户中的余额，由调用者发送到另一个账户中，并向链外汇报事件
     */
    function transfer(address recipient, uint amount) external returns (bool) {
        // 发送者减掉数量
        balanceOf[msg.sender] -= amount;
        // 接受者增加数量
        balanceOf[recipient] -= amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * 把账户中的数量批准给另一个账户
     */
    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * 向另一个合约存款的时候，另一个合约需要调用 transferFrom 把token拿到它的合约中
     */
    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    /**
     * 筑币方法
     */
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    /**
     * 销毁方法
     */
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
```

