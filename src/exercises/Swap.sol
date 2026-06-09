// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IPoolManager, SwapParams} from "../interfaces/IPoolManager.sol";
import {IUnlockCallback} from "../interfaces/IUnlockCallback.sol";
import {PoolKey} from "../types/PoolKey.sol";
import {BalanceDelta, BalanceDeltaLibrary} from "../types/BalanceDelta.sol";

contract Swap is IUnlockCallback {
    IPoolManager public immutable poolManager;

    constructor(IPoolManager _poolManager) {
        poolManager = _poolManager;
    }

    struct SwapExactInputSingleHop {
        PoolKey key;
        SwapParams swapParams;
        uint128 amountOutMin;
    }

    function swap(SwapExactInputSingleHop calldata params) external payable {
        bytes memory data = abi.encode(params);
        poolManager.unlock(data);
    }

    function unlockCallback(bytes calldata data) external returns (bytes memory) {
        require(msg.sender == address(poolManager), "NOT_POOL_MANAGER");

        SwapExactInputSingleHop memory params = abi.decode(data, (SwapExactInputSingleHop));

        BalanceDelta delta = poolManager.swap(params.key, params.swapParams, "");

        int128 amountOut = BalanceDeltaLibrary.amount1(delta);

        require(amountOut >= int128(uint128(params.amountOutMin)), "SLIPPAGE_TOO_HIGH");

        return "";
    }
}
