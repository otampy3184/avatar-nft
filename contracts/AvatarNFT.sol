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