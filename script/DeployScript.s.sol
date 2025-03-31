// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {Bageltoken} from "src/Bageltoken.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployScript is Script{

function deployMerkleAirdrop() public returns (MerkleAirdrop, Bageltoken) {
    vm.startBroadcast();
    Bageltoken bagelToken = new Bageltoken();
    MerkleAirdrop airdrop = new MerkleAirdrop(ROOT, IERC20(bagelToken));
    bagelToken.mint(bagelToken.owner(), AMOUNT_TO_TRANSFER); // amount for four claimers
    IERC20(bagelToken).transfer(address(airdrop), AMOUNT_TO_TRANSFER); // transfer tokens to the airdrop contract
    vm.stopBroadcast();
    return (airdrop, bagelToken);
}
}