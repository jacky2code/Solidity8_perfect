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