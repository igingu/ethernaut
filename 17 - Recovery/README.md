[17 - Recovery](https://ethernaut.openzeppelin.com/level/0xb4B157C7c4b0921065Dded675dFe10759EecaA6D)

Solution: 
* given contract is Recovery, at address 0xA5A8dB4760954f20ebf9A71C1f35Cb300F209640
* we can try looking on goerli etherscan to see what contracts has Recovery created
* https://goerli.etherscan.io/address/0xA5A8dB4760954f20ebf9A71C1f35Cb300F209640#internaltx
* https://goerli.etherscan.io/tx/0x9bfb0057c8febb732be6ab063f86f70c1492c31aa28f8c18ac17e0ce1637d1cf#internal
* In Remix, load SimpleToken at 0x08F77626c036CA3839c825489488E2755D7AC2AA and call destroy