// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "sce/sol/IERC20.sol";

contract Vault {
    IERC20 public immutable token;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;


    constructor(address _token) {
        token = IERC20(_token);
    }

    function _mint(address to, uint256 shares) private {
        totalSupply += shares;
        balanceOf[to] += shares;
    }

    function _burn(address from, uint256 shares) private {
        totalSupply -= shares;
        balanceOf[from] -= shares;
    }

    function deposit(uint256 amount) external {
        uint256 shares;
        if (totalSupply == 0) {
            shares = amount;
        } else {
            shares = (amount * totalSupply) / token.balanceOf(address(this));
        }
    
        _mint(msg.sender, shares);
        token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 shares) external {
        uint256 amount = (token.balanceOf(address(this)) * shares) / totalSupply;
        _burn(msg.sender, shares);
        token.transfer(msg.sender, amount);
    }
}
