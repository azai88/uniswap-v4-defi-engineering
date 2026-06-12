// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {PoolKey} from "../types/PoolKey.sol";

interface IHooks {
    function beforeInitialize(
        PoolKey calldata key,
        uint160 sqrtPriceX96
    ) external;

    function afterInitialize(
        PoolKey calldata key,
        uint160 sqrtPriceX96
    ) external;

    function beforeSwap(address sender, uint256 amount) external;

    function afterSwap(address sender, uint256 amount) external;
}
