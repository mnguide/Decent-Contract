// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

import "../math/SafeMath.sol";

contract CustomRandom {
    using SafeMath for uint256;
    uint256 private seed1;
    uint256 private seed2;
    uint256 private nonce = 0;

    constructor(uint256 _seed1, uint256 _seed2) public {
        seed1 = _seed1;
        seed2 = _seed2;
    }

    function getRandom(uint256 _nonce) public returns (uint256) {
        // KLAY: 0x0000000000000000000000000000000000000000

        uint256 num = uint256(
            keccak256(
                abi.encodePacked(
                    _nonce * seed1 * seed2 * nonce,
                    block.timestamp,
                    msg.sender,
                    address(this),
                    block.number,
                    blockhash(block.number - 1)
                )
            )
        );
        return num % 100;
        nonce = nonce.add(1);
    }
}
