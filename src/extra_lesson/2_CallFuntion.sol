// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/*
    To call another function(A) using the data field of call in a function(B),
    - get the function selector of A -> this is the first 4 bytes of a function signature -> function signature is the function name and arguments
    - pass the selector to call, also include neccessary arguments

    OR

    use abi.encodeWithSignature() directly and include neccessary arguments
*/

contract CallFunction {
    address public s_address;
    uint256 public s_amount;

    function transfer(address _address, uint256 _amount) public {
        s_address = _address;
        s_amount = _amount;
    }

    function getTransferSelector() public pure returns (bytes4) {
        bytes4 selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
        // bytes4 selector = bytes4(keccak256(abi.encodePacked("transfer(address,uint256)")));

        return selector;
    }

    function indirectTransfer(address _address, uint256 _amount) public returns (bool, bytes memory) {
        (bool success, bytes memory returnedData) =
            address(this).call(abi.encodeWithSelector(getTransferSelector(), _address, _amount));

        return (success, returnedData);
    }

    function indirectTranserSig(address _address, uint256 _amount) public returns (bool, bytes memory) {
        (bool success, bytes memory returnedData) =
            address(this).call(abi.encodeWithSignature("transfer(address,uint256)", _address, _amount));

        return (success, returnedData);
    }
}
