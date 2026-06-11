// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "forge-std/Test.sol";

import "../src/exercises/PoolManager.sol";
import "../src/exercises/SimpleHook.sol";
import "../src/interfaces/IHooks.sol";
import "../src/types/Currency.sol";

contract HooksTest is Test {
    PoolManager poolManager;
    SimpleHook hook;

    Currency weth = Currency.wrap(address(0x1111));

    function setUp() public {
        hook = new SimpleHook();

        poolManager = new PoolManager();

        poolManager.setHook(IHooks(address(hook)));
    }

    function testHookDeployment() public {
        assertTrue(address(hook) != address(0));
    }

    function testSwapCreatesDelta() public {
        poolManager.swap(weth, 100);

        int256 delta = poolManager.currencyDelta(address(this), weth);

        assertEq(delta, -100);
    }

    function testHookConfigured() public {
        assertEq(address(poolManager.hook()), address(hook));
    }
}
