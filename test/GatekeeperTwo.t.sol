// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { GatekeeperTwo, GatekeeperTwoHack } from "../src/GatekeeperTwo.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo public gatekeeperTwo;
    GatekeeperTwoHack public gatekeeperTwoHack;

    address hacker;

    function setUp() public {
        gatekeeperTwo = new GatekeeperTwo();

        hacker = makeAddr("hacker");
    }

    function testGatekeeperTwo() public {
        assertEq(gatekeeperTwo.entrant(), address(0));

        vm.startPrank(hacker, hacker);

        gatekeeperTwoHack = new GatekeeperTwoHack(address(gatekeeperTwo));

        vm.stopPrank();

        assertEq(gatekeeperTwo.entrant(), hacker);
    }
}
