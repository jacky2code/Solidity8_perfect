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