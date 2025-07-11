// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MatchNFT is ERC721 {
    uint256 public nextTokenId;
    address public admin;
    bool public marketEnabled;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        admin = msg.sender;
        marketEnabled = false;
    }

    function mint(address to) external {
        require(msg.sender == admin, "Only admin can mint");
        _safeMint(to, nextTokenId);
        nextTokenId++;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.example.com/metadata/";
    }
}