// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { GoodSamaritan, Coin, Wallet, GoodSamaritanHack } from "../src/GoodSamaritan.sol";

contract GoodSamaritanTest is Test {
    GoodSamaritan public goodSamaritan;
    GoodSamaritanHack public goodSamaritanHack;

    function setUp() public {
        goodSamaritan = new GoodSamaritan();
        goodSamaritanHack = new GoodSamaritanHack(goodSamaritan);

    }

    function testGoodSamaritan() public {
        assertFalse(goodSamaritan.coin().balances(address(goodSamaritan.wallet())) == 0);

        goodSamaritanHack.hack();

        assertTrue(goodSamaritan.coin().balances(address(goodSamaritan.wallet())) == 0);
    }
}
