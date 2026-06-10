// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Currency} from "../types/Currency.sol";

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
}
