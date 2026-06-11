// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Currency} from "../types/Currency.sol";
import {PoolKey} from "../types/PoolKey.sol";
import {BalanceDelta} from "../types/BalanceDelta.sol";

struct SwapParams {
    bool zeroForOne;
    int256 amountSpecified;
    uint160 sqrtPriceLimitX96;
}

interface IPoolManager {
    function unlock(bytes calldata data) external returns (bytes memory);

    function currencyDelta(
        address target,
        Currency currency
    ) external view returns (int256);

    function swap(
        PoolKey calldata key,
        SwapParams calldata params,
        bytes calldata hookData
    ) external returns (BalanceDelta);

    function take(Currency currency, address to, uint256 amount) external;

    function settle() external payable;

    function sync(Currency currency) external;
}
