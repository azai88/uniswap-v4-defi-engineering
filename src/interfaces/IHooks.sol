// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

interface IHooks {
    function beforeSwap(address sender, uint256 amount) external;

    function afterSwap(address sender, uint256 amount) external;
}
