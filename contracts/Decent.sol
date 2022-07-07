pragma solidity ^0.5.0;
// pragma experimental ABIEncoderV2;
import "./KIP17Metadata.sol";
import "./ownership/Ownable.sol";
import "./math/SafeMath.sol";
import "./utils/String.sol";

contract Decent is KIP17Metadata, Ownable {
    address private proxyAddress;

    modifier onlyValidTokenId(uint256 _tokenId) {
        require(_exists(_tokenId), "Token ID does not exist");
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

    function _generateInvestor(uint256 _tokenId) private onlyValidTokenId {
        bytes memory payload = abi.encodeWithSignature("_generateInvestor()");
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

        require(success, "_generateInvestor failed");
        tokenIdToInvestors[_tokenId].Job = _Job;
        tokenIdToInvestors[_tokenId].Personality = _Personality;
        tokenIdToInvestors[_tokenId].Passive1Name = _Passive1Name;
        tokenIdToInvestors[_tokenId].Passive1Value = _PassiveValues[0];
        tokenIdToInvestors[_tokenId].Passive2Name = _Passive2Name;
        tokenIdToInvestors[_tokenId].Passive2Value = _PassiveValues[1];
        tokenIdToInvestors[_tokenId].Passive3Name = _Passive3Name;
        tokenIdToInvestors[_tokenId].Passive3Value = _PassiveValues[2];
    }

    function AwakenInvestor(uint256 _tokenId) external {
        require(
            ownerOf(_tokenId) == msg.sender,
            "You are not the owner of thin token"
        );
        if (
            tokenIdToInvestors[_tokenId].Passive1Value >= 45 &&
            tokenIdToInvestors[_tokenId].Passive2Value >= 45 &&
            tokenIdToInvestors[_tokenId].Passive3Value >= 45
        ) {
            bytes memory payload = abi.encodeWithSignature("_AwakenInvestor()");
            (bool success, bytes memory result) = proxyAddress.call(payload);
            string memory _AwakeningName = abi.decode(result, (string));
            tokenIdToInvestors[_tokenId].AwakeningName = _AwakeningName;
            require(success, "_AwakenInvestor failed");
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
