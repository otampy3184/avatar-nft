# My very first original NFT

let's mint my cutest reddit avatar on public test-network

## how things going
1. create enviroment and contract

2. compile, deploy and mint(see below)
```
Hiroshi Takagi@DESKTOP-PN1Q84A MINGW64 ~/MyProject/dapp/a
$ truffle migration --network rinkeby --reset

Compiling your contracts...
===========================
> Compiling .\contracts\AvatarNFT.sol
> Compiling .\node_modules\@openzeppelin\contracts\access
> Compiling .\node_modules\@openzeppelin\contracts\token\
> Compiling .\node_modules\@openzeppelin\contracts\token\
> Compiling .\node_modules\@openzeppelin\contracts\token\
> Compiling .\node_modules\@openzeppelin\contracts\token\
> Compiling .\node_modules\@openzeppelin\contracts\utils\
> Compiling .\node_modules\@openzeppelin\contracts\utils\
> Compiling .\node_modules\@openzeppelin\contracts\utils\
> Compiling .\node_modules\@openzeppelin\contracts\utils\
> Compiling .\node_modules\@openzeppelin\contracts\utils\
> Compiling .\node_modules\@openzeppelin\contracts\utils\
> Artifacts written to C:\Users\Hiroshi Takagi\MyProject\
> Compiled successfully using:
   - solc: 0.8.13+commit.abaa5c0e.Emscripten.clang


Starting migrations...
======================
> Network name:    'rinkeby'
> Network id:      4
> Block gas limit: 30000000 (0x1c9c380)


2_avatar.js
===========
   > transaction hash:    0xd7d8994667d27180f157f85f5cdd6ca1613c1e1553e5420a66247e9ba8f9b549
   > Blocks: 1            Seconds: 13
   > contract address:    0x8cF6845aD1BEc1c157244bA161ff818DaFF41131
   > block number:        10652162
   > block timestamp:     1652190425
   > account:             0x52149c8A1152Df63517994adECfc00A8098444B2
   > balance:             0.178532112908279994
   > gas used:            2554568 (0x26fac8)
   > gas price:           6.586099469 gwei
   > value sent:          0 ETH
   > total cost:          0.016824638948324392 ETH       

   Pausing for 2 confirmations...

   -------------------------------
   > confirmation number: 1 (block: 10652163)
   > confirmation number: 2 (block: 10652164)
   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:     0.016824638948324392 ETH

Summary
=======
> Total deployments:   1
> Final cost:          0.016824638948324392 ETH



Hiroshi Takagi@DESKTOP-PN1Q84A MINGW64 ~/MyProject/dapp/avatar-nft (main)
$ truffle console --network rinkeby
truffle(rinkeby)> const avatar = await AvatarNFT.deployed()
undefined
truffle(rinkeby)> avatar.address
'0x8cF6845aD1BEc1c157244bA161ff818DaFF41131'
truffle(rinkeby)> avatar.safeMint("0x52149c8A1152Df63517994adECfc00A8098444B2")
{
  tx: '0x7befaec7ee33ae771e9ee4ce5c28ccb13128620782b44c462d948625041deb49',
  receipt: {
    blockHash: '0x16612ba92e50c41c64fef9e449bcc88b4523edfb1057a8424d71c4936904b394',
    blockNumber: 10652193,
    contractAddress: null,
    cumulativeGasUsed: 3493260,
    effectiveGasPrice: '0x1dab71cd6',
    from: '0x52149c8a1152df63517994adecfc00a8098444b2',
    gasUsed: 93882,
    logs: [ [Object] ],
    logsBloom: '0x40000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000020000000000000000000800000000000000000000000010000000000000000000000000000000000000000000000000000000000000000001800000000000000000000000000000000000008004000000000000000000000000000000000002000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000',
    status: true,
    to: '0x8cf6845ad1bec1c157244ba161ff818daff41131',
    transactionHash: '0x7befaec7ee33ae771e9ee4ce5c28ccb13128620782b44c462d948625041deb49',
    transactionIndex: 21,
    type: '0x2',
    rawLogs: [ [Object] ]
  },
  logs: [
    {
      address: '0x8cF6845aD1BEc1c157244bA161ff818DaFF41131',
      blockHash: '0x16612ba92e50c41c64fef9e449bcc88b4523edfb1057a8424d71c4936904b394',
      blockNumber: 10652193,
      logIndex: 27,
      removed: false,
      transactionHash: '0x7befaec7ee33ae771e9ee4ce5c28ccb13128620782b44c462d948625041deb49',
      transactionIndex: 21,
      id: 'log_66b12c6a',
      event: 'Transfer',
      args: [Result]
    }
  ]
}
truffle(rinkeby)>
```

(check my NFT on Opensea)<https://testnets.opensea.io/assets/0xBCf664A8E5023Ceb4BEA8a4116e3682D167142F7/0>