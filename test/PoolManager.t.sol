// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "forge-std/Test.sol";
import "../src/exercises/PoolManager.sol";

contract PoolManagerTest is Test {
    PoolManager poolManager;

    address user = address(1);

    Currency weth = Currency.wrap(0x0000000000000000000000000000000000000001);

    function setUp() public {
        poolManager = new PoolManager();
    }

    function testSettleCreatesCredit() public {
        poolManager.settle(weth, user, 100);

        int256 delta = poolManager.currencyDelta(user, weth);

        assertEq(delta, 100);
    }

    function testTakeCreatesDebt() public {
        poolManager.take(weth, user, 50);

        int256 delta = poolManager.currencyDelta(user, weth);

        assertEq(delta, -50);
    }

    function testAccountStartsSettled() public {
        bool settled = poolManager.isSettled(user, weth);

        assertTrue(settled);
    }

    function testAccountBecomesUnsettled() public {
        poolManager.take(weth, user, 100);

        bool settled = poolManager.isSettled(user, weth);

        assertFalse(settled);
    }

    function testAccountSettlesBackToZero() public {
        poolManager.take(weth, user, 100);

        poolManager.settle(weth, user, 100);

        bool settled = poolManager.isSettled(user, weth);

        assertTrue(settled);
    }
}
