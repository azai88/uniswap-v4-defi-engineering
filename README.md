# Uniswap v4 DeFi Engineering

Educational and engineering-focused implementation of Uniswap v4 concepts using Foundry.

This repository documents my journey building and understanding the core architecture behind Uniswap v4, including PoolManager, Flash Accounting, Account Deltas, Balance Deltas, Flash Loans, Settlement Flows, and Router development.

---

## Objectives

- Understand Uniswap v4 architecture
- Build a simplified PoolManager
- Implement Flash Accounting
- Work with AccountDelta and BalanceDelta
- Implement unlock/callback patterns
- Build swap routers
- Execute flash loans
- Learn EIP-1153 transient storage
- Develop professional Solidity and DeFi engineering skills

---

## Tech Stack

- Solidity
- Foundry
- Ethereum Virtual Machine (EVM)
- Uniswap v4 Concepts
- DeFi Protocol Engineering
- Git & GitHub

---

## Learning Modules

### Core Architecture

- Singleton Architecture
- PoolManager
- Routers
- Unlock Pattern
- Callback Pattern

### Flash Accounting

- Currency Deltas
- Account Tracking
- Debt Settlement
- Credit Settlement

### BalanceDelta

- Bit Packing
- int128
- int256
- Gas Optimization

### Sync & Settle

- CurrencyReserves
- Transient Storage
- EIP-1153
- Settlement Flows

### Flash Loans

- Borrowing with take()
- Repayment with settle()
- Delta Resolution

### Swaps

- Swap Execution
- Pool Accounting
- Router Integration

---

## Project Structure

```text
src/
├── exercises/
├── solutions/
├── interfaces/
├── libraries/
└── types/

test/

script/

docs/
```

---

## Commands

### Build

```bash
forge build
```

### Run Tests

```bash
forge test -vv
```

### Format Code

```bash
forge fmt
```

### Gas Report

```bash
forge snapshot
```

### Start Local Node

```bash
anvil
```

---

## Current Progress

- [x] Project bootstrap
- [x] Router skeleton
- [x] BalanceDelta implementation
- [x] Currency type implementation
- [x] PoolKey implementation
- [x] Lock library implementation
- [ ] Simplified PoolManager
- [ ] Flash Accounting Engine
- [ ] Flash Loan Exercise
- [ ] Swap Router
- [ ] Settlement Engine
- [ ] Full Uniswap v4 Simulation

---

## Author

William Perez

Blockchain Developer | Solidity | Foundry | DeFi | Cybersecurity | Smart Contract Engineering

GitHub:
https://github.com/azai88
