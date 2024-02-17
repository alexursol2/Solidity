// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SimpleStorage {
    string public text;
    
    function set(string memory _text) public{
        text = _text;
    }
    
    function get() external view returns(string memory){
        return text;
    }
}
