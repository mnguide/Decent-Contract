// File: contracts\introspection\IKIP13.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the KIP-13 standard, as defined in the
 * [KIP-13](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard).
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others.
 *
 * For an implementation, see `KIP13`.
 */
interface IKIP13 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * [KIP-13 section](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard#how-interface-identifiers-are-defined)
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

pragma solidity ^0.5.0;

/**
 * @dev Implementation of the `IKIP13` interface.
 *
 * Contracts may inherit from this and call `_registerInterface` to declare
 * their support of an interface.
 */
contract KIP13 is IKIP13 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_KIP13 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor() internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for KIP13 itself here
        _registerInterface(_INTERFACE_ID_KIP13);
    }

    /**
     * @dev See `IKIP13.supportsInterface`.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId)
        external
        view
        returns (bool)
    {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual KIP13 interface is automatic and
     * registering its interface id is not required.
     *
     * See `IKIP13.supportsInterface`.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the KIP13 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "KIP13: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: contracts\IKIP17.sol

pragma solidity ^0.5.0;

/**
 * @dev Required interface of an KIP17 compliant contract.
 */
contract IKIP17 is IKIP13 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either `approve` or `setApproveForAll`.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public;

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either `approve` or `setApproveForAll`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public;

    function approve(address to, uint256 tokenId) public;

    function getApproved(uint256 tokenId)
        public
        view
        returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;

    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public;
}

// File: contracts\math\SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: contracts\utils\Address.sol

pragma solidity ^0.5.0;

/**
 * @dev Collection of functions related to the address type,
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * > It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}

// File: contracts\drafts\Counters.sol

pragma solidity ^0.5.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the SafeMath
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

// File: contracts\IERC721Receiver.sol

pragma solidity ^0.5.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes memory data
    ) public returns (bytes4);
}

// File: contracts\IKIP17Receiver.sol

pragma solidity ^0.5.0;

/**
 * @title KIP17 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from KIP17 asset contracts.
 * @dev see http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The KIP17 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onKIP17Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the KIP17 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`
     */
    function onKIP17Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes memory data
    ) public returns (bytes4);
}

// File: contracts\introspection\KIP13.sol

// File: contracts\KIP17.sol

pragma solidity ^0.5.0;

/**
 * @title KIP17 Non-Fungible Token Standard basic implementation
 * @dev see http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract KIP17 is KIP13, IKIP17 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IKIP17Receiver(0).onKIP17Received.selector`
    bytes4 private constant _KIP17_RECEIVED = 0x6745782b;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping(uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping(address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_KIP17 = 0x80ac58cd;

    constructor() public {
        // register the supported interfaces to conform to KIP17 via KIP13
        _registerInterface(_INTERFACE_ID_KIP17);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(
            owner != address(0),
            "KIP17: balance query for the zero address"
        );

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(
            owner != address(0),
            "KIP17: owner query for nonexistent token"
        );

        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "KIP17: approval to current owner");

        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "KIP17: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(
            _exists(tokenId),
            "KIP17: approved query for nonexistent token"
        );

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "KIP17: approve to caller");

        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use `safeTransferFrom` whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        //solhint-disable-next-line max-line-length
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "KIP17: transfer caller is not owner nor approved"
        );

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onKIP17Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onKIP17Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public {
        transferFrom(from, to, tokenId);
        require(
            _checkOnKIP17Received(from, to, tokenId, _data),
            "KIP17: transfer to non KIP17Receiver implementer"
        );
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(
            _exists(tokenId),
            "KIP17: operator query for nonexistent token"
        );
        address owner = ownerOf(tokenId);
        return (spender == owner ||
            getApproved(tokenId) == spender ||
            isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "KIP17: mint to the zero address");
        require(!_exists(tokenId), "KIP17: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(
            ownerOf(tokenId) == owner,
            "KIP17: burn of token that is not own"
        );

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) internal {
        require(
            ownerOf(tokenId) == from,
            "KIP17: transfer of token that is not own"
        );
        require(to != address(0), "KIP17: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to invoke `onKIP17Received` on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This function is deprecated.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnKIP17Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal returns (bool) {
        bool success;
        bytes memory returndata;

        if (!to.isContract()) {
            return true;
        }

        // Logic for compatibility with ERC721.
        (success, returndata) = to.call(
            abi.encodeWithSelector(
                _ERC721_RECEIVED,
                msg.sender,
                from,
                tokenId,
                _data
            )
        );
        if (
            returndata.length != 0 &&
            abi.decode(returndata, (bytes4)) == _ERC721_RECEIVED
        ) {
            return true;
        }

        (success, returndata) = to.call(
            abi.encodeWithSelector(
                _KIP17_RECEIVED,
                msg.sender,
                from,
                tokenId,
                _data
            )
        );
        if (
            returndata.length != 0 &&
            abi.decode(returndata, (bytes4)) == _KIP17_RECEIVED
        ) {
            return true;
        }

        return false;
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

// File: contracts\IKIP17Enumerable.sol

pragma solidity ^0.5.0;

/**
 * @title KIP-17 Non-Fungible Token Standard, optional enumeration extension
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Enumerable is IKIP17 {
    function totalSupply() public view returns (uint256);

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

// File: contracts\KIP17Enumerable.sol

pragma solidity ^0.5.0;

/**
 * @title KIP-17 Non-Fungible Token with optional enumeration extension logic
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract KIP17Enumerable is KIP13, KIP17, IKIP17Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_KIP17_ENUMERABLE = 0x780e9d63;

    /**
     * @dev Constructor function.
     */
    constructor() public {
        // register the supported interface to conform to KIP17Enumerable via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256)
    {
        require(
            index < balanceOf(owner),
            "KIP17Enumerable: owner index out of bounds"
        );
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract.
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens.
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(
            index < totalSupply(),
            "KIP17Enumerable: global index out of bounds"
        );
        return _allTokens[index];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) internal {
        super._transferFrom(from, to, tokenId);

        _removeTokenFromOwnerEnumeration(from, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to address the beneficiary that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);

        _addTokenToAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        _removeTokenFromOwnerEnumeration(owner, tokenId);
        // Since tokenId will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[tokenId] = 0;

        _removeTokenFromAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Gets the list of token IDs of the requested owner.
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner)
        internal
        view
        returns (uint256[] storage)
    {
        return _ownedTokens[owner];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param tokenId uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the _ownedTokensIndex mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId)
        private
    {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _ownedTokens[from].length--;

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param tokenId uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        // rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        // an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
    }
}

// File: contracts\IKIP17Metadata.sol

pragma solidity ^0.5.0;

/**
 * @title KIP-17 Non-Fungible Token Standard, optional metadata extension
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Metadata is IKIP17 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// File: contracts\KIP17Metadata.sol

pragma solidity ^0.5.0;

contract KIP17Metadata is KIP13, KIP17, KIP17Enumerable, IKIP17Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_KIP17_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor(string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to KIP17 via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_METADATA);
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }
}

pragma solidity ^0.5.0;

library String {
    function uint2str(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;
        while (_i != 0) {
            bstr[k--] = bytes1(uint8(48 + (_i % 10)));
            _i /= 10;
        }
        return string(bstr);
    }
}

// File: contracts\ownership\Ownable.sol

pragma solidity ^0.5.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be aplied to your functions to restrict their use to
 * the owner.
 */
contract Ownable {
    address payable private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address payable) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address payable newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address payable newOwner) internal {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Decent is KIP17Metadata, Ownable {
    //============================================================================
    // proxy settings
    //============================================================================

    address private proxyAddress;

    modifier onlyValidTokenId(uint256 _tokenId) {
        require(_exists(_tokenId), "Token ID does not exist");
        _;
    }

    modifier onlyTokenOwner(uint256 _tokenId) {
        require(
            ownerOf(_tokenId) == msg.sender,
            "You are not the owner of thin token"
        );
        _;
    }

    constructor(address _proxyAddress) internal {
        proxyAddress = _proxyAddress;
    }

    function changeProxyAddress(address _newProxyAddress) public onlyOwner {
        proxyAddress = _newProxyAddress;
    }

    function getProxyAddress() external view onlyOwner returns (address) {
        return proxyAddress;
    }

    //============================================================================
    // investor generation
    //============================================================================

    struct Investor {
        string Job;
        string Personality;
        string Passive1Name;
        string Passive2Name;
        string Passive3Name;
        uint256 Passive1Value;
        uint256 Passive2Value;
        uint256 Passive3Value;
        string AwakeningName;
    }

    mapping(uint256 => Investor) tokenIdToInvestors;

    function _generateInvestor(uint256 _tokenId)
        private
        onlyValidTokenId(_tokenId)
    {
        bytes memory payload = abi.encodeWithSignature("generateInvestor()");
        (bool success, bytes memory result) = proxyAddress.call(payload);

        (
            string memory _Job,
            string memory _Personality,
            string memory _Passive1Name,
            string memory _Passive2Name,
            string memory _Passive3Name,
            uint256[3] memory _PassiveValues
        ) = abi.decode(
                result,
                (string, string, string, string, string, uint256[3])
            );

        require(success, "generateInvestor failed");
        tokenIdToInvestors[_tokenId].Job = _Job;
        tokenIdToInvestors[_tokenId].Personality = _Personality;
        tokenIdToInvestors[_tokenId].Passive1Name = _Passive1Name;
        tokenIdToInvestors[_tokenId].Passive1Value = _PassiveValues[0];
        tokenIdToInvestors[_tokenId].Passive2Name = _Passive2Name;
        tokenIdToInvestors[_tokenId].Passive2Value = _PassiveValues[1];
        tokenIdToInvestors[_tokenId].Passive3Name = _Passive3Name;
        tokenIdToInvestors[_tokenId].Passive3Value = _PassiveValues[2];
    }

    function AwakenInvestor(uint256 _tokenId)
        external
        onlyTokenOwner(_tokenId)
    {
        if (
            tokenIdToInvestors[_tokenId].Passive1Value >= 45 &&
            tokenIdToInvestors[_tokenId].Passive2Value >= 45 &&
            tokenIdToInvestors[_tokenId].Passive3Value >= 45
        ) {
            bytes memory payload = abi.encodeWithSignature("AwakenInvestor()");
            (bool success, bytes memory result) = proxyAddress.call(payload);
            string memory _AwakeningName = abi.decode(result, (string));
            tokenIdToInvestors[_tokenId].AwakeningName = _AwakeningName;
            require(success, "AwakenInvestor failed");
        }
    }

    function InvestorInfo(uint256 _tokenId)
        public
        view
        returns (
            // onlyValidTokenId(_tokenId)
            string memory _Job,
            string memory _Personality,
            string memory _Passive1Name,
            string memory _Passive2Name,
            string memory _Passive3Name,
            string memory _AwakeningName,
            uint256[3] memory _PassiveValues
        )
    {
        _Job = tokenIdToInvestors[_tokenId].Job;
        _Personality = tokenIdToInvestors[_tokenId].Personality;
        _Passive1Name = tokenIdToInvestors[_tokenId].Passive1Name;
        _Passive2Name = tokenIdToInvestors[_tokenId].Passive2Name;
        _Passive3Name = tokenIdToInvestors[_tokenId].Passive3Name;
        _AwakeningName = tokenIdToInvestors[_tokenId].AwakeningName;
        _PassiveValues = [
            tokenIdToInvestors[_tokenId].Passive1Value,
            tokenIdToInvestors[_tokenId].Passive2Value,
            tokenIdToInvestors[_tokenId].Passive3Value
        ];
    }

    //============================================================================
    //growing logics
    //============================================================================
    uint256 private battleCycleTime = 3600;

    function updateBattleCycleTime(uint256 _blockNumber) public onlyOwner {
        battleCycleTime = _blockNumber;
    }

    struct battleInfo {
        uint256 blockStamp;
        string stage;
        bool onbattle;
    }
    mapping(uint256 => battleInfo) private tokenIdToBattleInfo;

    function startBattle(uint256 _tokenId) public onlyTokenOwner(_tokenId) {
        require(
            !tokenIdToBattleInfo[_tokenId].onbattle,
            "investor already on battle"
        );
        tokenIdToBattleInfo[_tokenId].blockStamp = block.number;

        bytes memory payload = abi.encodeWithSignature("getStage()", _tokenId);
        (bool success, bytes memory result) = proxyAddress.call(payload);
        require(success, "getStage failed");

        string memory _stage = abi.decode(result, (string));

        tokenIdToBattleInfo[_tokenId].stage = _stage;
        tokenIdToBattleInfo[_tokenId].onbattle = true;
    }

    function isOnBattle(uint256 _tokenId) public view returns (bool) {
        return
            (tokenIdToBattleInfo[_tokenId].blockStamp + battleCycleTime) >
            block.number;
    }

    function endBattle(uint256 _tokenId) public onlyTokenOwner(_tokenId) {
        tokenIdToBattleInfo[_tokenId].onbattle = false;
        // if (
        //     (block.number - tokenIdToBattleInfo[_tokenId].blockStamp >
        //         battleCycleTime)
        // ) {
        //     // rewarding function is needed
        // }
    }

    //============================================================================
    // minting logics
    //============================================================================

    mapping(address => uint256) private _lastCallBlockNumber;
    uint256 private antibotInterval;

    function updateAntibotInterval(uint256 _interval) public onlyOwner {
        antibotInterval = _interval;
    }

    uint256 private invocations = 1;

    string private projectBaseIpfsURI;

    function updateProjectBaseIpfsURI(string memory _projectBaseIpfsURI)
        public
        onlyOwner
    {
        projectBaseIpfsURI = _projectBaseIpfsURI;
    }

    function tokenURI(uint256 _tokenId)
        external
        view
        onlyValidTokenId(_tokenId)
        returns (string memory)
    {
        return
            bytes(projectBaseIpfsURI).length > 0
                ? string(
                    abi.encodePacked(
                        projectBaseIpfsURI,
                        String.uint2str(_tokenId),
                        ".json"
                    )
                )
                : "";
    }

    uint256 private pricePerTokenInPeb;

    function updateProjectPricePerTokenInPeb(uint256 _price) public onlyOwner {
        pricePerTokenInPeb = _price;
    }

    function withdraw() external onlyOwner {
        (bool success, ) = msg.sender.call.value(address(this).balance)("");
        require(success);
        // =============================================================================
    }

    uint256 private mintLimitPerBlock;

    function updateMintLimitPerBlock(uint256 _limit) public onlyOwner {
        mintLimitPerBlock = _limit;
    }

    uint256 private mintStartBlockNumber;

    function updateMintStartBlockNumber(uint256 _blockNumber) public onlyOwner {
        mintStartBlockNumber = _blockNumber;
    }

    uint256 private maxInvocations;

    function updateProjectMaxInvocations(uint256 _maxInvocations)
        public
        onlyOwner
    {
        maxInvocations = _maxInvocations;
    }

    function mintingInformation() public view returns (uint256[6] memory) {
        return [
            antibotInterval,
            mintLimitPerBlock,
            mintStartBlockNumber,
            pricePerTokenInPeb,
            invocations,
            maxInvocations
        ];
    }

    bool private active = true;

    function toggleActive() public onlyOwner {
        active = !active;
    }

    function publicMint(uint256 requestedCount) public payable {
        require(active, "The public sale is not enabled!");
        require(
            _lastCallBlockNumber[msg.sender].add(antibotInterval) <
                block.number,
            "Bot is not allowed"
        );
        require(block.number >= mintStartBlockNumber, "Not yet started");
        require(
            requestedCount > 0 && requestedCount <= mintLimitPerBlock,
            "Too many requests or zero request"
        );
        require(
            msg.value == pricePerTokenInPeb.mul(requestedCount),
            "Not enough Klay"
        );
        require(
            invocations.add(requestedCount) <= maxInvocations + 1,
            "Exceed max amount"
        );

        for (uint256 i = 0; i < requestedCount; i++) {
            _mint(msg.sender, invocations);
            _generateInvestor(invocations);
            invocations = invocations.add(1);
        }
        _lastCallBlockNumber[msg.sender] = block.number;
    }

    //Whitelist Mint
    mapping(address => bool) internal whitelistClaimed;
    mapping(address => bool) public whitelistAddress;

    function addWhitelist(address _whitelistAddress) public onlyOwner {
        whitelistAddress[_whitelistAddress] = true;
    }

    function removeWhitelist(address _whitelistAddress) public onlyOwner {
        whitelistAddress[_whitelistAddress] = false;
    }

    bool private whitelistMintEnabled = false;

    function toggleWhitelistMintEnabled() public onlyOwner {
        whitelistMintEnabled = !whitelistMintEnabled;
    }

    function whitelistMint(uint256 requestedCount) public payable {
        require(whitelistMintEnabled, "The whitelist sale is not enabled!");
        require(
            msg.value == pricePerTokenInPeb.mul(requestedCount),
            "Not enough Klay"
        );
        require(!whitelistClaimed[msg.sender], "Address already claimed!");
        require(whitelistAddress[msg.sender], "sender is not on Whitelist");
        require(
            requestedCount > 0 && requestedCount <= mintLimitPerBlock,
            "Too many requests or zero request"
        );

        for (uint256 i = 0; i < requestedCount; i++) {
            _mint(msg.sender, invocations);
            _generateInvestor(invocations);
            invocations = invocations.add(1);
        }
        whitelistClaimed[msg.sender] = true;
    }

    //Airdrop Mint
    function airDropMint(address user, uint256 requestedCount)
        public
        onlyOwner
    {
        require(requestedCount > 0, "zero request");
        for (uint256 i = 0; i < requestedCount; i++) {
            _mint(user, invocations);
            _generateInvestor(invocations);
            invocations = invocations.add(1);
        }
    }
}

// File: contracts\KIP17Full.sol

pragma solidity ^0.5.0;

/**
 * @title Full KIP-17 Token
 * This implementation includes all the required and some optional functionality of the KIP-17 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract KIP17Full is KIP17, KIP17Enumerable, KIP17Metadata, Decent {
    constructor(
        string memory name,
        string memory symbol,
        address proxyAddress
    ) public KIP17Metadata(name, symbol) Decent(proxyAddress) {
        // solhint-disable-previous-line no-empty-blocks
    }
}

pragma solidity ^0.5.0;

contract DecentToken is KIP17Full {
    constructor(
        string memory name,
        string memory symbol,
        address proxyAddress
    ) public KIP17Full(name, symbol, proxyAddress) {}
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

contract CustomRandom {
    uint256 private seed1;
    uint256 private seed2;

    constructor(uint256 _seed1, uint256 _seed2) public {
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

pragma solidity ^0.5.0;

contract DecentProxy is CustomRandom {
    address public MainAddress;
    address public OwnerAddress;

    function customHash(string memory _string) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(_string));
    }

    //==============================
    bytes32 private judgement = customHash("judgement");
    bytes32 private information = customHash("information power");
    bytes32 private insight = customHash("insight");

    bytes32 private Job1 = customHash("CRYPTO INVESTOR");
    bytes32 private Job2 = customHash("LAND INVESTOR");
    bytes32 private Job3 = customHash("STOCK INVESTOR");

    bytes32 private stuffy = customHash("stuffy");
    bytes32 private foolish = customHash("foolish");
    bytes32 private stupid = customHash("stupid");
    bytes32 private normal = customHash("normal");
    bytes32 private cautious = customHash("cautious");
    bytes32 private exhaustive = customHash("exhaustive");
    bytes32 private intelligent = customHash("intelligent");
    bytes32 private phenomenal = customHash("phenomenal");

    bytes32 private awakeningName1 = customHash("존버 투자자");
    bytes32 private awakeningName2 = customHash("익절 투자자");
    bytes32 private awakeningName3 = customHash("수익 두배 투자자");
    bytes32 private awakeningName4 = customHash("람보르기니 투자자");
    bytes32 private awakeningName5 = customHash("상가 한채 투자자");
    bytes32 private awakeningName6 = customHash("슈퍼 투자자");
    //=============================

    modifier onlyOwner() {
        require(msg.sender == OwnerAddress, "not a owner");
        _;
    }

    function setMainAddress(address _newMainAddress) public onlyOwner {
        MainAddress = _newMainAddress;
    }

    constructor(uint256 seed1, uint256 seed2)
        public
        CustomRandom(seed1, seed2)
    {
        OwnerAddress = msg.sender;
    }

    function _decideJob() internal view returns (string memory) {
        uint256 _randNum = getRandom();
        if (_randNum < 34) {
            return "CRYPTO INVESTOR";
        } else if (34 <= _randNum && _randNum < 67) {
            return "LAND INVESTOR";
        } else {
            return "STOCK INVESTOR";
        }
    }

    function _decidePersonality() internal view returns (string memory) {
        uint256 _randNum = getRandom();
        if (_randNum < 19) {
            return "stuffy";
        } else if (19 <= _randNum && _randNum < 39) {
            return "follish";
        } else if (39 <= _randNum && _randNum < 58) {
            return "stupid";
        } else if (58 <= _randNum && _randNum < 69) {
            return "normal";
        } else if (69 <= _randNum && _randNum < 80) {
            return "cautious";
        } else if (80 <= _randNum && _randNum < 88) {
            return "exhaustive";
        } else if (88 <= _randNum && _randNum < 96) {
            return "intelligent";
        } else {
            return "phenomenal";
        }
    }

    function _decidePassiveName() internal view returns (string memory) {
        uint256 _randNum = getRandom();
        if (_randNum < 33) {
            return "insight";
        } else if (_randNum >= 33 && _randNum < 66) {
            return "information power";
        }
        return "judgement";
    }

    function _decidePassiveValue() internal view returns (uint256) {
        uint256 _randNum = getRandom();
        if (_randNum < 32) {
            return 10;
        } else if (32 <= _randNum && _randNum < 56) {
            return 15;
        } else if (56 <= _randNum && _randNum < 75) {
            return 20;
        } else if (75 <= _randNum && _randNum < 87) {
            return 25;
        } else if (87 <= _randNum && _randNum < 93) {
            return 30;
        } else if (93 <= _randNum && _randNum < 96) {
            return 35;
        } else if (96 <= _randNum && _randNum < 98) {
            return 40;
        } else if (98 <= _randNum && _randNum < 99) {
            return 45;
        } else {
            return 50;
        }
    }

    function _decideAwakenName() internal view returns (string memory) {
        uint256 _randNum = getRandom();
        if (_randNum < 33) {
            return "존버 투자자";
        } else if (_randNum >= 33 && _randNum < 59) {
            return "익절 투자자";
        } else if (_randNum >= 59 && _randNum < 79) {
            return "수익 두배 투자자";
        } else if (_randNum >= 79 && _randNum < 92) {
            return "람보르기니 투자자";
        } else if (_randNum >= 92 && _randNum < 98) {
            return "상가 한채 투자자";
        }
        return "슈퍼 투자자";
    }

    function NextPassive(uint256 _stage) internal view returns (bool) {
        uint256 _randNum = getRandom();
        if (_stage == 2) {
            if (_randNum < 50) {
                return true;
            }
            return false;
        } else if (_stage == 3) {
            if (_randNum < 30) {
                return true;
            }
            return false;
        }
    }

    function AwakenInvestor() public view returns (string memory) {
        return _decideAwakenName();
    }

    function generateInvestor()
        public
        view
        returns (
            string memory _Job,
            string memory _Personality,
            string memory _Passive1Name,
            string memory _Passive2Name,
            string memory _Passive3Name,
            uint256[3] memory _PassiveValues
        )
    {
        _Job = _decideJob();
        _Personality = _decidePersonality();
        _Passive1Name = _decidePassiveName();

        uint256[3] memory PassiveValues;
        uint256 _value1 = _decidePassiveValue();
        PassiveValues[0] = _value1;

        if (NextPassive(2)) {
            _Passive2Name = _decidePassiveName();
            uint256 _value2 = _decidePassiveValue();
            PassiveValues[1] = _value2;
        }
        if (NextPassive(3)) {
            _Passive3Name = _decidePassiveName();
            uint256 _value3 = _decidePassiveValue();
            PassiveValues[2] = _value3;
        }
        _PassiveValues = PassiveValues;
    }

    uint256 public synergyPercentage = 100;

    function setSynergyPercentage(uint256 _percentage) public onlyOwner {
        synergyPercentage = _percentage;
    }

    function _calculatePower(
        string memory _job,
        string memory _personality,
        string memory _passive1Name,
        string memory _passive2Name,
        string memory _passive3Name,
        string memory awakeningName,
        uint256[3] memory _passiveValues
    ) internal view returns (uint256) {
        uint256 power;
        bytes32 neededTalent;
        uint256 judgementStatus;
        uint256 informationPowerStatus;
        uint256 insightStatus;

        bytes32 _jobHash = customHash(_job);
        bytes32 _personalityHash = customHash(_personality);
        bytes32 _passive1NameHash = customHash(_passive1Name);
        bytes32 _passive2NameHash = customHash(_passive2Name);
        bytes32 _passive3NameHash = customHash(_passive3Name);
        bytes32 _awakeningName = customHash(awakeningName);

        if (_jobHash == Job1) {
            neededTalent = judgement;
        } else if (_jobHash == Job2) {
            neededTalent = information;
        } else {
            neededTalent = insight;
        }

        if (_personalityHash == stuffy) {
            informationPowerStatus += 10;
        } else if (_personalityHash == foolish) {
            judgementStatus += 10;
        } else if (_personalityHash == stupid) {
            insightStatus += 10;
        } else if (_personalityHash == normal) {
            judgementStatus += 15;
            informationPowerStatus += 15;
            insightStatus += 15;
        } else if (_personalityHash == cautious) {
            judgementStatus += 20;
            informationPowerStatus += 20;
            insightStatus += 20;
        } else if (_personalityHash == exhaustive) {
            judgementStatus += 25;
            informationPowerStatus += 25;
            insightStatus += 25;
        } else if (_personalityHash == intelligent) {
            judgementStatus += 30;
            informationPowerStatus += 30;
            insightStatus += 30;
        } else {
            judgementStatus += 50;
            informationPowerStatus += 50;
            insightStatus += 50;
        }

        if (_passive1NameHash == judgement) {
            judgementStatus += _passiveValues[0];
        } else if (_passive1NameHash == information) {
            informationPowerStatus += _passiveValues[0];
        } else if (_passive1NameHash == insight) {
            insightStatus += _passiveValues[0];
        }

        if (_passive2NameHash == judgement) {
            judgementStatus += _passiveValues[1];
        } else if (_passive2NameHash == information) {
            informationPowerStatus += _passiveValues[1];
        } else if (_passive2NameHash == insight) {
            insightStatus += _passiveValues[1];
        }

        if (_passive3NameHash == judgement) {
            judgementStatus += _passiveValues[2];
        } else if (_passive3NameHash == information) {
            informationPowerStatus += _passiveValues[2];
        } else if (_passive3NameHash == insight) {
            insightStatus += _passiveValues[2];
        }

        if (_awakeningName == awakeningName1) {
            judgementStatus += 10;
            informationPowerStatus += 10;
            insightStatus += 10;
        } else if (_awakeningName == awakeningName2) {
            judgementStatus += 20;
            informationPowerStatus += 20;
            insightStatus += 20;
        } else if (_awakeningName == awakeningName3) {
            judgementStatus += 30;
            informationPowerStatus += 30;
            insightStatus += 30;
        } else if (_awakeningName == awakeningName4) {
            judgementStatus += 40;
            informationPowerStatus += 40;
            insightStatus += 40;
        } else if (_awakeningName == awakeningName5) {
            judgementStatus += 50;
            informationPowerStatus += 50;
            insightStatus += 50;
        } else if (_awakeningName == awakeningName6) {
            judgementStatus += 60;
            informationPowerStatus += 60;
            insightStatus += 60;
        }

        if (neededTalent == judgement) {
            judgementStatus = (judgementStatus * synergyPercentage) / 100;
        } else if (neededTalent == information) {
            informationPowerStatus =
                (informationPowerStatus * synergyPercentage) /
                100;
        } else if (neededTalent == insight) {
            insightStatus = (insightStatus * synergyPercentage) / 100;
        }

        power += judgementStatus;
        power += informationPowerStatus;
        power += insightStatus;
        return power;
    }

    function _getInvestorPowerAndJob(uint256 _tokenId)
        internal
        returns (uint256 _power, bytes32 _job)
    {
        bytes memory payload = abi.encodeWithSignature(
            "InvestorInfo(uint256)",
            _tokenId
        );
        (bool success, bytes memory result) = MainAddress.call(payload);
        require(success, "InvestorInfo failed");
        (
            string memory job,
            string memory personality,
            string memory passive1Name,
            string memory passive2Name,
            string memory passive3Name,
            string memory awakeningName,
            uint256[3] memory passiveValues
        ) = abi.decode(
                result,
                (string, string, string, string, string, string, uint256[3])
            );
        _power = _calculatePower(
            job,
            personality,
            passive1Name,
            passive2Name,
            passive3Name,
            awakeningName,
            passiveValues
        );
        _job = customHash(job);
    }

    function getStage(uint256 _tokenId) public returns (string memory) {
        (uint256 _power, bytes32 _job) = _getInvestorPowerAndJob(_tokenId);
        if (_job == Job1) {
            if (_power <= 50) {
                return "다운 비트 ";
            } else if (50 < _power && _power <= 100) {
                return "셀넌스";
            } else if (100 < _power && _power <= 150) {
                return "마진 5배";
            } else if (150 < _power && _power <= 200) {
                return "마진 20배";
            } else {
                return "마진 100배";
            }
        } else if (_job == Job2) {
            if (_power <= 50) {
                return "부산 부동산";
            } else if (50 < _power && _power <= 100) {
                return "서울 부동산";
            } else if (100 < _power && _power <= 150) {
                return "뉴욕 부동산";
            } else if (150 < _power && _power <= 200) {
                return "한국 상가 매매";
            } else {
                return "미국 상가 매매";
            }
        } else if (_job == Job3) {
            if (_power <= 50) {
                return "코스닥";
            } else if (50 < _power && _power <= 100) {
                return "나스닥";
            } else if (100 < _power && _power <= 150) {
                return "선물 1구좌";
            } else if (150 < _power && _power <= 200) {
                return "선물 5구좌";
            } else {
                return "선물 19구좌";
            }
        }
    }
}
