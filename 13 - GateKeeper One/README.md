[13 - GateKeeper One](https://ethernaut.openzeppelin.com/level/0x2a2497aE349bCA901Fea458370Bd7dDa594D1D69)

Solution: 
FirstGate: 
* have another contract call enter 

SecondGate:
* copy the GateKeeper One contract and figure out how much gas we should send, by emmiting events
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;

  event eventA(uint256 gasLeft);

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    emit eventA(gasleft());
    require(gasleft() % 1 == 0);
    emit eventA(gasleft());
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      // require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      // require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      // require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GatekeeperOneSolution {
  GatekeeperOne private constant gatekeeperOneContract = GatekeeperOne(0xFDE4A1cFE13E4a69c455784ADe5aFAB0cfAcCEEC);

  function solve(bytes8 _gateKey) external {
    gatekeeperOneContract.enter(_gateKey);
  }
}
```