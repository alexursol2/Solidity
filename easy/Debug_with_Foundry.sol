// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {console} from "forge-std/Test.sol";

contract Token {
    mapping(address => uint256) public balances;

    constructor() {
        balances[msg.sender] = 100;
    }

    function transfer(address to, uint256 amount) external {
        balances[msg.sender] -= amount;
        balances[to] += amount;
        console.log("transfer", msg.sender, to, amount);
    }
}
