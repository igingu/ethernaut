// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { GatekeeperOne, GatekeeperOneHack } from "../src/GatekeeperOne.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne public gatekeeperOne;
    GatekeeperOneHack public gatekeeperOneHack;

    address hacker;

    function setUp() public {
        gatekeeperOne = new GatekeeperOne();
        gatekeeperOneHack = new GatekeeperOneHack();

        hacker = makeAddr("hacker");
    }

    function testGatekeeperOne() public {
        assertEq(gatekeeperOne.entrant(), address(0));

        vm.startPrank(hacker, hacker);

        gatekeeperOneHack.hack(address(gatekeeperOne));

        vm.stopPrank();

        assertEq(gatekeeperOne.entrant(), hacker);
    }
}
