// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }
    
    function withdraw(uint256 amount) external{
        require(msg.sender == owner, "not owner");
        (bool sent,) = owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
    
    receive() external payable{}
}
