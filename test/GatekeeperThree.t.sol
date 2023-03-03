// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { GatekeeperThree, GatekeeperThreeHack } from "../src/GatekeeperThree.sol";

contract GatekeeperThreeTest is Test {
    GatekeeperThree public gatekeeperThree;
    GatekeeperThreeHack public gatekeeperThreeHack;

    address hacker;

    function setUp() public {
        gatekeeperThree = new GatekeeperThree();
        gatekeeperThreeHack = new GatekeeperThreeHack{value: 1 ether}();

        hacker = makeAddr("hacker");
    }

    function testGatekeeperThree() public {
        assertEq(gatekeeperThree.entrant(), address(0));

        vm.startPrank(hacker, hacker);

        gatekeeperThreeHack.hack(payable(address(gatekeeperThree)));

        vm.stopPrank();

        assertEq(gatekeeperThree.entrant(), hacker);
    }
}
