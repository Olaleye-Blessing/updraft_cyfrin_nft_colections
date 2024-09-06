// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNft is ERC721{
  uint256 private s_tokenCounter;
  string private s_happySvg;
  string private s_sadSvg;

  constructor(string memory _happySvg, string memory _sadSvg) ERC721("MoodNft", "MN") {
    s_tokenCounter = 0;
    s_happySvg = _happySvg;
    s_sadSvg = _sadSvg;
  }

  function mintNft() public {
    _safeMint(msg.sender, s_tokenCounter);
    s_tokenCounter++;
  }
} 
