// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Signature {

    mapping (address => bool) list;
    mapping (address => bool) public proposal;

    modifier whitelist {
        require(list[msg.sender] == true, "You address is not in whitelist!");
        _;
    }

    function signContract() public whitelist {
        proposal[msg.sender] = true;
    }

    function addToWhitelist(address _address) public {
        list[_address] = true;
    }
}