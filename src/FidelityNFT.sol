// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";

contract FidelityNFT is ERC721Pausable {
    uint256 public tokenId;
    mapping (address => bool) public hasMinted;
    mapping (uint256 => string) private seasonOf;

    error NonTransferable();
    error AlreadyMinted();

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        tokenId = 0;
    }

    function mint(address to, string memory seasonOf_) external {
        if (hasMinted[to]) revert AlreadyMinted();
        _safeMint(to, tokenId);
        seasonOf[tokenId] = seasonOf_;
        hasMinted[to] = true;
        _pause();
        tokenId++;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.example.com/metadata/";
    }
}
