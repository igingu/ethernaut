[2 - Fallout](https://ethernaut.openzeppelin.com/level/0x0AA237C34532ED79676BCEa22111eA2D01c3d3e7)

Solution: 
* contract is called Fallout, but "constructor" function is called Fal**1**out
* on construction time, owner is not set since constructor has wrong name
* someone can just call Fal**1**out method to change owner

```
await contract.Fal1out();
```