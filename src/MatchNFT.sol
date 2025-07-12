// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721URIStorage } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract MatchNFT is ERC721URIStorage, Pausable, Ownable {
    uint256 public tokenId;
    struct NFTClaim {
        address claimer;
        string matchID;
    }
    mapping(uint256 => NFTClaim) public NFTDetailsClaim;
    mapping(address => bool) public hasMinted;
    bool public marketEnabled;

    error MarketNotEnabled();
    error AlreadyMinted();

    modifier marketEnabledOnly() {
        if (!marketEnabled) revert MarketNotEnabled();
        _;
    }

    constructor(string memory name_, string memory symbol_, address _owner) ERC721(name_, symbol_) Ownable(msg.sender) {
        tokenId = 0;
        marketEnabled = false;
        transferOwnership(_owner);
    }

    function pause() external onlyOwner() {
        _pause();
    }

    function unpause() external onlyOwner() {
        _unpause();
    }

    function mint(address to, string memory matchId) external whenNotPaused() {
        if (hasMinted[to]) revert AlreadyMinted();
        _safeMint(to, tokenId);
        
        NFTDetailsClaim[tokenId] = NFTClaim({claimer: to, matchID: matchId});
        tokenId++;
    }

    function tokenURI(uint256 tokenId_) public view override returns (string memory) {
        NFTClaim memory claim = NFTDetailsClaim[tokenId_];
        return string(
            abi.encodePacked(
                "https://localhost:3000/match-nft/",
                claim.matchID,
                "/",
                Strings.toHexString(uint256(uint160(claim.claimer)), 20)
            )
        );
    }

    function previewURI(uint256 tokenId_) external view returns (string memory) {
        NFTClaim memory claim = NFTDetailsClaim[tokenId_];
        return string(
            abi.encodePacked(
                "https://localhost:3000/match-nft/",
                claim.matchID,
                "/",
                Strings.toHexString(uint256(uint160(claim.claimer)), 20)
            )
        );
    }

    function setMarketEnabled(bool enabled) external {
        marketEnabled = enabled;
    }
}