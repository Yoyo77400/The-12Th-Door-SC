// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721URIStorage } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";

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
        _baseURI();
    }

    function mint(address to) external {
        if (hasMinted[to]) revert AlreadyMinted();
        _safeMint(to, tokenId);
        hasMinted[to] = true;
        tokenId++;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://localhost:3000/match-nft/68720c1c33e05427a03276d1/0x6C0eB378c14981e8fb45e009bE71Aa894F3dfdf6";
    }

    function tokenURI(uint256 matchID) public pure override returns (string memory) {
        return string(abi.encodePacked("https://tonapi.com/api/nft/metadata/", Strings.toString(matchID), ".json"));
    }

    function setMarketEnabled(bool enabled) external {
        marketEnabled = enabled;
    }
}