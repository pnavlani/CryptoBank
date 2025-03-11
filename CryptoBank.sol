// License 
// SPDX-License-Identifier: LGPL-3.0-only

// Solidity version
pragma solidity 0.8.24;

/*
Functions:
    1.Deposit Ether
    2. Withdraw Ether

Rules:
     1. Multiuser
     2. Only can deposit Ether
     3. User can only withdraw prevoiusly deposited Ether
     4. Max balance = 5 ether;
     5. MaxBalance modifiable by owner
        UserA -> Deposit (5 Ether)
        UserB -> Deposit (2 Ether)
        Bank balance = 7 Ether
        UserA -> Deposit(1 Ether) -> desposit(5 Ether) -> withdraw(2 Ether) -> deposit(5 ether)
*/

contract CryptoBank {
        uint256 public maxBalance;

    constructor(uint256 maxBalance_) {
        maxBalance = maxBalance_;
    }
}