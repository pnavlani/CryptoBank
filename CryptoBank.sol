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
        address public admin;
        mapping(address => uint256) public userBalance;

        //Events
        event EtherDeposit(address user_, uint256 etheramount_);
        event EtherWithdraw(address user_, uint256 etheramount_);

        //Modifiers
        modifier onlyAdmin() {
            require(msg.sender == admin,"You`re Not Allowed");
            _;
        }

    constructor(uint256 maxBalance_, address admin_) {
        maxBalance = maxBalance_;
        admin = admin_;
    }

    //External Functions

    //Deposit 
    function depositEther() external payable {
        require(userBalance[msg.sender] + msg.value <= maxBalance, "Maximum Balance reached");
        //mapping 
        userBalance[msg.sender] += msg.value; 

        emit EtherDeposit(msg.sender, msg.value);
    }

    //Withdraw
    function withdrawEther(uint256 amount_) external {
        require(amount_ <= userBalance[msg.sender], "Not enough ether");
        
        //1. Update state 
        userBalance[msg.sender] -= amount_;

        //2. Transfer ether
       (bool success,) = msg.sender.call{value: amount_}("");
       require(success, "Transfer failed");

       emit EtherWithdraw(msg.sender, amount_);
    }

    //Modify maxBalance
    function modifyMaxBalance(uint256 newMaxBalance_) external onlyAdmin {
        maxBalance = newMaxBalance_;
    }


}