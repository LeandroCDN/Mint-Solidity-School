pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoliditySchool is ERC20, Ownable {
    constructor() ERC20("SoliditySchoolToken", "SST") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}