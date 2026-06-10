// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IPoolManager} from "../interfaces/IPoolManager.sol";
import {Currency} from "../types/Currency.sol";

contract Reader {
    IPoolManager public immutable poolManager;

    constructor(IPoolManager _poolManager) {
        poolManager = _poolManager;
    }

    function getCurrencyDelta(address target, address currency) public view returns (int256) {
        return poolManager.currencyDelta(target, Currency.wrap(currency));
    }
}
