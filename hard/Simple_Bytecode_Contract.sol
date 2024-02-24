// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Factory {
    event Log(address addr);

    function deploy() external returns (address addr) {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        assembly {
            // Deploy contract with bytecode loaded in the memory
            // create(value, offset, size)
            addr := create(0, add(bytecode, 0x20), 0x16)
        }
        require(addr != address(0));

        emit Log(addr);
    }
}
