// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/erc721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract AvatarNFT is ERC721, Ownable {
    // おまじない
    using Counters for Counters.Counter;

    // 適当にコンストラクタ
    constructor() ERC721("Avatar", "AVT"){}

    // かうんたー
    Counters.Counter private _tokenIdCounter;

    // Metadata格納場所のURI
    function _baseURI() internal pure override returns (string memory) {
        return "https://github.com/otampy3184/metadata-okuyo/tree/main/meta";
    }
    
    // みんと
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}