// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    enum Mood {
        HAPPY,
        SAD
    }

    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory _happySvgImageUri, string memory _sadSvgImageUri) ERC721("MoodNft", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = _happySvgImageUri;
        s_sadSvgImageUri = _sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        string memory imageUri = s_tokenIdToMood[_tokenId] == Mood.HAPPY ? s_happySvgImageUri : s_sadSvgImageUri;

        // Go to Opensea and check any NFT detail to see what metadata looks like.
        // Typically
        /*
          {
            "name": "Egg",
            "description": "This egg has felt the turmoil of creation. And maybe, just maybe, it will feel it once more.",
            "external_url": null,
            "image": "ipfs://bafybeiffu3yjlmrirailxqlbwm3bbwhpyf6jp6kcjlghgplp4kjmewrdla/727",
            "attributes": [
              {
                "display_type": null,
                "trait_type": "tier",
                "value": "Common"
              }
            ]
          }
        */
        bytes memory tokenMetaData = abi.encodePacked(
            '{"name": "',
            name(),
            '", "description": "An NFT that reflects the owne mood", "attributes": "[{"display_type": "null", "trait_type": "moodiness", "value": 100}]", "image": "',
            imageUri,
            '"}'
        );

        return string(abi.encodePacked(_baseURI(), Base64.encode(bytes(tokenMetaData))));
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}
