// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Faucet is Ownable{
    uint public amountTokens;
    IERC20 public token;

    constructor(IERC20 _token, uint _amountTokens){
        amountTokens = _amountTokens;
        token = _token;
    }

    function claimTokens() public {
        token.transfer(msg.sender, amountTokens);
    }

    function setAmountToken(uint _amountTokens) public onlyOwner{
        amountTokens = _amountTokens;
    }
}