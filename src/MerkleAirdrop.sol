// SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import {IERC20,SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";


contract MerkleAirdrop {
    using SafeERC20 for IERC20;
    event Merkle_TransferSuccessful(address account,uint256 amount);
    error MerkleAirdrop_InvalidProof();
    error MerkleAirdrop_AlreadyClaimed();
    mapping(address=>bool) private Merkle_AlreadyClaimed;

    address[] claimers;
    bytes32 private immutable i_merkleRoot;
    IERC20 private immutable i_merkleToken;


    constructor(bytes32 merkleroot, IERC20 merkletoken){
        i_merkleRoot=merkleroot;
        i_merkleToken=merkletoken;

    }

    function claim1(address account , uint256 amount , bytes32[] calldata merkleproof) public {
        if(Merkle_AlreadyClaimed[account]==true){
            revert MerkleAirdrop_AlreadyClaimed();
        }
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account, amount))));
        if(!MerkleProof.verify(merkleproof,i_merkleRoot,leaf)){
            revert MerkleAirdrop_InvalidProof();
        }
        Merkle_AlreadyClaimed[account]=true;
        emit Merkle_TransferSuccessful(account,amount);
        i_merkleToken.safeTransfer(account,amount);
    }

    function getMerkleRoot() external view returns (bytes32) {
        return i_merkleRoot;
    }

    function getMerkleToken() external view returns (IERC20) {
        return i_merkleToken;
    }
}