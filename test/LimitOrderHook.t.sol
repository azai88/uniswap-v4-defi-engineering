// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "forge-std/Test.sol";

import {LimitOrderHook} from "../src/exercises/LimitOrderHook.sol";

contract LimitOrderHookTest is Test {
    LimitOrderHook hook;

    function setUp() public {
        hook = new LimitOrderHook();
    }

    function testCreateBuyOrder() public {
        hook.createOrder(4000, 1 ether, true);

        (address user, uint256 targetPrice,, bool isBuyOrder, bool executed) = hook.orders(0);

        assertEq(user, address(this));
        assertEq(targetPrice, 4000);
        assertTrue(isBuyOrder);
        assertFalse(executed);
    }

    function testCreateSellOrder() public {
        hook.createOrder(5000, 1 ether, false);

        (, uint256 targetPrice,, bool isBuyOrder, bool executed) = hook.orders(0);

        assertEq(targetPrice, 5000);
        assertFalse(isBuyOrder);
        assertFalse(executed);
    }

    function testPriceStorage() public {
        hook.setPrice(4500);

        assertEq(hook.currentPrice(), 4500);
    }
}
