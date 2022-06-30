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