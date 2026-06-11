// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {PoolKey} from "./PoolKey.sol";

struct PathKey {
    PoolKey poolKey;
    bool zeroForOne;
}
