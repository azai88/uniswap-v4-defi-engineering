// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Currency} from "../types/Currency.sol";
import {IFlashLoanReceiver} from "../interfaces/IFlashLoanReceiver.sol";
import {IHooks} from "../interfaces/IHooks.sol";
import {PoolKey} from "../types/PoolKey.sol";
import {Hooks} from "./libraries/Hooks.sol";

contract PoolManager {
    mapping(address => mapping(Currency => int256)) internal deltas;
    mapping(bytes32 => bool) public pools;

    IHooks public hook;

    event Unlock(address indexed caller);

    event FlashLoan(address indexed borrower, address indexed receiver, uint256 amount);

    event SwapExecuted(address indexed sender, uint256 amount);
    event PoolInitialized(bytes32 indexed poolId, address currency0, address currency1);

    constructor() {}

    function setHook(IHooks _hook) external {
        hook = _hook;
    }

    function initialize(PoolKey memory key, uint160 sqrtPriceX96) external {
        if (address(key.hooks) != address(0)) {
            key.hooks.beforeInitialize(key, sqrtPriceX96);
        }

        bytes32 poolId = keccak256(abi.encode(key.currency0, key.currency1, key.fee, key.tickSpacing, key.hooks));

        pools[poolId] = true;

        if (address(key.hooks) != address(0)) {
            key.hooks.afterInitialize(key, sqrtPriceX96);
        }
    }

    function unlock(bytes calldata data) external returns (bytes memory) {
        emit Unlock(msg.sender);

        return data;
    }

    function currencyDelta(address target, Currency currency) external view returns (int256) {
        return deltas[target][currency];
    }

    function take(Currency currency, address recipient, uint256 amount) external {
        deltas[recipient][currency] -= int256(amount);
    }

    function settle(Currency currency, address account, uint256 amount) external {
        deltas[account][currency] += int256(amount);
    }

    function isSettled(address account, Currency currency) public view returns (bool) {
        return deltas[account][currency] == 0;
    }

    function flashLoan(Currency currency, uint256 amount, address receiver, bytes calldata data) external {
        deltas[receiver][currency] -= int256(amount);

        emit FlashLoan(msg.sender, receiver, amount);

        IFlashLoanReceiver(receiver).executeOperation(data);

        require(deltas[receiver][currency] >= 0, "FLASH_LOAN_NOT_REPAID");
    }

    function swap(Currency currency, uint256 amount) external {
        if (address(hook) != address(0)) {
            if (Hooks.hasPermission(address(hook), Hooks.BEFORE_SWAP_FLAG)) {
                hook.beforeSwap(msg.sender, amount);
            }
        }

        deltas[msg.sender][currency] -= int256(amount);

        emit SwapExecuted(msg.sender, amount);

        if (address(hook) != address(0)) {
            if (Hooks.hasPermission(address(hook), Hooks.AFTER_SWAP_FLAG)) {
                hook.afterSwap(msg.sender, amount);
            }
        }
    }
}
