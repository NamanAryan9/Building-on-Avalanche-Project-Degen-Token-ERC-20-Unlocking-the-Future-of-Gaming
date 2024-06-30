// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "ERC20.sol";

contract ItemRedeemer is ERC20 {
    address public owner = msg.sender;
    string items = "1. BUNDLE , 2. GUN SKIN , 3. SHIRT , 4. PANT , 5. GOOGLES";
    string constant BUNDLE = "YOU REDEEMED BUNDLE.";
    string constant SHIRT = "YOU REDEEMED SHIRT.";
    string constant PANT = "YOU REDEEMED PANT.";
    string constant GOOGLES = "YOU REDEEMED GOOGLES.";
    string constant GUN_SKIN = "YOU REDEEMED GUN SKIN";
    string constant NONE = "PLEASE CHOOSE VALUE FROM ITEMS.";
    mapping(address => string) public redeemedItems;
    mapping(address => uint256) public redemptionCount;

    modifier onlyOwner { 
        require(owner == msg.sender, "Only owner can access");
        _;
    }
    
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {} 

    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferTokens(address account,uint256 value) external {
        _transfer(msg.sender, account, value);
    }

    // Returns the list of redeemable items
    function getItemsList() external view returns (string memory) {
        return items;
    }

    // Redeems selected item and burns corresponding tokens
    function redeemItem(uint256 choice) external returns(string memory) {
        redemptionCount[msg.sender]++;
        require(choice >= 1 && choice <= 5, "Please choose a value from the items list.");
        
        // Concatenate redeemed items
        if (redemptionCount[msg.sender] == 1) {
            if (choice == 1) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], "BUNDLE");
                _burn(msg.sender, 200);
                return BUNDLE;
            } else if (choice == 2) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], "GUN_SKIN");
                _burn(msg.sender, 150);
                return GUN_SKIN;
            } else if (choice == 3) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], "SHIRT");
                _burn(msg.sender, 100);
                return SHIRT;
            } else if (choice == 4) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], "PANT");
                _burn(msg.sender, 75);
                return PANT;
            } else if (choice == 5) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], "GOOGLES");
                _burn(msg.sender, 50);
                return GOOGLES;
            } else {
                return NONE;
            }
        } else {
            if (choice == 1) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], " , BUNDLE");
                _burn(msg.sender, 200);
                return BUNDLE;
            } else if (choice == 2) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], " , GUN_SKIN");
                _burn(msg.sender, 150);
                return GUN_SKIN;
            } else if (choice == 3) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], " , SHIRT");
                _burn(msg.sender, 100);
                return SHIRT;
            } else if (choice == 4) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], " , PANT");
                _burn(msg.sender, 75);
                return PANT;
            } else if (choice == 5) {
                redeemedItems[msg.sender] = string.concat(redeemedItems[msg.sender], " , GOOGLES");
                _burn(msg.sender, 50);
                return GOOGLES;
            } else {
                return NONE;
            }
        }
    }

    // Returns the balance of tokens for the caller
    function getTokenBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    // Burns tokens from the specified account
    function burnTokens(address account, uint256 value) external {
        _burn(account, value);
    }
}
