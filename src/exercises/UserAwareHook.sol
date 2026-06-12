// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IHooks} from "../interfaces/IHooks.sol";
import {PoolKey} from "../types/PoolKey.sol";

interface IRouter {
    function getMsgSender() external view returns (address);
}

contract UserAwareHook is IHooks {
    mapping(address => bool) public authorizedRouters;

    event UserDetected(address router, address user, uint256 amount);

    function authorizeRouter(address router) external {
        authorizedRouters[router] = true;
    }

    function beforeInitialize(PoolKey calldata, uint160) external override {}

    function afterInitialize(PoolKey calldata, uint160) external override {}

    function beforeSwap(address, uint256) external override {}

    function afterSwap(address sender, uint256 amount) external override {
        require(authorizedRouters[sender], "UNAUTHORIZED_ROUTER");

        address user = IRouter(sender).getMsgSender();

        emit UserDetected(sender, user, amount);
    }
}
