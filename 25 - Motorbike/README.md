[25 - Motorbike](https://ethernaut.openzeppelin.com/level/0x9b261b23cE149422DE75907C6ac0C30cEc4e652A)

* ```Motorbike``` is a proxy for the ```Engine``` contract: is constructed with an address to forward all calls to, in constructor it calls ```initialize()``` on implementation, and doesn't have functionality to change implementation slot
* ```Engine``` is the implementation of ```Motorbike```
* ```Engine``` also acts like a proxy, and has an implementation.
* One way to make the Motorbike unusable, is to make the underlying implementation unavailable: ```Engine```.
* We can do that by taking control of Engine, and making it self-distruct, since AccessControl is not set up properly