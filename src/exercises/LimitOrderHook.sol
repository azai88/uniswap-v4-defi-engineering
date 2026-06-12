// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IHooks} from "../interfaces/IHooks.sol";
import {PoolKey} from "../types/PoolKey.sol";

contract LimitOrderHook is IHooks {
    struct LimitOrder {
        address user;
        uint256 targetPrice;
        uint256 amount;
        bool isBuyOrder;
        bool executed;
    }

    uint256 public currentPrice;

    uint256 public nextOrderId;

    mapping(uint256 => LimitOrder) public orders;

    event OrderCreated(
        uint256 indexed orderId, address indexed user, uint256 targetPrice, uint256 amount, bool isBuyOrder
    );

    event OrderExecuted(uint256 indexed orderId, address indexed user);

    function createOrder(uint256 targetPrice, uint256 amount, bool isBuyOrder) external {
        orders[nextOrderId] = LimitOrder({
            user: msg.sender, targetPrice: targetPrice, amount: amount, isBuyOrder: isBuyOrder, executed: false
        });

        emit OrderCreated(nextOrderId, msg.sender, targetPrice, amount, isBuyOrder);

        nextOrderId++;
    }

    function setPrice(uint256 newPrice) external {
        currentPrice = newPrice;
    }

    function executeOrders() internal {
        for (uint256 i = 0; i < nextOrderId; i++) {
            LimitOrder storage order = orders[i];

            if (order.executed) {
                continue;
            }

            bool triggerBuy = order.isBuyOrder && currentPrice <= order.targetPrice;

            bool triggerSell = !order.isBuyOrder && currentPrice >= order.targetPrice;

            if (triggerBuy || triggerSell) {
                order.executed = true;

                emit OrderExecuted(i, order.user);
            }
        }
    }

    function beforeInitialize(PoolKey calldata, uint160) external override {}

    function afterInitialize(PoolKey calldata, uint160) external override {}

    function beforeSwap(address, uint256) external override {}

    function afterSwap(address, uint256) external override {
        executeOrders();
    }
}
