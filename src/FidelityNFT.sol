// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract FidelityNFT is ERC721 {
    uint256 public tokenId;
    mapping (uint256 => string) private seasonOf;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        tokenId = 0;
    }

    function mint(address to, string memory seasonOf_) external {
        _safeMint(to, tokenId);
        seasonOf[tokenId] = seasonOf_;
        tokenId++;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.example.com/metadata/";
    }

}