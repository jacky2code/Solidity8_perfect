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

// 调用腹肌合约的函数
