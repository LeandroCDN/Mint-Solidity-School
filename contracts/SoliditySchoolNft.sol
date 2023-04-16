// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract SoliditySchoolNFT is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint public price;
    IERC20 public token; 

    mapping(uint id => string) public messages;
    mapping(address => bool) public comprador;

    event DeleteMensaje(uint id);

    constructor(uint _price, IERC20 _token) ERC721("SoliditySchoolNFT", "SSN") {
        price = _price;
        token = _token;
    }

    function safeMint(address to, string memory mensajeBonito) public  {
        require(comprador[msg.sender] == false, "no mint two times");
        token.transferFrom(msg.sender, address(this), price);

        uint256 tokenId = _tokenIdCounter.current();
        messages[tokenId] = mensajeBonito;
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);

    }

    function setToken(address _token) public onlyOwner{
        token = IERC20(_token);
    }

    function setPrice(uint _price)public onlyOwner{
        price = _price;
    }

    function deleteMensaje(uint id) public onlyOwner{
        delete messages[id];
        emit DeleteMensaje(id);
    }

    function tokensOfOwner(address owner) public view returns (uint256[] memory)
    {
        uint256 ownerTokenCount = balanceOf(owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);

        for (uint256 i; i < ownerTokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(owner, i);
        }
        return tokenIds;
    }


    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}