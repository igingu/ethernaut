[12 - Privacy](https://ethernaut.openzeppelin.com/level/0xcAac6e4994c2e21C5370528221c226D1076CfDAB)

Solution: 
* storage is public on the blockchain, if you know how to read it
* we can use the same method as for Vault challenge, just with a different index
```
bool public locked = true; // slot 0
uint256 public ID = block.timestamp; // slot 1
uint8 private flattening = 10; // slot 2
uint8 private denomination = 255; // slot 2
uint16 private awkwardness = uint16(block.timestamp); // slot 2
bytes32[3] private data; // slot 3, 4, 5
```
* data[2] should be slot 5
```
const options = {
  method: 'POST',
  headers: {accept: 'application/json', 'content-type': 'application/json'},
  body: JSON.stringify({
    id: 1,
    jsonrpc: '2.0',
    method: 'eth_getStorageAt',
    params: ['0x67A2E1E7EfaCD82dEf7D315c4D11EA7a724C57bD', '0x05', 'latest']
  })
};

fetch('https://eth-goerli.g.alchemy.com/v2/docs-demo', options)
  .then(response => response.json())
  .then(response => console.log(response))
  .catch(err => console.error(err));
```
* returns **0x2268d6686c8a2e721ad064093ccc5f237a142c31a5021d7fc820ef8880fcdbc8**
* bytes16 of this is **0x2268d6686c8a2e721ad064093ccc5f23**, the beginning part
