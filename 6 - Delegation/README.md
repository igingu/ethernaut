[6 - Delegation](https://ethernaut.openzeppelin.com/level/0xF781b45d11A37c51aabBa1197B61e6397aDf1f78)

Solution: 
* **delegatecall** uses the context of the calling contract
* to change owner of **Delegation** contract, we should call fallback function with msg.data corresponding to **Delegate**'s **pwn** function
* pwn has no parameters => we only need the Method ID. This is the first 4 bytes of the Keccak-256 hash of the ASCII form of the signature pwn().
* to get correct calldata, I loaded Delegate contract in Remix, called the **pwn** method directly and got the calldata from that transaction => 0xdd365b8b
```
await contract.sendTransaction({data: "0xdd365b8b"});
```
