// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "forge-std/Test.sol";

import {Router} from "../src/exercises/Router.sol";
import {IPoolManager} from "../src/interfaces/IPoolManager.sol";
import {Currency} from "../src/types/Currency.sol";

contract RouterTest is Test, IPoolManager {
    Router router;

    function setUp() public {
        router = new Router(IPoolManager(address(this)));
    }

    function testRouterDeployment() public {
        assertTrue(address(router) != address(0));
    }

    // ========= Mock PoolManager =========

    function swap(Currency, uint256) external override {}

    function unlock(bytes calldata) external pure override returns (bytes memory) {
        return "";
    }

    function currencyDelta(address, Currency) external pure override returns (int256) {
        return 0;
    }

    function take(Currency, address, uint256) external override {}

    function settle(Currency, address, uint256) external override {}
}
