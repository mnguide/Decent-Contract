pragma solidity ^0.5.0;

import "./KIP17Full.sol";

contract DecentToken is KIP17Full {
    constructor (string memory name, string memory symbol, address proxyAddress) public KIP17Full(name, symbol, proxyAddress) {
    }
}