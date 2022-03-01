// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract NFT is ERC721, Ownable {
        
        using Strings for uint256;
        
        mapping (uint256 => string) private _tokenURIs;

        string private _baseURIextended;

        uint public currentTokenID = 1;


        constructor(string memory _name, string memory _symbol)
            ERC721(_name, _symbol)
        {}
        
        function setBaseURI(string memory baseURI_) external onlyOwner() {
            _baseURIextended = baseURI_;
        }
        
        function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
            require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
            _tokenURIs[tokenId] = _tokenURI;
        }
        
        function _baseURI() internal view virtual override returns (string memory) {
            return _baseURIextended;
        }
        
        function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
            require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

            string memory _tokenURI = _tokenURIs[tokenId];
            string memory base = _baseURI();

            if (bytes(base).length == 0) {
                return _tokenURI;
            }
            
            if (bytes(_tokenURI).length > 0) {
                return string(abi.encodePacked(base, _tokenURI));
            }
            
            return string(abi.encodePacked(base, tokenId.toString()));
        }
        

        function mint(
            address _to,
            string memory _tokenURI
        ) external onlyOwner() {
            _mint(_to, currentTokenID);
            _setTokenURI(currentTokenID, _tokenURI);
            currentTokenID++;
        }
    }
