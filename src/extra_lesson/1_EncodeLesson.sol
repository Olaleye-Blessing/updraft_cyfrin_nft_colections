// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract EncodeLesson {
    function encodeNumber() public pure returns (bytes memory) {
        return abi.encode(3489);
    }

    function encodeString() public pure returns (bytes memory) {
        return abi.encode("some string");
    }

    // Difference between encode and encodePacked is encodePacked
    // removes unneccessary spacing.

    function encodeStringPacked() public pure returns (bytes memory) {
        return abi.encodePacked("some string");
    }

    function encodeStringBytes() public pure returns (bytes memory) {
        return bytes("some string");
    }

    function decodeString() public pure returns (string memory) {
        return abi.decode(encodeString(), (string));
    }

    function decodeNumber() public pure returns (uint256) {
        return abi.decode(encodeNumber(), (uint256));
    }

    // function decodeNumberString() public pure returns (string memory) {
    //     return string(abi.encodePacked(abi.decode(encodeNumber(), (uint))));
    // }
}
