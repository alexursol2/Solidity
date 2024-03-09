// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ReentrancyGuard {
    // Count stores number of times the function func was called
    uint256 public count;
    bool private locked;

    modifier lock() {
        require(!locked, "locked");
        locked = true;
        _;
        locked = false;
    }

    function exec(address target) external lock {
        (bool ok,) = target.call("");
        require(ok, "call failed");
        count += 1;
    }
}
