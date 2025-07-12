// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "../src/MatchNFT.sol";
import "../src/FidelityNFT.sol";

contract DeployNFTs is Script {
    function run() external {
        //  Récupération de la clé privée et de l'adresse
        uint256 deployerPrivateKey = vm.envUint("PK");
        address deployer = vm.addr(deployerPrivateKey);
        console.log("Deploying contracts with deployer:", deployer);

        //  Lancement de la diffusion
        vm.startBroadcast(deployerPrivateKey);

        //  Déploiement des contrats
        MatchNFT matchNFT = new MatchNFT("MatchNFT", "MNFT", deployer);
        FidelityNFT fidelityNFT = new FidelityNFT("FidelityNFT", "FNFT");

        //  Vérification post-déploiement
        console.log("MatchNFT deployed at:", address(matchNFT));
        console.log("FidelityNFT deployed at:", address(fidelityNFT));

        //  Appels post-déploiement
        try matchNFT.mint(deployer, "68720c1c33e05427a03276d1") {
            console.log("MatchNFT minted to:", deployer);
        } catch {
            console.log("MatchNFT mint failed.");
        }

        try fidelityNFT.mint(deployer, "2025-2026") {
            console.log("FidelityNFT minted to:", deployer);
        } catch {
            console.log("FidelityNFT mint failed.");
        }

        vm.stopBroadcast();
    }
}
