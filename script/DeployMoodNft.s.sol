// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "./../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happySvg = vm.readFile("./imgs/happy.svg");
        string memory sadSvg = vm.readFile("./imgs/sad.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImgUri(happySvg), svgToImgUri(sadSvg));
        vm.stopBroadcast();

        return moodNft;
    }

    function svgToImgUri(string memory _svg) public pure returns (string memory) {
        string memory baseUrl = "data:image/svg+xml;base64,";
        // This is because my svg files add an extra line after saving and
        // I don't want to disable this setting.
        string memory svgFileExtraLine = "\n";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg, svgFileExtraLine))));

        return string(abi.encodePacked(baseUrl, svgBase64Encoded));
    }
}
