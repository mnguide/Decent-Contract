// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

contract CustomRandom {
    uint256 private seed1;
    uint256 private seed2;
    uint256 private nonce;

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
                    blockhash(block.number - nonce + 1)
                )
            )
        );
        nonce = nonce + (num % 100);
        return num % 100;
    }
}
