// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {PoolKey} from "../types/PoolKey.sol";
import {IHooks} from "../interfaces/IHooks.sol";

contract CounterHook is IHooks {
    // poolId => functionName => count
    mapping(bytes32 => mapping(bytes4 => uint256)) public counts;

    // selector identifiers (simulan nombres de hook)
    bytes4 internal constant BEFORE_SWAP = bytes4(keccak256("beforeSwap"));
    bytes4 internal constant AFTER_SWAP = bytes4(keccak256("afterSwap"));
    bytes4 internal constant BEFORE_INIT = bytes4(keccak256("beforeInitialize"));
    bytes4 internal constant AFTER_INIT = bytes4(keccak256("afterInitialize"));

    // -----------------------------
    // TASK 1: permissions (simplified for our framework)
    // -----------------------------
    function getHookPermissions() public pure returns (bool, bool, bool, bool) {
        // (beforeAddLiquidity, beforeRemoveLiquidity, beforeSwap, afterSwap)
        return (false, false, true, true);
    }

    // -----------------------------
    // TASK 2: hook logic
    // -----------------------------

    function beforeInitialize(PoolKey calldata key, uint160) external override {
        bytes32 id = keccak256(abi.encode(key));
        counts[id][BEFORE_INIT]++;
    }

    function afterInitialize(PoolKey calldata key, uint160) external override {
        bytes32 id = keccak256(abi.encode(key));
        counts[id][AFTER_INIT]++;
    }

    function beforeSwap(address, uint256) external override {
        // NOTE: no PoolKey passed in your simplified framework
        // so we cannot index per pool here safely
    }

    function afterSwap(address sender, uint256 amount) external override {
        // simplified poolId derivation (based on sender context)
        bytes32 id = keccak256(abi.encode(sender, amount));

        counts[id][AFTER_SWAP]++;

        // optional trace event
    }
}
