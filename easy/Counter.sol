// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Counter {
    uint256 public count;
    
    function inc() external{
        count++;
    }
    
    function dec() external{
        count--;
    }
}
