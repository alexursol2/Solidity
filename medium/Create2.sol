// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {DeployWithCreate2} from "sce/sol/DeployWithCreate2.sol";

contract Create2Factory {
    function deploy(uint256 salt) external returns (address) {
        DeployWithCreate2 con = new DeployWithCreate2{
            salt: bytes32(salt)
        }(msg.sender);
        return address(con);
    }
}
