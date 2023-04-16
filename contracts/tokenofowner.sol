

contract MedaPart is ERC721, ERC721Enumerable, ERC721URIStorage, ERC721Burnable, Ownable {
    
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string public baseUri;
    
    event Metadata(uint256 id, MedapartMetadata.Metadata Metadata, string metadataURL);

    event TransferRobotPart(address from, address to, uint256 tokenId);

    constructor(string memory _baseUri) ERC721("MEDABOTS", "MEBT") {
        baseUri =_baseUri;
    }
   
    mapping(uint256 => uint8) public families;
    mapping(uint256 => MedapartMetadata.Part) public parts;
    mapping(string => bool) public usedHash;
    mapping(bytes32 => bool) usedKeys;
 
    function mint(
        address _tokenOwner,
        string calldata metadataURL,
        MedapartMetadata.Metadata calldata _metadata
    ) external onlyOwner returns (uint256) {
        require(usedHash[metadataURL] == false, "This data was already created ");
        usedHash[metadataURL] = true;
        _tokenIds.increment();
        uint256 id = _tokenIds.current();
        _mint(_tokenOwner, id);
        _setTokenURI(id, metadataURL);
        emit Metadata(id, _metadata, metadataURL);
        //setear mapings families y parts.
        families[id] = _metadata.familyId;
        parts[id] = _metadata.partId;
        return id;
    }

    function familyOf(uint256 tokenId) public view returns (uint8) {
        uint8 family = families[tokenId];
        return family;
    }

    function partOf(uint256 tokenId) public view returns (MedapartMetadata.Part) {
        MedapartMetadata.Part part = parts[tokenId];
        return part;
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

    function setBaseUri(string memory _newBaseUri) public onlyOwner {
        baseUri =_newBaseUri;
    }

    function getUsedKeys(bytes32 _key) public view onlyOwner returns(bool){
        return usedKeys[_key];
    }
    function setUsedKeys(bytes32 _key) public onlyOwner {
        usedKeys[_key] = true;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
         
        return string(abi.encodePacked(baseUri,super.tokenURI(tokenId)));
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