pragma solidity ^0.5.0;

import "./KIP17Metadata.sol";
import "./ownership/Ownable.sol";
import "./math/SafeMath.sol";
import "./utils/String.sol";

contract Decent is KIP17Metadata, Ownable {

    address private proxyAddress;

    constructor (address _proxyAddress) internal {
        proxyAddress = _proxyAddress;
    }

    function changeProxyAddress(address _newProxyAddress) onlyOwner public {
        proxyAddress = _newProxyAddress;
    }

    struct Investor {
        string Job;
        string Charactor;
        string Passive1Name;
        string Passive2Name;
        string Passive3Name;
        uint256 Passive1Value;
        uint256 Passive2Value;
        uint256 Passive3Value;
        string AwakeningName;
        uint256 AwakeningValue;
    }

    mapping(uint256 => Investor) tokenIdToInvestors;

    function generateInvestor(uint256 _tokenId) internal {
        (bool success,) = proxyAddress.delegatecall(abi.encodeWithSignature("_generateInvestor(uint256)",_tokenId));
        require(success,"generation failed");
    }

    mapping (address => uint256) private _lastCallBlockNumber;
    uint256 private antibotInterval;

    function updateAntibotInterval(uint256 _interval) public onlyOwner {
        antibotInterval = _interval;
    }

    uint256 private invocations = 1;

    modifier onlyValidTokenId(uint256 _tokenId) {
        require(_exists(_tokenId), "Token ID does not exist");
        _;
    }

    string private projectBaseIpfsURI;
    function updateProjectBaseIpfsURI(string memory _projectBaseIpfsURI) public onlyOwner{
        projectBaseIpfsURI = _projectBaseIpfsURI;
    }
    function tokenURI(uint256 _tokenId) external view onlyValidTokenId(_tokenId) returns (string memory) {
        return bytes(projectBaseIpfsURI).length > 0
            ? string(abi.encodePacked(projectBaseIpfsURI, String.uint2str(_tokenId),".json"))
            : "";
    }

    uint256 private pricePerTokenInPeb;
    function updateProjectPricePerTokenInPeb(uint256 _price) public onlyOwner{
        pricePerTokenInPeb = _price;
    }

    function withdraw() external onlyOwner{
        (bool success,) = msg.sender.call.value(address(this).balance)("");
        require(success);
        // =============================================================================
    }

    uint256 private mintLimitPerBlock;
    function updateMintLimitPerBlock(uint256 _limit) onlyOwner public {
        mintLimitPerBlock = _limit;
    }

    uint256 private mintStartBlockNumber;
    function updateMintStartBlockNumber(uint256 _blockNumber)onlyOwner public {
        mintStartBlockNumber = _blockNumber;
    }

    uint256 private maxInvocations;
    function updateProjectMaxInvocations(uint256 _maxInvocations) onlyOwner public {
        maxInvocations = _maxInvocations;
    }

    function mintingInformation() public view returns (uint256 _antibotInterval, uint256 _mintLimitPerBlock, uint256 _mintStartBlockNumber, uint256 _price, uint256 _invocations, uint256 _maxInvocations){
        _antibotInterval=_antibotInterval;
        _mintLimitPerBlock=mintLimitPerBlock;
        _mintStartBlockNumber=mintStartBlockNumber;
        _price = pricePerTokenInPeb;
        _invocations = invocations;
        _maxInvocations = maxInvocations;
    }

    bool private active = true;
    function toggleActive() onlyOwner public{
        active = !active;
    }

    function publicMint(uint256 requestedCount) public payable {
        require(active, "The public sale is not enabled!");
        require(_lastCallBlockNumber[msg.sender].add(antibotInterval) < block.number, "Bot is not allowed");
        require(block.number >= mintStartBlockNumber, "Not yet started");
        require(requestedCount > 0 && requestedCount <= mintLimitPerBlock, "Too many requests or zero request");
        require(msg.value == pricePerTokenInPeb.mul(requestedCount), "Not enough Klay");
        require(invocations.add(requestedCount) <= maxInvocations + 1, "Exceed max amount");


        for(uint256 i = 0; i < requestedCount; i++) {
            invocations = invocations.add(1);
            _mint(msg.sender, invocations);
            generateInvestor(invocations);
        }
        _lastCallBlockNumber[msg.sender] = block.number;
    }

    //Whitelist Mint
    mapping(address => bool) internal whitelistClaimed;
    mapping(address => bool) public whitelistAddress;


    function addWhitelist(address _whitelistAddress) public onlyOwner {
        whitelistAddress[_whitelistAddress]=true;
    }

    function removeWhitelist(address _whitelistAddress) public onlyOwner {
        whitelistAddress[_whitelistAddress]=false;
    }

    bool private whitelistMintEnabled = false;
    function toggleWhitelistMintEnabled() public onlyOwner {
        whitelistMintEnabled = !whitelistMintEnabled;
    }

    function whitelistMint(uint256 requestedCount) public payable {
        require(whitelistMintEnabled, "The whitelist sale is not enabled!");
        require(msg.value == pricePerTokenInPeb.mul(requestedCount), "Not enough Klay");
        require(!whitelistClaimed[msg.sender], "Address already claimed!");
        require(whitelistAddress[msg.sender],"sender is not on Whitelist");
        require(requestedCount > 0 && requestedCount <= mintLimitPerBlock, "Too many requests or zero request");
       
        for(uint256 i = 0; i < requestedCount; i++) {
            invocations = invocations.add(1);
            _mint(msg.sender, invocations);
            generateInvestor(invocations);
        }
        whitelistClaimed[msg.sender]=true;
    }

    //Airdrop Mint
    function airDropMint(address user, uint256 requestedCount) public onlyOwner {
        require(requestedCount > 0, "zero request");
        for(uint256 i = 0; i < requestedCount; i++) {
            invocations = invocations.add(1);
            _mint(user, invocations);
            generateInvestor(invocations);
        }
    }
}