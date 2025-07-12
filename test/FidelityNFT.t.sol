// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FidelityNFT} from "../src/FidelityNFT.sol";

contract FidelityNFTTest is Test {
    FidelityNFT public fidelityNFT;

    function setUp() public {
        fidelityNFT = new FidelityNFT("Fidelity NFT", "FID");
    }

    function testMint() public {
        address to = address(0x123);
        string memory season = "Summer 2023";

        fidelityNFT.mint(to, season);
        assertEq(fidelityNFT.ownerOf(0), to);
    }
}
