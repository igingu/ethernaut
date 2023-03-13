[20 - Denial](https://ethernaut.openzeppelin.com/level/0xD0a78dB26AA59694f5Cb536B50ef2fa00155C488)

* ```partner.call``` forwards all gas and doesn't check for return value
* to stop owner from receiving funds, the partner could be our malicious smart contract, which in its' receive function, has in infinite loop which uses up all gas