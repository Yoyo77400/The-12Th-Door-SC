// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721URIStorage } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MatchNFT is ERC721URIStorage {
    uint256 public tokenId;
    mapping(address => bool) public hasMinted;
    bool public marketEnabled;

    error MarketNotEnabled();
    error AlreadyMinted();

    modifier marketEnabledOnly() {
        if (!marketEnabled) revert MarketNotEnabled();
        _;
    }

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        tokenId = 0;
        marketEnabled = false;
    }

    function mint(address to) external {
        if (hasMinted[to]) revert AlreadyMinted();
        _safeMint(to, tokenId);
        hasMinted[to] = true;
        tokenId++;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.example.com/metadata/";
    }

    function setMarketEnabled(bool enabled) external {
        marketEnabled = enabled;
    }
}