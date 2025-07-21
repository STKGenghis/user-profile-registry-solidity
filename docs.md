# 📘 Detailed Documentation – UserProfileRegistry

## What Is This?

`UserProfileRegistry` is a smart contract written in Solidity for managing user profiles on the Ethereum blockchain.  
Users can register themselves, update their profiles, and view their data, all while ensuring gas efficiency and basic validation.

---

## ⚙️ Smart Contract Overview

### 🧱 `struct User`
```solidity
struct User {
  bytes name;
  uint8 age;
  uint32 registeredAt;
}
Mappings
mapping(address => User) users

mapping(address => bool) isRegistered

These store the profile data and registration status per Ethereum address.

🔧 Functions
createRegister(bytes calldata _name, uint8 _age)
Registers a new user — only once per address.

updateProfile(bytes calldata _name, uint8 _age)
Updates the user's name and age (must already be registered).

getProfile() external view returns (bytes memory, uint8, uint32)
Returns the caller’s name, age, and registration timestamp.

🧪 Remix Test Guide
Compile & Deploy
Use Solidity 0.8.30

Paste into UserProfileRegistry.sol on Remix

Test Flow
Register

solidity
Copy
Edit
createRegister(0x416c696365, 30)
Name: "Alice" in hex

View Profile

solidity
Copy
Edit
getProfile()
Try Duplicate Register
→ Should revert with "User already registered"

Update Profile

solidity
Copy
Edit
updateProfile(0x426f62, 40)  // "Bob"
Check Updates

solidity
Copy
Edit
getProfile()
Summary
This contract introduces struct usage, external/public modifiers, calldata efficiency, and basic validation — ideal for bootcamp learning and small-scale DApp components.
---

## 3. 🧪 `test/UserProfileRegistry.test.js` (Optional)

If you're using Hardhat:

```js
// UserProfileRegistry.test.js
const { expect } = require("chai");
const { ethers } = require("hardhat");

// [Insert the test suite I gave you earlier here]
