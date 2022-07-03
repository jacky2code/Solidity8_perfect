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



## 14. 构造函数

构造函数：只在合约部署的时候调用一次，之后不再调用

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * Constructor 
 * - 构造函数：只在合约部署的时候调用一次，之后不再调用
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

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * Ownable 权限管理合约 
 * 重新设置合约拥有者
 * 只有合约拥有者能调用的函数
 * 其他人可以调用的函数
 */
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    // 设置新的所有者
    function setNewOwner(address _newOwner) external onlyOwner {
        // 不可以是 0 地址
        require(_newOwner != address(0), "address invalid");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() external onlyOwner {

    }

    function anyOneCanCallThisFunc() external {

    }
}
```



## 16. 函数返回值

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 函数返回值
 */
contract FunctionOutputs {
    function returnManay() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    // 隐式返回
    function namedAssigned() public pure returns (uint x, bool b) {
        x = 1;
        b = false;
    }

    // 获取返回值
    function destructingAssigments() public pure {
        (uint x, bool b) = returnManay();
        // 只取一个返回值
        (, bool c) = returnManay();

        x = x + 1;
        if(b)
        {
            x = x * 1;
        }
        if(c)
        {
            x = x * 2;
        }
    }
}
```



## 17. 数组

dynamic or fixed size 动态数组或者固定长度数组

 * Initialization
 * Insert(push), get, update, delete, pop, length
 * Creating array in memory
 * Returning array from function

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 数组
 * - dynamic or fixed size 动态数组或者固定长度数组
 * Initialization
 * Insert(push), get, update, delete, pop, length
 * Creating array in memory
 * Returning array from function
 */
contract Array {
    uint[] public nums = [1, 2, 3];
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

        // create array in memory
        uint[] memory a = new uint[](5);    
        // 内存中只能定义定长数组，根据索引赋值。
        a[1] = 123;
    }

    // 返回数组所有内容，内存类型
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}
```



## 18. * 删除数组元素通过移位/替换

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
  // SPDX-License-Identifier: GPL-3.0
  pragma solidity >=0.8.7 <0.9.0;
  
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
          require(_index < arr.length, "index out of bound!");
          for (uint i = _index; i < arr.length; i++) {
              arr[i] = arr[i + 1];
          }
          arr.pop();
      }
  
      // 实现方法二：比较少消耗gas，但是顺序打乱了
      // 实现思路：把要删除的数据用最后一个数据替换，最后再pop掉最后一个数据
      // [1, 2, 3, 4] --> removeNew(1) --> [1, 4, 3, 4] --> [1, 4, 3]
      function removeNew(uint _index) public {
          require(_index < arr.length, "index out of bound!");
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

   
## 19. 映射
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



## 20. 迭代映射

``` solidity
// SPDX-License-Identifier: GPL-2.0
pragma solidity >=0.8.7 <0.9.0;

/**
 *   IterableMapping
 */
contract IterableMapping {
    // 余额
    mapping(address => uint256) public balances;
    // 某地址是否存在映射中
    mapping(address => bool) public inserted;
    // 所有存在地址
    address[] public keys;

    /** 添加地址 */
    function set(address _key, uint256 _val) external {
        // 给地址赋值余额
        balances[_key] = _val;
        // 判断地址是否在映射中
        if (!inserted[_key]) {
            // 添加映射
            inserted[_key] = true;
            // 添加存在地址
            keys.push(_key);
        }
    }

    /** 获取地址数组长度 */
    function getSize() external view returns (uint256) {
        return keys.length;
    }

    /** 获取第一个地址余额 */
    function getFirstAddressBal() external view returns (uint256) {
        return balances[keys[0]];
    }

    /** 获取最后一个地址的余额 */
    function getLastAddressBal() external view returns (uint256) {
        return balances[keys[keys.length - 1]];
    }

    /** 获取任意位置地址的余额 */
    function getAddressBalAtIndex(uint256 _index)
        external
        view
        returns (uint256)
    {
        return balances[keys[_index]];
    }

    /** 遍历所有地址余额，getSize +  getAddressBalAtIndex 结合使用 */
}
```



## 21. Structs 结构体

``` solidity
// SPDX-License-Identifier: GPL-2.0
pragma solidity >=0.8.7 <0.9.0;

/**
 *   Structs
 */
contract Structs {
    struct Car {
        string model;
        uint256 year;
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
        Car memory et7 = Car({model: "NIO ET7", year: 2022, owner: msg.sender});
        Car memory es8;
        es8.model = "NIO ES8";
        es8.year = 2019;
        es8.owner = msg.sender;

        cars.push(ec6);
        cars.push(et7);
        cars.push(es8);

        Car memory _car = cars[0];
        _car.year;

        Car storage _carModify = cars[0];
        _carModify.year = 2020;
        delete _carModify.owner;

        delete cars[1];
    }
}
```



## 22. 枚举 enum

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 枚举
 */
contract Enum {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
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



## 24. 数据存储位置

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

/**
 * 数据存储位置
 * - storage, memory and calldata(只用于输入参数)
 */
contract DataLocations {
    struct MyStruct {
        uint256 foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint256[] calldata y)
        external
        returns (uint256[] memory)
    {
        myStructs[msg.sender] = MyStruct(123, "bar");

        MyStruct storage myStruct = myStructs[msg.sender];
        // 修改后，状态变量的值随之改变
        myStruct.text = "newBar";

        MyStruct memory myStructMem = myStructs[msg.sender];
        // 修改后，状态变量不改变，只不过是局部变量myStructMem改变，并随着函数执行完而从内存中消失
        myStructMem.foo = 235;

        _internal(y);

        uint256[] memory memArr = new uint256[](3);
        memArr[0] = 345;
        return memArr;
    }

    function _internal(uint256[] calldata y) private pure {
        uint256 x = y[0];
        x++;
    }
}
```



## 25. 简单存储

``` solidity
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
```



## 26. 待办事项列表

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7;

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

## 27. 事件

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

/**
 * 事件：记录当前智能合约运行状态
 * 时间存储更节约gas
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

## 28. 继承

``` solidity
// SPDX-License-Identifier: GPL-3.0
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

## 29. 继承,构造函数传参

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 2 ways to call parent constructors
// Order of initialization

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 继承后向构造函数传参
contract U is S("s"), T("t") {

}

contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {
        
    }
}
```

## 30. 可视范围

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// visibility
// private - only inside contract
// internal - only inside contract and child contracts
// public - inside and outside contract
// external - only from outside contract

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

        // 外部函数可以使用this关键字访问，比较浪费gas
        this.externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        y + z;

        internalFunc();
        publicFunc();
    }
}
```

## 31. immutable

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 必须部署的时候赋值
contract Immutable {
    // 45718 gass
    // address public owner = msg.sender;

    // 43585 gas 使用 immutable 关键字更节省gas
    // address public immutable owner = msg.sender;

    address public immutable owner;

    // 构造函数赋值
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

## 32. payable

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 向合约发送主币
contract Payable {
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

## 33. fallback

```solidity
// SPDX-License-Identifier: GPL-3.0
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

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
 }
```

## 34. sentETH

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 3 ways to send ETH
// transfer - 2300 gas, reverts
// send - 2300 gas, returns bool
// call - all gas, returns bool and data

contract SendETH {
    constructor() payable {}
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
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {

    }

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);       
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
```

