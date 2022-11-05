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