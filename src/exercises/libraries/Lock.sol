// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library Lock {
    uint256 internal constant SLOT = 0;

    function unlock() internal {
        assembly {
            tstore(SLOT, 1)
        }
    }

    function lock() internal {
        assembly {
            tstore(SLOT, 0)
        }
    }

    function isUnlocked() internal view returns (bool unlocked) {
        assembly {
            unlocked := tload(SLOT)
        }
    }
}
