// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

interface IPoolManager {
    function unlock(bytes calldata data) external returns (bytes memory);
}

interface IUnlockCallback {
    function unlockCallback(
        bytes calldata data
    ) external returns (bytes memory);
}

contract Router is IUnlockCallback {
    error NotPoolManager();

    IPoolManager public immutable poolManager;

    constructor(address _poolManager) {
        poolManager = IPoolManager(_poolManager);
    }

    modifier onlyPoolManager() {
        if (msg.sender != address(poolManager)) {
            revert NotPoolManager();
        }
        _;
    }

    function unlock(bytes calldata data) external {
        poolManager.unlock(data);
    }

    function unlockCallback(
        bytes calldata data
    ) external onlyPoolManager returns (bytes memory) {
        return data;
    }
}
