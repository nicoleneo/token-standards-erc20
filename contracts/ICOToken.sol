// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;
import "hardhat/console.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyICO is ERC20 {
    address public owner;
    uint256 public startTime;
    uint256 public constant SALE_DURATION = 1 days;
    uint256 public constant PRICE_DIVISOR = 10;

    // insert contructor() function
    constructor(uint256 _amount) ERC20("nicole_opt", "ICO") {
        owner = msg.sender;
        startTime = block.timestamp;
        _mint(msg.sender, _amount);
    }

    // insert ownerMint() function
    function ownerMint(uint256 _amount) external {
        require(msg.sender == owner, "Not the owner");
        _mint(msg.sender, _amount);
    }

    // insert buyTokens() function
    function buyTokens(uint256 _amount) public payable {
        uint256 PRICE_IN_ETH = _amount / PRICE_DIVISOR;
        require(
            block.timestamp <= startTime + SALE_DURATION,
            "Sale has expired"
        );
        console.log(msg.value);
        console.log(_amount);
        console.log(PRICE_IN_ETH);
        require(msg.value == PRICE_IN_ETH, "Wrong amount of ETH sent");
        _mint(msg.sender, _amount);
    }
}
