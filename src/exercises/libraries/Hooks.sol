// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

library Hooks {
    uint160 internal constant ALL_HOOK_MASK = uint160((1 << 14) - 1);

    uint160 internal constant BEFORE_INITIALIZE_FLAG = 1 << 13;
    uint160 internal constant AFTER_INITIALIZE_FLAG = 1 << 12;

    uint160 internal constant BEFORE_SWAP_FLAG = 1 << 7;
    uint160 internal constant AFTER_SWAP_FLAG = 1 << 6;

    function hasPermission(address hook, uint160 flag) internal pure returns (bool) {
        return uint160(hook) & flag != 0;
    }
}
