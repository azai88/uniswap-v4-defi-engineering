// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import "forge-std/Test.sol";
import "../src/exercises/Router.sol";

contract RouterTest is Test {
    Router router;

    function setUp() public {
        router = new Router(address(this));
    }

    function testRouterDeployment() public {
        assertTrue(address(router) != address(0));
    }
}
