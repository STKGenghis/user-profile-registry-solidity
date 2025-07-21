# user-profile-registry-solidity
Solidity smart contract for registering, updating, and viewing user profile data — built as part of the Dev3Pack Lisk Summer Bootcamp Week 1 Assignment 2.
# UserProfileRegistry Smart Contract

### ✍️ Dev3Pack x Lisk Summer Bootcamp – Week 1, Assignment 2  
> A simple and gas-efficient Ethereum smart contract for managing user profiles, written in Solidity and deployed using Remix.

---

## 📌 What Is This?

`UserProfileRegistry` is a Solidity smart contract that allows individual Ethereum wallet holders (EOAs) to register, update, and view their own profile data. This project was created as part of a bootcamp assignment to demonstrate struct usage, mappings, function visibility, and calldata optimization.

---

## 🔧 Features

- **User Registration**: One-time self-registration with name and age.
- **Profile Updates**: Update your name and age at any time after registering.
- **Profile Viewing**: Retrieve your profile data (name, age, and timestamp).
- **Gas Efficiency**: Compact data types (`bytes`, `uint8`, `uint32`) reduce storage costs.

---

## 📚 Understanding the Code

### 🔸 `User` Struct
```solidity
struct User {
    bytes name;
    uint8 age;
    uint32 registeredAt;
}
name: Stored as bytes to reduce gas usage vs. string.

age: uint8 is enough to represent all possible human ages (0–255).

registeredAt: Uses uint32 instead of uint256 to store the UNIX timestamp (valid until ~2106).

🔸 Mappings
mapping(address => User) private users;
mapping(address => bool) private isRegistered;
users: Links each Ethereum address to a User struct.

isRegistered: Tracks whether a user has already registered.

⚙️ Core Functions
📝 createRegister(bytes calldata _name, uint8 _age)
Registers a new user (only once per address).

🔁 updateProfile(bytes calldata _name, uint8 _age)
Updates name and age if the user is already registered.

🔍 getProfile() external view returns (bytes memory, uint8, uint32)
Returns the name, age, and registration timestamp for the calling address.

🧪 Testing & Deployment
✅ What You Need
Remix IDE

Solidity Compiler 0.8.30

(Optional) MetaMask or injected web3 provider

🛠 Steps to Deploy & Interact
Open Remix IDE.

Create a new file UserProfileRegistry.sol and paste the contract code.

Compile using Solidity 0.8.30.

Deploy using the default account (Injected Web3 or Remix VM).

Call createRegister with:

_name: hex (e.g. 0x416c696365 for "Alice")

_age: e.g. 30

Use getProfile() to confirm registration.

Try createRegister() again → should revert.

Use updateProfile(...) and check updates via getProfile().

🧪 Hardhat Tests (Optional Advanced)
If you want to run tests in a local environment like Hardhat, here’s a sample test suite (UserProfileRegistry.test.js):

<details> <summary>Click to expand Hardhat tests</summary>
js
Copy
Edit
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("UserProfileRegistry", function () {
  let UserProfileRegistry, userProfileRegistry, owner;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();
    UserProfileRegistry = await ethers.getContractFactory("UserProfileRegistry");
    userProfileRegistry = await UserProfileRegistry.deploy();
    await userProfileRegistry.deployed();
  });

  it("Should allow a user to register", async function () {
    const name = ethers.utils.formatBytes32String("John");
    const age = 30;
    await userProfileRegistry.createRegister(name, age);

    const profile = await userProfileRegistry.getProfile();
    expect(profile[0]).to.equal(name);
    expect(profile[1]).to.equal(age);
    expect(profile[2]).to.be.a("number");
  });

  it("Should prevent duplicate registration", async function () {
    const name = ethers.utils.formatBytes32String("John");
    const age = 30;
    await userProfileRegistry.createRegister(name, age);

    await expect(
      userProfileRegistry.createRegister(name, age)
    ).to.be.revertedWith("User already registered");
  });

  it("Should allow profile updates", async function () {
    const name1 = ethers.utils.formatBytes32String("John");
    const name2 = ethers.utils.formatBytes32String("Jane");
    await userProfileRegistry.createRegister(name1, 30);
    await userProfileRegistry.updateProfile(name2, 25);

    const profile = await userProfileRegistry.getProfile();
    expect(profile[0]).to.equal(name2);
    expect(profile[1]).to.equal(25);
  });

  it("Should not allow updates from unregistered users", async function () {
    const name = ethers.utils.formatBytes32String("Anon");
    await expect(
      userProfileRegistry.updateProfile(name, 50)
    ).to.be.revertedWith("User not registered");
  });

  it("Should block profile view for unregistered users", async function () {
    await expect(userProfileRegistry.getProfile()).to.be.revertedWith("User not registered");
  });
});
</details>
📂 File Structure
cpp
Copy
Edit
UserProfileRegistry.sol      // Solidity smart contract
README.md                    // Project description and test plan
LICENSE                      // MIT License
📄 License
This project is licensed under the MIT License. See LICENSE file for more details.

✅ Conclusion
The UserProfileRegistry contract is a lightweight, gas-efficient solution for managing on-chain user profiles. It ensures registration logic is enforced and provides basic data mutability and retrievability. Ideal for beginner-level smart contract development and bootcamp assignments.
