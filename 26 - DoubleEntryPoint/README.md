[26 - DoubleEntryPoint](https://ethernaut.openzeppelin.com/level/26)

* The `Vault` does not let you transfer the underlying DET token
* However, the Legacy token delegates transfers to the DET token, and the `Vault` lets you transfer the Legacy tokens
* Only need to call `sweepToken` with the legacy token, and the DET token will be transfered to the `sweptTokensRecipient`