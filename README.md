# NFT mint tutorial
Redditの自作アバターをOpensea上にMintする

# 環境
Windows 10 Home
Solidity 0.8.0
Node.js v14.15.4
npm v6.14.10
Truffle v5.5.13
Truffle HDWalletProvider v2.0.8
Openzeppelin Contract v4.6.0

# 事前準備
1. InfraでEthereumに接続するAPIを用意する
2. Metamaskに登録し、Rinkebyのテストネットワークに接続しておく
3. Metamaskで用意したRinkebyのアドレスに対して、FaucetからETHを送っておく
4. Node.jsをインストールする

# 手順
## 環境整備
truffleはEVM開発用のフレームワークで、Solidityのコンパイルからデプロイ、テストまでが簡単に実行できるツー
npmでインストールする
```
$ npm install -g truffle
```

truffleを使ってSolidityプロジェクトのひな形を作成する
```
$ truffle init 
```

Ethereumとの接続にはHDWallet Providerと呼ばれるパッケージを用いる。同じくnpmでインストールする
```
$ npm install @truffle/hdwallet-provider
```

ERC規格に沿ったコントラクトのひな形としてOpenzeppelinというコントラクト群を使う。npmでインストールする
```
$ npm install @openzeppelin/contracts
```

EthereumのRinkebyネットワークに接続するためにtruffle-config.jsを編集する
```javascript: truffle-config.js
const HDWalletProvider = require('@truffle/hdwallet-provider');

// .secretにはMetamaskのMnemonicを配置する
const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();

module.exports = {
  networks: {
    rinkeby: {
      // HDWalletProviderに渡す第二引数には、Infraで作成したRinkeby用のAPIへのリンクを渡す
      provider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/9294406b354849b49052ee5d130fac9a`),
      network_id: 4,       
      gas: 5500000,        
      confirmations: 2,    
      timeoutBlocks: 200,  
      skipDryRun: true    
      },
  },

  mocha: {
  },
  compilers: {
    solc: {
      // Openzeppelinでは0.8.0以上のコントラクトが最新であるため、0.8.0以上にする
      version: "0.8.0",     
    }
  },
};
```

この状態で一度truffle consoleを試し、問題なく接続できたら環境はOK
以下は成功例
```
$ truffle console --network rinkeby
truffle(rinkeby)>
```

接続に成功したら一旦truffle consoleから抜ける  
Ctrl + C を2回入力すると抜けることができる

## デプロイ用のERC721コントラクトを作成し、コンパイルする
最低限トークンのMintまでできるコントラクトを作成する
```javascript: AvatarNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// openzeppelinのコントラクトをimport
import "../node_modules/@openzeppelin/contracts/token/erc721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract AvatarNFT is ERC721, Ownable {
    // tokenIdを順に設定していくためにCoounterライブラリを利用
    using Counters for Counters.Counter;

    // tokenのNameとSymbolを設定
    constructor() ERC721("Avatar", "AVT"){}

    // Counterライブラリを使って_tokenIdCounterを定義
    Counters.Counter private _tokenIdCounter;

    // Metadata格納場所の元となるbaseURIを設定
    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/otampy3184/metadata-okuyo/main/meta/";
    }
    
    // Mint機能
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        // 初回increment後のtokenIdは0
        _tokenIdCounter.increment();
        // 親コントラクトからMint機能を呼び出し
        _safeMint(to, tokenId);
    }
}
```

作成したコントラクトをコンパイルする
```
$ truffle compile
```
成功した場合はbuildフォルダができて、中にコントラクトのABI情報の入ったjsonファイルが生成される

## コントラクトのmigrate
コントラクトをEthereum上にMigrateするため、Migrationファイルを作成する
truffle initしたことによってmigrationsフォルダができているため、ファルダの下に新規でMigrationファイルを作成する
```javascript: 2_avatar.js
// requireに入れるのはコントラクトのファイル名ではなく、中で実装しているコントラクト名である点に注意
const AvatarNFT = artifacts.require("AvatarNFT");

module.exports = function (deployer) {
  deployer.deploy(AvatarNFT);
};
```

migrationファイルを使ってコントラクトを実際にmigrateする　　
```
$ truffle migrate --network rinkeby
```

migrateしたコントラクトを操作し、トークンをMintする
truffle console上ではWeb3.jsを使ってコントラクトと繋がるため、javascript形式で指示を入力する
```
$ truffle console --network rinkeby
truffle(rinkeby)> const AvatarContract = await AvatarNFT.deployed()
undifined
truffle(rinkeby)> AvatarContract.address
"<migrateしたコントラクトのアドレスが表示される>"
truffle(rinkeby)> AvatarContract.safeMint("<MetamaskのRinkeby側のアドレス>")
~~~
<Txのreceiptが表示される>
~~~
```

## Opensea上でNFTを確認する
トークンのミントが成功していた場合、Opensea上からNFTを確認することができる  
URLはhttps://testnets.opensea.io/assets/<migrateしたコントラクトのアドレス>/0

## 【補足】migrate以降の実行例 
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
