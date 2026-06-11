// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Currency} from "../types/Currency.sol";
import {IFlashLoanReceiver} from "../interfaces/IFlashLoanReceiver.sol";

contract PoolManager {
    mapping(address => mapping(Currency => int256)) internal deltas;

    event Unlock(address indexed caller);

    event FlashLoan(address indexed borrower, address indexed receiver, uint256 amount);

    function unlock(bytes calldata data) external returns (bytes memory) {
        emit Unlock(msg.sender);
        return data;
    }

    function currencyDelta(address target, Currency currency) external view returns (int256) {
        return deltas[target][currency];
    }

    function take(Currency currency, address recipient, uint256 amount) external {
        deltas[recipient][currency] -= int256(amount);
    }

    function settle(Currency currency, address account, uint256 amount) external {
        deltas[account][currency] += int256(amount);
    }

    function isSettled(address account, Currency currency) public view returns (bool) {
        return deltas[account][currency] == 0;
    }

    function flashLoan(Currency currency, uint256 amount, address receiver, bytes calldata data) external {
        deltas[receiver][currency] -= int256(amount);

        emit FlashLoan(msg.sender, receiver, amount);

        IFlashLoanReceiver(receiver).executeOperation(data);

        require(deltas[receiver][currency] >= 0, "FLASH_LOAN_NOT_REPAID");
    }
}
