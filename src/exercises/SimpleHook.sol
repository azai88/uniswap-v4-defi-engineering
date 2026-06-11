// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {IHooks} from "../interfaces/IHooks.sol";

contract SimpleHook is IHooks {
    event BeforeSwap(address sender, uint256 amount);

    event AfterSwap(address sender, uint256 amount);

    function beforeSwap(address sender, uint256 amount) external {
        emit BeforeSwap(sender, amount);
    }

    function afterSwap(address sender, uint256 amount) external {
        emit AfterSwap(sender, amount);
    }
}
