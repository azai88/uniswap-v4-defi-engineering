// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

interface IFlashLoanReceiver {
    function executeOperation(bytes calldata data) external;
}
