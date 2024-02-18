// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// You know what functions you can call, so you define an interface to TestInterface.
interface ITestInterface {
    function count() external view returns (uint256);
    function inc() external;
    function dec() external;
}

// Contract that uses TestInterface interface to call TestInterface contract
contract CallInterface {
    function examples(address test) external {
        ITestInterface(test).inc();
        uint256 count = ITestInterface(test).count();
    }

    function dec(address test) external {
        ITestInterface(test).dec();
    }
}
