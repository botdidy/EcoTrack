# EcoTrack Smart Contract

EcoTrack is a blockchain-based smart contract built on the Stacks ecosystem using the Clarity language. It enables users to earn, track, trade, and manage solar energy credits, promoting environmentally sustainable actions.

## Features

### Earn Solar Credits
Users can earn solar credits in specified amounts, stored securely on the blockchain.

### View Solar Credits
Users can check their current credit balance or the total credits they have earned.

### Transfer Solar Credits
Users can transfer credits to others, facilitating a community-driven approach to rewarding sustainable actions.

### Burn Credits
Users can burn their credits, which can be used for purposes like redeeming rewards.

### Manage Contract Ownership
The contract includes functionality to manage ownership, enabling the current owner to transfer ownership securely.

## Smart Contract Functions

### `earn-solar-credit (amount uint)`
Allows users to earn a specified number of solar credits. Validates that the amount is positive and does not exceed the maximum credit limit (`2^128 - 1`).

### `get-solar-credits (user principal)`
A read-only function to check the current credit balance of a specific user.

### `get-total-credits-earned (user principal)`
A read-only function to retrieve the total number of credits a user has earned historically.

### `transfer-credits (recipient principal, amount uint)`
Enables users to transfer credits to another user. Validates that the sender has enough balance, the transfer amount is positive, and the sender is not transferring to themselves.

### `burn-credits (amount uint)`
Allows users to burn a specified number of credits from their balance.

### `set-contract-owner (new-owner principal)`
A function that enables the current contract owner to transfer ownership of the contract to a new owner. Only callable by the current owner.

### `get-contract-owner`
A read-only function to retrieve the current owner of the contract.

## Constants Used
- `ERR-INVALID-USER`: Returned when a user tries to send credits to themselves.
- `ERR-CREDIT-OVERFLOW`: Ensures credit balances do not exceed the maximum allowed value.
- `ERR-INSUFFICIENT-BALANCE`: Returned if the sender tries to transfer or burn more credits than they own.
- `ERR-UNAUTHORIZED`: Returned if an unauthorized user attempts to perform restricted actions.
- `ERR-INVALID-AMOUNT`: Returned when an invalid (e.g., non-positive) amount is provided.
- `MAX-CREDITS`: The maximum allowable credits for any user (`2^128 - 1`).

EcoTrack promotes green practices by tracking and incentivizing sustainable actions on the blockchain.