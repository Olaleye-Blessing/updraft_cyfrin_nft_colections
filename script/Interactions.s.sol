// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "./../src/BasicNft.sol";

contract MintBasicNft is Script {
    // gotten from Github: https://github.com/Cyfrin/foundry-nft-cu/blob/21c58165427b0806e149f2fbb0629d9d38d776b8/script/Interactions.s.sol#L10
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contratAddress) {
        vm.startBroadcast();
        BasicNft(contratAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}
