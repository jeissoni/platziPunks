// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";
import "./PunkDNA.sol";

contract PlatziPuns is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupplt;

    constructor(uint256 _maxSupply) ERC721("PlatziPuns", "PLPKS") {
        maxSupplt = _maxSupply;
    }

    // The following functions are overrides required by Solidity.
    // son funciones que son necesarias sobre escribir para
    // implementar el Enumerable
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mint() public {
        uint256 current = _idCounter.current();
        require(current < maxSupplt, "not platziPunks left :( ");

        _safeMint(msg.sender, current);
        _idCounter.increment();
    }


    //JSON en formato base 64
    function tokenURI(uint256 tokenID)
        public
        view
        override
        returns (string memory)
    {
        require(_exists(tokenID), "ERC721 MetadaData : URI query not exists");

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                ' {"name" : "PLatziPunks #" ',
                tokenID,
                '", "description": "NTF", "image": "',
                " //TODO: calculate image URL",
                '"}'
                ));

        return string(abi.encodePacked("data:application/json;base64", jsonURI));
    }
}
