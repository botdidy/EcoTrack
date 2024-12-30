# EcoTrack Smart Contract

EcoTrack is a blockchain-based smart contract built on the Stacks ecosystem using the Clarity language. It allows users to earn, track, and transfer energy-saving credits, promoting environmentally sustainable actions.

## Features

1. **Earn Eco Credits**  
   Users can earn energy-saving credits, which are stored securely on the blockchain.

2. **View Eco Credits**  
   Users can check their current credit balance or the balance of any other user.

3. **Transfer Eco Credits**  
   Users can transfer credits to others, enabling a community-driven approach to rewarding sustainable actions.

## Smart Contract Functions

1. **earn-solar-credit**  
   Allows users to earn one Eco Credit. Ensures credits do not exceed the maximum limit (`2^128 - 1`).

2. **get-solar-credits**  
   A read-only function to check the Eco Credit balance of a specific user.

3. **transfer-credits**  
   Enables users to transfer credits to another user. The sender must have sufficient credits, and transfers cannot be made to oneself.

## Constants Used

- **ERR-INVALID-USER**: Returned when a user tries to send credits to themselves.
- **ERR-CREDIT-OVERFLOW**: Ensures credit balances do not exceed the maximum allowed value.
- **ERR-INSUFFICIENT-BALANCE**: Returned if the sender tries to transfer more credits than they own.
- **MAX-CREDITS**: The maximum allowable credits for any user (`2^128 - 1`).

EcoTrack promotes green practices by tracking and incentivizing sustainable actions on the blockchain. 
