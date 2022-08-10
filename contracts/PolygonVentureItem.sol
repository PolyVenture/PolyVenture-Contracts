pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

//  is ERC721URIStorage, ERC721Enumerable

contract PolyVentureItem is ERC721, ERC721Enumerable, ERC721URIStorage {
    uint256 private _currentTokenId = 0;
    address public accessPassAddress;
    mapping (uint => bool) keyMinted;
    mapping (uint => bool) ropeMinted;
    mapping (uint => bool) swordMinted;
    mapping (uint => bool) noteMinted;
    mapping (uint => bool) accessMinted;

    constructor(
        string memory _name,
        string memory _symbol,
        address _accessPassAddress
    ) ERC721(_name, _symbol) {
       accessPassAddress = _accessPassAddress;
    }

    /**
     * @dev Mints a token to an address with a tokenURI.
     * @param _to address of the future owner of the token
     */
    function mintKey(address _to, uint tokenPassId) hasNotClaimedKey(tokenPassId) public {
        keyMinted[tokenPassId] = true;
        uint256 newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _setTokenURI(newTokenId, "ipfs://QmT2q79bDoLYHBDBEHx4vvePWX7ks2P9FTG8sfccw62LYU");
        _incrementTokenId();
    }

        /**
     * @dev Mints a token to an address with a tokenURI.
     * @param _to address of the future owner of the token
     */
    function mintSword(address _to, uint tokenPassId) hasNotClaimedSword(tokenPassId) public {
        swordMinted[tokenPassId] = true;
        uint256 newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _setTokenURI(newTokenId, "ipfs://QmXgjVQ63ND19dv5YA7oC6wfh79n1zVQ9ey2mVzKnjBUrJ");
        _incrementTokenId();
    }

        /**
     * @dev Mints a token to an address with a tokenURI.
     * @param _to address of the future owner of the token
     */
    function mintNote(address _to, uint tokenPassId) hasNotClaimedNote(tokenPassId) public {
        noteMinted[tokenPassId] = true;
        uint256 newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _setTokenURI(newTokenId, "ipfs://QmPgano4Mw88jzAGUQ3sYUbHe7knZDxj9eYFPkTC3LftVY");
        _incrementTokenId();
    }

        /**
     * @dev Mints a token to an address with a tokenURI.
     * @param _to address of the future owner of the token
     */
    function mintRope(address _to, uint tokenPassId) hasNotClaimedRope(tokenPassId) public {
        ropeMinted[tokenPassId] = true;
        uint256 newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _setTokenURI(newTokenId, "ipfs://QmQfSowHMyqiFFZdkcscBXgHdvRksgmf2SRe8juG3oAGA1");
        _incrementTokenId();
    }

    function mintAccessPass(address _to, uint tokenPassId, string memory passPhrase) hasNotClaimedAccess(tokenPassId) public {
        bytes32 passHash = 0xa796a735a843558d930ef68c2ed980c9779df653f33021d3dddbbb761a64ac3b;
        require(keccak256(bytes(passPhrase)) == passHash, "passphrase must be valid");
        accessMinted[tokenPassId] = true;
        uint256 newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _setTokenURI(newTokenId, "ipfs://QmRbtTjXYBPCLpBTXeK731wJK41TbSC4y1VfuHQUL83amb");
        _incrementTokenId();
    }

    /**
     * @dev calculates the next token ID based on value of _currentTokenId
     * @return uint256 for the next token ID
     */
    function _getNextTokenId() private view returns (uint256) {
        return _currentTokenId+1;
    }

    /**
     * @dev increments the value of _currentTokenId
     */
    function _incrementTokenId() private {
        _currentTokenId++;
    }

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
        return super.tokenURI(tokenId);
    }

    function mintStatus(uint256 tokenId) public view returns (bool[5] memory) {
        return [
        keyMinted[tokenId],
        ropeMinted[tokenId],
        swordMinted[tokenId],
        noteMinted[tokenId],
        accessMinted[tokenId]
        ];
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    modifier hasNotClaimedKey(uint tokenId) {
        require(keyMinted[tokenId] == false);
        require(ERC721(accessPassAddress).ownerOf(tokenId) == msg.sender); 
    _;
    }

    modifier hasNotClaimedRope(uint tokenId) {
        require(ropeMinted[tokenId] == false);
        require(ERC721(accessPassAddress).ownerOf(tokenId) == msg.sender); 
    _;
    }
    
    modifier hasNotClaimedSword(uint tokenId) {
        require(swordMinted[tokenId] == false);
        require(ERC721(accessPassAddress).ownerOf(tokenId) == msg.sender); 
    _;
    }

    modifier hasNotClaimedNote(uint tokenId) {
        require(noteMinted[tokenId] == false);
        require(ERC721(accessPassAddress).ownerOf(tokenId) == msg.sender); 
    _;
    }

    modifier hasNotClaimedAccess(uint tokenId) {
        require(accessMinted[tokenId] == false);
        require(ERC721(accessPassAddress).ownerOf(tokenId) == msg.sender);
    _;
    }
}