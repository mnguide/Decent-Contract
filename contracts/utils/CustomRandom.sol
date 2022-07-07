// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;


contract CustomRandom {

    uint256 private seed1;
    uint256 private seed2;

    constructor(uint256 _seed1, uint256 _seed2) public{
        seed1 = _seed1;
        seed2 = _seed2;
    }

    function getRandom() public view returns (uint256) {
        // KLAY: 0x0000000000000000000000000000000000000000
        
        uint256 num = uint256(
            keccak256(
                abi.encodePacked(
                    seed1,
                    seed2,
                    block.timestamp,
                    msg.sender,
                    blockhash(block.number - 1)
                )
            )
        );
        return num % 100;
    }

}