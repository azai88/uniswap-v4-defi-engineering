// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IHooks} from "../interfaces/IHooks.sol";
import {PoolKey} from "../types/PoolKey.sol";

contract SimpleHook is IHooks {
    event BeforeInitialize();
    event AfterInitialize();

    event BeforeSwap(address sender, uint256 amount);
    event AfterSwap(address sender, uint256 amount);

    function beforeInitialize(PoolKey calldata, uint160) external {
        emit BeforeInitialize();
    }

    function afterInitialize(PoolKey calldata, uint160) external {
        emit AfterInitialize();
    }

    function beforeSwap(address sender, uint256 amount) external {
        emit BeforeSwap(sender, amount);
    }

    function afterSwap(address sender, uint256 amount) external {
        emit AfterSwap(sender, amount);
    }
}
