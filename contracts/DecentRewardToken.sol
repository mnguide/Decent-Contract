pragma solidity ^0.5.0;

import "./KIP17.sol";
import "./KIP17Enumerable.sol";
import "./KIP17Metadata.sol";
import "./DecentReward.sol";

/**
 * @title Full KIP-17 Token
 * This implementation includes all the required and some optional functionality of the KIP-17 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract DecentRewardToken is
    KIP17,
    KIP17Enumerable,
    KIP17Metadata,
    DecentReward
{
    constructor(
        string memory name,
        string memory symbol,
        uint256 seed1,
        uint256 seed2
    ) public KIP17Metadata(name, symbol) DecentReward(seed1, seed2) {
        // solhint-disable-previous-line no-empty-blocks
    }
}
