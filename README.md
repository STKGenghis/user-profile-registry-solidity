# UserProfileRegistry Smart Contract

Solidity smart contract for registering, updating, and viewing user profiles on Ethereum.  
Built during **Dev3Pack x Lisk Summer Bootcamp (Week 1 Assignment 2)** using Remix IDE.

## 🚀 Quick Start

- Compile using Solidity 0.8.30
- Deploy in [Remix](https://remix.ethereum.org)
- Functions:
  - `createRegister(bytes name, uint8 age)`
  - `updateProfile(bytes name, uint8 age)`
  - `getProfile()`

## 🧪 Remix Testing

1. Deploy the contract
2. Call `createRegister(0x416c696365, 30)`
3. Call `getProfile()` to verify values
4. Try registering again — should revert
5. Call `updateProfile(...)` to change name/age
6. Call `getProfile()` again to confirm

## 📄 License

This project is licensed under the MIT License. See [`LICENSE`](./LICENSE) for details.

---

📚 For full explanation, test suite, and structure → see [`docs.md`](./docs.md)
