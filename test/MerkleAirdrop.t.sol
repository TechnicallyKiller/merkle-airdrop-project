// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {Bageltoken} from "../src/Bageltoken.sol";
import {Test} from "forge-std/Test.sol";


contract MerkleAirdropTest is Test {
    MerkleAirdrop public merkleAirdrop;
    Bageltoken public bagelToken;

    address user;
    uint256 userPrivkey;

    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public AMOUNT = 25 *1e10;
    bytes32 public proof1 = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 public proof2 = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] public PROOF = [proof1, proof2];

    function setUp() public {
        bagelToken = new Bageltoken();
        merkleAirdrop = new MerkleAirdrop(ROOT,bagelToken);
        (user,userPrivkey) = makeAddrAndKey("user");


    }
    function testUserCanClaim() public {
        uint256 startingBalance = bagelToken.balanceOf(user);

        vm.prank(user);
        merkleAirdrop.claim1(user,AMOUNT,PROOF);
        uint256 endingBlance= bagelToken.balanceOf(user);
        assertEq(endingBlance-startingBalance, AMOUNT);

    }


    

}