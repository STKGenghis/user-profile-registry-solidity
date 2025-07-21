// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/**
 * @title UserProfileRegistry
 * @dev A contract for managing user profiles on the Ethereum blockchain.
 * Users can register, update, and view their profiles.
 * Assignment 2 Week 1: using Remix and for Dev3Pack Fellowship.
 */
contract UserProfileRegistry {

    /**
     * @dev Struct to hold user profile information.
     * @param name The name of the user, stored as bytes for gas efficiency.
     * @param age The age of the user, stored as uint8.
     * @param registeredAt The timestamp when the user registered, stored as uint32.
     */
    struct User {
        bytes name; // Using bytes for the name variable for gas efficiency
        uint8 age; // Using uint8 for the age variable
        uint32 registeredAt; // Using uint32 for the timestamp
    }

    // Mapping to associate an Ethereum address with a User struct
    mapping(address => User) private users;

    // Mapping to check if an address is registered
    mapping(address => bool) private isRegistered;

    /**
     * @dev Function to create a new user registration.
     * @param _name The name of the user.
     * @param _age The age of the user.
     */
    function createRegister(bytes calldata _name, uint8 _age) external {
        // Check if the user is already registered
        require(!isRegistered[msg.sender], "User already registered");

        // Create a new User struct and store it in the users mapping
        users[msg.sender] = User({
            name: _name,
            age: _age,
            registeredAt: uint32(block.timestamp) // Cast block.timestamp to uint32
        });

        // Mark the user as registered
        isRegistered[msg.sender] = true;
    }

    /**
     * @dev Function to update an existing user profile.
     * @param _name The new name of the user.
     * @param _age The new age of the user.
     */
    function updateProfile(bytes calldata _name, uint8 _age) external {
        // Check if the user is registered
        require(isRegistered[msg.sender], "User not registered");

        // Update the user's name and age in the users mapping
        User storage user = users[msg.sender];
        user.name = _name;
        user.age = _age;
    }

    /**
     * @dev Function to view the user's profile.
     * @return name The name of the user.
     * @return age The age of the user.
     * @return registeredAt The timestamp when the user registered.
     */
    function getProfile() external view returns (bytes memory, uint8, uint32) {
        // Check if the user is registered
        require(isRegistered[msg.sender], "User not registered");

        // Retrieve the user's profile from the users mapping
        User memory user = users[msg.sender];
        return (user.name, user.age, user.registeredAt);
    }
}