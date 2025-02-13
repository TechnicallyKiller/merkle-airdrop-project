// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";


contract MerkleAirdrop {

    address[] claimers;
    bytes32 private immutable i_merkleRoot;
    IERC20 private immutable i_merkleToken;


    constructor(bytes32 merkleroot, IERC20 merkletoken){
        i_merkleRoot=merkleroot;
        i_merkleToken=merkletoken;

    }

    function claim1(address account , uint256 amount , bytes[] calldata merkleproof) public {
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account , amount))));
        if(!MerkleProof.verify(merkleproof,i_merkleRoot,i_merkleToken,leaf)){

        }
    }
}