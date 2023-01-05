[5 - Token](https://ethernaut.openzeppelin.com/level/0xB4802b28895ec64406e45dB504149bfE79A38A57)

Solution: 
* transfer function doesn't check for underflows (since it's old Solidity)
* my initial balance is 0; if value > 0, balance - value will underflow and be >= 0
* transfering 10 ^ 9 tokens from myself with balance 0 to someone, should make my balance (0 - 10 ^ 9), which underflows so I will have balance (2 ^ 256 - 10 ^ 9)
```
await contract.transfer("0xa22E55b8727BD4cd436cdb3Cf6151bafAA65D11E", 1000000000);
```
