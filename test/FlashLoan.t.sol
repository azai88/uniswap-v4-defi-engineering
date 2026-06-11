// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "forge-std/Test.sol";

import "../src/exercises/PoolManager.sol";
import "../src/interfaces/IFlashLoanReceiver.sol";

contract MockReceiver is IFlashLoanReceiver {
    PoolManager poolManager;
    Currency currency;

    constructor(PoolManager _poolManager, Currency _currency) {
        poolManager = _poolManager;
        currency = _currency;
    }

    function executeOperation(bytes calldata) external {
        poolManager.settle(currency, address(this), 100);
    }
}

contract FlashLoanTest is Test {
    PoolManager poolManager;

    Currency weth = Currency.wrap(address(0x1234));

    function setUp() public {
        poolManager = new PoolManager();
    }

    function testFlashLoanRepaid() public {
        MockReceiver receiver = new MockReceiver(poolManager, weth);

        poolManager.flashLoan(weth, 100, address(receiver), "");

        int256 delta = poolManager.currencyDelta(address(receiver), weth);

        assertEq(delta, 0);
    }
}
