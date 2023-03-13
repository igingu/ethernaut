// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Denial, DenialHack } from "../src/Denial.sol";

contract DenialTest is Test {
    Denial public denial;
    DenialHack public denialHack;

    function setUp() public {
        denial = new Denial();
        denialHack = new DenialHack();

        vm.deal(address(denial), 1 ether);
    }

    function testDenial() public {
        // Shouldn't revert
        denial.withdraw();

        denial.setWithdrawPartner(address(denialHack));

        vm.expectRevert();
        denial.withdraw{gas: 1e6}();
    }
}
