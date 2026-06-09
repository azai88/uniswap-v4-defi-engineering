// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

interface IPoolManager {
    function unlock(bytes calldata data) external returns (bytes memory);
}
