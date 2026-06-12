// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IHooks} from "../interfaces/IHooks.sol";
import {PoolKey} from "../types/PoolKey.sol";

contract LimitOrderHook is IHooks {
    struct LimitOrder {
        address user;
        uint256 targetPrice;
        uint256 amount;
        bool isBuy;
        bool executed;
    }

    LimitOrder[] public orders;

    uint256 public currentPrice;

    event BeforeInitialize();
    event AfterInitialize();

    event BeforeSwap(address sender, uint256 amount);
    event AfterSwap(address sender, uint256 amount);

    event LimitOrderCreated(address indexed user, uint256 targetPrice, uint256 amount, bool isBuy);

    event LimitOrderExecuted(address indexed user, uint256 executionPrice, uint256 amount, bool isBuy);

    function placeOrder(uint256 targetPrice, uint256 amount, bool isBuy) external {
        orders.push(
            LimitOrder({user: msg.sender, targetPrice: targetPrice, amount: amount, isBuy: isBuy, executed: false})
        );

        emit LimitOrderCreated(msg.sender, targetPrice, amount, isBuy);
    }

    function setPrice(uint256 price) external {
        currentPrice = price;
    }

    function getOrdersCount() external view returns (uint256) {
        return orders.length;
    }

    function beforeInitialize(PoolKey calldata, uint160) external override {
        emit BeforeInitialize();
    }

    function afterInitialize(PoolKey calldata, uint160) external override {
        emit AfterInitialize();
    }

    function beforeSwap(address sender, uint256 amount) external override {
        emit BeforeSwap(sender, amount);
    }

    function afterSwap(address sender, uint256 amount) external override {
        emit AfterSwap(sender, amount);

        for (uint256 i = 0; i < orders.length; i++) {
            if (orders[i].executed) {
                continue;
            }

            // BUY LIMIT
            if (orders[i].isBuy && currentPrice <= orders[i].targetPrice) {
                orders[i].executed = true;

                emit LimitOrderExecuted(orders[i].user, currentPrice, orders[i].amount, true);
            }

            // SELL LIMIT
            if (!orders[i].isBuy && currentPrice >= orders[i].targetPrice) {
                orders[i].executed = true;

                emit LimitOrderExecuted(orders[i].user, currentPrice, orders[i].amount, false);
            }
        }

        sender;
        amount;
    }
}
