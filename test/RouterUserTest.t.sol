// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "forge-std/Test.sol";

import {PoolManager} from "../src/exercises/PoolManager.sol";
import {Router} from "../src/exercises/Router.sol";
import {UserAwareHook} from "../src/exercises/UserAwareHook.sol";
import {IHooks} from "../src/interfaces/IHooks.sol";
import {IPoolManager} from "../src/interfaces/IPoolManager.sol";
import {Currency} from "../src/types/Currency.sol";

contract RouterUserTest is Test {
    PoolManager poolManager;
    UserAwareHook hook;

    Currency weth = Currency.wrap(address(0x1234));

    function setUp() public {
        poolManager = new PoolManager();

        hook = new UserAwareHook();

        poolManager.setHook(IHooks(address(hook)));
    }

    function testUserIsRecoveredFromHook() public {
        Router router = new Router(IPoolManager(address(poolManager)));

        hook.authorizeRouter(address(router));

        vm.prank(address(0xBEEF));

        router.swap(weth, 100);
    }
}
