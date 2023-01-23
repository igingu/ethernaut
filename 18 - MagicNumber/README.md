[18 - MagicNumber](https://ethernaut.openzeppelin.com/level/0xFe18db6501719Ab506683656AAf2F80243F8D0c0)

I have just learned how solidity opcodes and initialization + runtime assembly works. 

This challenge asks us to write a contract of at least 10 opcodes, that returns the number 0x2A.

Solution (runtime bytecode) - should return 0x2A: 
* PUSH1 (0x60) 0x20 // stack = (0x20) => 2 opcodes
* PUSH1 (0x60) 0x80 // stack = (0x20, 0x80) => 2 opcodes
* PUSH1 (0x60) 0x2A // stack = (0x20, 0x80, 0x2A) => 2 opcodes
* PUSH1 (0x60) 0x80 // stack = (0x20, 0x80, 0x2A, 0x80) => 2 opcodes
* MSTORE (0x52) // stack = (0x20, 0x80), memory[0x80:0x20] = 0x2A => 1 opcode
* RETURN (0xF3) => 1 opcode 
* 10 opcodes in total
* Translated to bytecode, it would be 0x60206080602A608052f3

Solution (initialization bytecode) - should copy contract runtime bytecode to memory and return it from transaction:
* PUSH1 (0x60) 0x0A // stack = (0x0A) => 2 opcodes
* PUSH1 (0x60) 0x0C // stack = (0x0A, 0x0C) => 2 opcodes. Initialization bytecode would be 12 bytes, so we need to start copying from 13th byte onward (that's why 0x0C)
* PUSH1 (0x60) 0x00 // stack = (0x0A, 0x0C, 0x00) => 2 opcodes
* CODECOPY (0x39) // stack = () => 1 opcode
* PUSH1 (0x60) 0x0A // stack = (0x0A) => 2 opcodes
* PUSH1 (0x60) 0x00 // stack = (0x0A, 0x00) => 2 opcodes
* RETURN (0xF3) => 1 opcode
* Translated to bytecode, it would be 0x600A600C600039600A6000F3

Final bytecode, combined:
0x600A600C600039600A6000F360206080602A608052f3

In Remix console:
web3.eth.sendTransaction({ from: "0x690aD8fABE17f1EeFF88E2Ef900f7b88e6eC0aF0", data: "0x600A600C600039600A6000F360206080602A608052f3" }, function(err,res){console.log(res)});

Solver contract: https://goerli.etherscan.io/address/0xC40e0244668CF638281845a3B4A1638e9E4F0913