// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721URIStorage } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MatchNFT is ERC721URIStorage {
    uint256 public tokenId;
    address public admin;
    bool public marketEnabled;

    error MarketNotEnabled();

    modifier marketEnabledOnly() {
        if (!marketEnabled) revert MarketNotEnabled();
        _;
    }

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        tokenId = 0;
        admin = msg.sender;
        marketEnabled = false;
    }

    function mint(address to, string memory _tokenURI) external {
        require(msg.sender == admin, "Only admin can mint");
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        tokenId++;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.example.com/metadata/";
    }

    function setMarketEnabled(bool enabled) external {
        marketEnabled = enabled;
    }
}