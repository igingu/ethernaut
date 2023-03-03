[14 - GateKeeper Three]

Solution (implemented using forge as well): 
FirstGate: 
* msg.sender should be owner - construct0r has a typo, and can be called to set up owner to our hack contract
* tx.origin shouldn't be owner - that's why owner should be hack contract and not EOA initiator

SecondGate:
* to make allow_entrance == true, need to call getAllowance with the correct _password
* if deployed somewhere, we could use Alchemy eth_getStorageAt to figure it out since it's public on the blockchain
* with forge, we can't do that, but there is a bug tho: if password is not correct, it will be set to block.timestamp, so calling it twice in a row should work, in the same transaction

GateThree:
* GatekeeperThree should have at least 0.001 eth
* sender should refuse eth received: gatekeeperThreeHack can already not receive and ether

Result:
```
contract GatekeeperTwoHack {
    constructor(address gatekeeperTwoAddress) {
        uint64 gateKey = uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(bytes8(type(uint64).max));

        GatekeeperTwo(gatekeeperTwoAddress).enter(bytes8(gateKey));
    }
}
```
