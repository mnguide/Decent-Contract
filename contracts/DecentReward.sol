pragma solidity ^0.5.0;

import "./KIP17Metadata.sol";
import "./ownership/Ownable.sol";
import "./math/SafeMath.sol";
import "./utils/String.sol";
import "./utils/CustomRandom.sol";

contract DecentReward is KIP17Metadata, Ownable, CustomRandom {
    address private MainAddress;
    uint256 private invocations;

    constructor(
        uint256 seed1,
        uint256 seed2
    ) public CustomRandom(seed1, seed2) {
    }

    modifier onlyFromMain() {
        require(msg.sender == MainAddress, "only proxyAddress");
        _;
    }

    modifier onlyValidTokenId(uint256 _tokenId) {
        require(_exists(_tokenId), "Token ID does not exist");
        _;
    }

    function setMainAddress(address _MainAddress) public onlyOwner {
        MainAddress = _MainAddress;
    }

    function getMainAddress() public view returns (address) {
        return MainAddress;
    }

    /*
    1 = "지인 찬스";
    2 = "유튜버의 조언";
    3 = "골드버튼 유튜버의 조언";
    4 = "상류층의 조언";
    5 = "신의 조언";
    6 = "유튜버의 빛나는 조언";
    7 = "골드버튼 유튜버의 빛나는 조언";
    8 = "상류층의 은밀한 조언";
    9 = "신의 확실한 조언";
    10 = "코인의 바람";
    11 = "주식의 바람";
    12 = "대지의 바람";
    13 = "변하지않는 진실";
    14 = "변하는 왜곡된 진실";
    15 = "희미한 각성의 빛";
    16 = "각성의 빛";
    17 = "화려한 각성의 빛"; 
    */

    uint256 private POTION1 = 1;
    uint256 private POTION2 = 2;
    uint256 private POTION3 = 3;
    uint256 private POTION4 = 4;
    uint256 private POTION5 = 5;
    uint256 private POTION6 = 6;
    uint256 private POTION7 = 7;
    uint256 private POTION8 = 8;
    uint256 private POTION9 = 9;
    uint256 private POTION10 = 10;
    uint256 private POTION11 = 11;
    uint256 private POTION12 = 12;
    uint256 private POTION13 = 13;
    uint256 private POTION14 = 14;
    uint256 private POTION15 = 15;
    uint256 private POTION16 = 16;
    uint256 private POTION17 = 17;

    mapping(uint256 => uint256) tokenIdToPotions;

    function getTokenPotionInfo(uint256 _tokenId) public view onlyValidTokenId(_tokenId) returns(uint256){
        return tokenIdToPotions[_tokenId];
    }
        /*
    stage code 

    101="다운 비트"
    102="셀넌스"
    103="마진 5배"
    104="마진 20배"
    105 ="마진 100배"

    201="부산 부동산"
    202="서울 부동산"
    203="뉴욕 부동산"
    204="한국 상가 매매"
    205="미국 상가 매매"

    301="코스닥"
    302="나스닥"
    303="선물 1구좌"
    304="선물 5구좌"
    305="선물 19구좌"

     */

    function rewardToken(address _to, uint256 _stage) public onlyFromMain {
        uint256 _randNum = getRandom(_stage);
        if (_stage == 101 || _stage == 201 || _stage == 301) {} else if (
            _stage == 102 || _stage == 202 || _stage == 302
        ) {} else if (
            _stage == 103 || _stage == 203 || _stage == 303
        ) {} else if (
            _stage == 104 || _stage == 204 || _stage == 304
        ) {} else if (_stage == 105 || _stage == 205 || _stage == 305) {}
        _mint(_to, invocations);
        tokenIdToPotions[invocations] = POTION1;
        invocations = invocations.add(1);
    }

    string private projectBaseIpfsURI;

    function setTokenURI(string memory _tokenURI) public onlyOwner {
        projectBaseIpfsURI = _tokenURI;
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
                        String.uint2str(_tokenId),"/",
                        tokenIdToPotions[invocations],
                        ".json"
                    )
                )
                : "";
    }
}