// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract LocalVariables {
    function localVars() external {
        uint256 u = 123;
        bool b = true;
    }
    
    function mul() external pure returns(uint256){
        uint256 x = 123456;
        return x * x;
    }
}
