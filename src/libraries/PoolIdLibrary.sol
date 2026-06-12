// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {PoolKey} from "../types/PoolKey.sol";
import {PoolId} from "../types/PoolId.sol";

library PoolIdLibrary {
    function toId(PoolKey memory key) internal pure returns (PoolId) {
        return
            PoolId.wrap(
                keccak256(
                    abi.encode(
                        key.currency0,
                        key.currency1,
                        key.fee,
                        key.tickSpacing,
                        key.hooks
                    )
                )
            );
    }
}
