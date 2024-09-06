// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployBasciNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public USER = makeAddr("user");
    // gotten from Github: https://github.com/Cyfrin/foundry-nft-cu/blob/21c58165427b0806e149f2fbb0629d9d38d776b8/script/Interactions.s.sol#L10
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function test_nameIsCorrect() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
        // the above and below does the same thing. The below is just using foundry function.
        assertEq(expectedName, actualName);
    }

    function test_canMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assertEq(basicNft.balanceOf(USER), 1);
        assertEq(basicNft.tokenURI(0), PUG_URI);
    }
}
