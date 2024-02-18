// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Event {
    event Log(string message, uint256 val);
    event Message(address indexed from, address indexed to, string message);
    event IndexedLog(address indexed sender, uint256 val);

    function examples() external {
        emit Log("Foo", 123);
        emit IndexedLog(msg.sender, 123);
    }
    
    function sendMessage(address addr, string memory message) external {
        emit Message(msg.sender, addr, message);
    }
}
