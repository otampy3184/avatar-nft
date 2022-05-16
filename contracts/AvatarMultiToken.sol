// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/erc1155/ERC1155.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract AvatarMultiToken is ERC1155 {
    using Counters for Counters.Counter;
    Counters.Couter private _tokenCounter;

    // ネタの文字列を数字で表す
    uint256 public constant IKKAKU = 0;
    uint256 public constant SAVATHUN = 1;
    uint256 public constant DEER = 2;

    string baseMetadataURIPrefix;
    string baseMetadataURISuffix;

    constructor() ERC1155("") {
        baseMetadataURIPrefix = "https://firebasestorage.googleapis.com/v0/b/solidity-sandbox.appspot.com/o/erc1155example%2Fmetadata%2F";
        baseMetadataURISuffix = ".json?alt=media";

        _mint(msg.sender, IKKAKU, 100, "");
        _mint(msg.sender, SAVATHUN, 100, "");
        _mint(msg.sender, DEER, 100, "");
    }

    function uri(uint256 _id) public view override returns (string memory ) {
        return string(abi.encodePacked(
            baseMetadataURIPrefix,
            string.toString(_id),
            baseMetadataURISuffix
        ));
    }

    function mint(uint256 _tokenId, uint256 _amount) public {
        _mint(msg.sender, _tokenIds, _amounts, "");
    }

        function mintBatch(uint256[] memory _tokenIds, uint256[] memory _amounts) public {
        _mintBatch(msg.sender, _tokenIds, _amounts, "");
    }

    function setBaseMetadataURI(string memory _prefix, string memory _suffix) public {
        baseMetadataURIPrefix = _prefix;
        baseMetadataURISuffix = _suffix;
    }
    
}

