// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IPoolManager} from "../interfaces/IPoolManager.sol";
import {Currency} from "../types/Currency.sol";

contract Router {
    IPoolManager public immutable poolManager;

    address private _msgSender;

    constructor(IPoolManager _poolManager) {
        poolManager = _poolManager;
    }

    /// @notice identity passthrough for hooks
    function getMsgSender() external view returns (address) {
        return _msgSender;
    }

    function swap(Currency currency, uint256 amount) external {
        _msgSender = msg.sender;

        poolManager.swap(currency, amount);

        _msgSender = address(0);
    }
}
