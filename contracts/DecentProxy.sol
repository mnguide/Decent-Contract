pragma solidity ^0.5.0;

import "./utils/CustomRandom.sol";

contract DecentProxy is CustomRandom {
    address public MainAddress;
    address public OwnerAddress;

    function customHash(string memory _string) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_string));
    }

    //variables
    string private JOB1 = "CRYPTO INVESTOR";
    string private JOB2 = "LAND INVESTOR";
    string private JOB3 = "STOCK INVESTOR";

    string private PASSIVE1 = "judgement";
    string private PASSIVE2 = "information power";
    string private PASSIVE3 = "insight";

    string private PERSONALITY1 = "stuffy";
    string private PERSONALITY2 = "foolish";
    string private PERSONALITY3 = "stupid";
    string private PERSONALITY4 = "normal";
    string private PERSONALITY5 = "cautious";
    string private PERSONALITY6 = "exhaustive";
    string private PERSONALITY7 = "intelligent";
    string private PERSONALITY8 = "phenomenal";

    string private AWAKENIGNANE1 = "존버 투자자";
    string private AWAKENIGNANE2 = "익절 투자자";
    string private AWAKENIGNANE3 = "수익 두배 투자자";
    string private AWAKENIGNANE4 = "람보르기니 투자자";
    string private AWAKENIGNANE5 = "상가 한채 투자자";
    string private AWAKENIGNANE6 = "슈퍼 투자자";

    //==============================
    bytes32 private Passive1Hash =
        0x88993362ef110885b3d82853b64529867e82f76382334fe6a34f40dd41c40bc3;
    bytes32 private Passive2Hash =
        0xa177e4e865c114731f054aa6379a0a8ae474aa2afaed0d591c83323e5d592f03;
    bytes32 private Passive3Hash =
        0x26f448b1920b93a1d8ecbd30dd2ae960d286161c174407752328eecfa26e088f;

    bytes32 private Job1Hash =
        0xd4e4b7d45ddfdfac19824055bd34ba31f0c17057a3bc789790b226918872383c;
    bytes32 private Job2Hash =
        0x03d92c677e6383c8791ef14e24d5be4b646d120245b0c1100ad9cf6d22ef8d1a;
    bytes32 private Job3Hash =
        0x1031511ae5fd7f05079793ef7d49680213208ec313484b734d2c72bfe1f9dc43;

    bytes32 private Personality1Hash =
        0xa4dc2f5426f17b19a35f761ee6fe04da88f3484b4fca3997de258942b7097b0f;
    bytes32 private Personality2Hash =
        0xbd9ae9edfb3f092a680172b894e845ab406f0a0786b59ad45a75be76672d8d3c;
    bytes32 private Personality3Hash =
        0x7071b71b760057caa0035a3d23f9d4435c0376a5f4558adc025198cf5ebcb183;
    bytes32 private Personality4Hash =
        0xc75a36e6ff8c24bab57c92d42ea7dcdecc261cbbf377444a0b6e3ec4e9129efe;
    bytes32 private Personality5Hash =
        0x36a0d128bdab6703326c3a16d2547edf1926b4d27502f1fcc69192b77398bc89;
    bytes32 private Personality6Hash =
        0x5b51217a7d0bd34699d06b636aa5e827af0abe77f9f3adba92e4b4aae7473bf1;
    bytes32 private Personality7Hash =
        0xf4c0a54006aa5dbaf5702b65a1fd76dce8ae5cd53329a812f270ef4d8705ecff;
    bytes32 private Personality8Hash =
        0x01df5cb4b29952f77486f83f2f8116e42116106afbc6aa0ef16893a87f31e13b;

    bytes32 private awakeningName1Hash =
        0x585a12a7a9b809c4cff534847ce927ced003d116887a71588c764bf05f50c277;
    bytes32 private awakeningName2Hash =
        0xd885bb7bf4c3e80bb924737a93ca0f21dfc5af8f66432a4450ad5a8f9e6bd4ab;
    bytes32 private awakeningName3Hash =
        0x5d70a2427b77936b385cbf8d7b29873005248b3f5a2cdfb2fc355f6c32b994af;
    bytes32 private awakeningName4Hash =
        0x8c3d575127b47fea39151ff524c6da3c90af1ae2346c0f4a425a544e4176de5b;
    bytes32 private awakeningName5Hash =
        0x30e754921b1357415b0c878081956f5d667d35c462a78eeac63afa3fef193260;
    bytes32 private awakeningName6Hash =
        0xaf85ddbeabf953c8aa2305da80fb3d39ce8a62cbb158a790cfdec9b149cfed47;
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

    function _decideJob(uint256 _nonce) internal returns (string memory) {
        uint256 _randNum = getRandom(_nonce);
        if (_randNum < 34) {
            return JOB1;
        } else if (34 <= _randNum && _randNum < 67) {
            return JOB2;
        } else {
            return JOB3;
        }
    }

    function _decidePersonality(uint256 _nonce)
        internal
        
        returns (string memory)
    {
        uint256 _randNum = getRandom(_nonce);
        if (_randNum < 19) {
            return PERSONALITY1;
        } else if (19 <= _randNum && _randNum < 39) {
            return PERSONALITY2;
        } else if (39 <= _randNum && _randNum < 58) {
            return PERSONALITY3;
        } else if (58 <= _randNum && _randNum < 69) {
            return PERSONALITY4;
        } else if (69 <= _randNum && _randNum < 80) {
            return PERSONALITY5;
        } else if (80 <= _randNum && _randNum < 88) {
            return PERSONALITY6;
        } else if (88 <= _randNum && _randNum < 96) {
            return PERSONALITY7;
        } else {
            return PERSONALITY8;
        }
    }

    function _decidePassiveName(uint256 _nonce)
        internal
        
        returns (string memory)
    {
        uint256 _randNum = getRandom(_nonce);
        if (_randNum < 33) {
            return PASSIVE3;
        } else if (_randNum >= 33 && _randNum < 66) {
            return PASSIVE2;
        }
        return PASSIVE1;
    }

    function _decidePassiveValue(uint256 _nonce)
        internal
        
        returns (uint256)
    {
        uint256 _randNum = getRandom(_nonce);
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

    function _decideAwakenName(uint256 _nonce)
        internal
        
        returns (string memory)
    {
        uint256 _randNum = getRandom(_nonce);
        if (_randNum < 33) {
            return AWAKENIGNANE1;
        } else if (_randNum >= 33 && _randNum < 59) {
            return AWAKENIGNANE2;
        } else if (_randNum >= 59 && _randNum < 79) {
            return AWAKENIGNANE3;
        } else if (_randNum >= 79 && _randNum < 92) {
            return AWAKENIGNANE4;
        } else if (_randNum >= 92 && _randNum < 98) {
            return AWAKENIGNANE5;
        }
        return AWAKENIGNANE6;
    }

    function NextPassive(uint256 _stage) internal  returns (bool) {
        uint256 _randNum = getRandom(_stage);
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

    function AwakenInvestor(uint256 _tokenId)
        public
        
        returns (string memory)
    {
        return _decideAwakenName(_tokenId);
    }

    function generateInvestor(uint256 _tokenId)
        public
        
        returns (
            string memory _Job,
            string memory _Personality,
            string memory _Passive1Name,
            string memory _Passive2Name,
            string memory _Passive3Name,
            uint256[3] memory _PassiveValues
        )
    {
        _Job = _decideJob(_tokenId);
        _Personality = _decidePersonality(_tokenId);
        _Passive1Name = _decidePassiveName(_tokenId);

        uint256[3] memory PassiveValues;
        uint256 _value1 = _decidePassiveValue(_tokenId);
        PassiveValues[0] = _value1;

        if (NextPassive(2)) {
            _Passive2Name = _decidePassiveName(_tokenId);
            uint256 _value2 = _decidePassiveValue(_tokenId);
            PassiveValues[1] = _value2;
            if (NextPassive(3)) {
                _Passive3Name = _decidePassiveName(_tokenId);
                uint256 _value3 = _decidePassiveValue(_tokenId);
                PassiveValues[2] = _value3;
            }
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
    ) public view returns (uint256) {
        uint256 power;
        bytes32 neededTalent;
        uint256 Passive1Status;
        uint256 Passive2Status;
        uint256 Passive3Status;

        bytes32 _jobHash = customHash(_job);
        bytes32 _personalityHash = customHash(_personality);
        bytes32 _passive1NameHash = customHash(_passive1Name);
        bytes32 _passive2NameHash = customHash(_passive2Name);
        bytes32 _passive3NameHash = customHash(_passive3Name);
        bytes32 _awakeningName = customHash(awakeningName);

        if (_jobHash == Job1Hash) {
            neededTalent = Passive1Hash;
        } else if (_jobHash == Job2Hash) {
            neededTalent = Passive2Hash;
        } else {
            neededTalent = Passive3Hash;
        }

        if (_personalityHash == Personality1Hash) {
            Passive2Status += 10;
        } else if (_personalityHash == Personality2Hash) {
            Passive1Status += 10;
        } else if (_personalityHash == Personality3Hash) {
            Passive3Status += 10;
        } else if (_personalityHash == Personality4Hash) {
            Passive1Status += 15;
            Passive2Status += 15;
            Passive3Status += 15;
        } else if (_personalityHash == Personality5Hash) {
            Passive1Status += 20;
            Passive2Status += 20;
            Passive3Status += 20;
        } else if (_personalityHash == Personality6Hash) {
            Passive1Status += 25;
            Passive2Status += 25;
            Passive3Status += 25;
        } else if (_personalityHash == Personality7Hash) {
            Passive1Status += 30;
            Passive2Status += 30;
            Passive3Status += 30;
        } else if (_personalityHash == Personality8Hash) {
            Passive1Status += 50;
            Passive2Status += 50;
            Passive3Status += 50;
        }

        if (_passive1NameHash == Passive1Hash) {
            Passive1Status += _passiveValues[0];
        } else if (_passive1NameHash == Passive2Hash) {
            Passive2Status += _passiveValues[0];
        } else if (_passive1NameHash == Passive3Hash) {
            Passive3Status += _passiveValues[0];
        }

        if (_passive2NameHash == Passive1Hash) {
            Passive1Status += _passiveValues[1];
        } else if (_passive2NameHash == Passive2Hash) {
            Passive2Status += _passiveValues[1];
        } else if (_passive2NameHash == Passive3Hash) {
            Passive3Status += _passiveValues[1];
        }

        if (_passive3NameHash == Passive1Hash) {
            Passive1Status += _passiveValues[2];
        } else if (_passive3NameHash == Passive2Hash) {
            Passive2Status += _passiveValues[2];
        } else if (_passive3NameHash == Passive3Hash) {
            Passive3Status += _passiveValues[2];
        }

        if (_awakeningName == awakeningName1Hash) {
            Passive1Status += 10;
            Passive2Status += 10;
            Passive3Status += 10;
        } else if (_awakeningName == awakeningName2Hash) {
            Passive1Status += 20;
            Passive2Status += 20;
            Passive3Status += 20;
        } else if (_awakeningName == awakeningName3Hash) {
            Passive1Status += 30;
            Passive2Status += 30;
            Passive3Status += 30;
        } else if (_awakeningName == awakeningName4Hash) {
            Passive1Status += 40;
            Passive2Status += 40;
            Passive3Status += 40;
        } else if (_awakeningName == awakeningName5Hash) {
            Passive1Status += 50;
            Passive2Status += 50;
            Passive3Status += 50;
        } else if (_awakeningName == awakeningName6Hash) {
            Passive1Status += 60;
            Passive2Status += 60;
            Passive3Status += 60;
        }

        if (neededTalent == Passive1Hash) {
            Passive1Status = (Passive1Status * synergyPercentage) / 100;
        } else if (neededTalent == Passive2Hash) {
            Passive2Status = (Passive2Status * synergyPercentage) / 100;
        } else if (neededTalent == Passive3Hash) {
            Passive3Status = (Passive3Status * synergyPercentage) / 100;
        }

        power += Passive1Status;
        power += Passive2Status;
        power += Passive3Status;
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

    function getStage(uint256 _tokenId) public returns (uint256) {
        (uint256 _power, bytes32 _job) = _getInvestorPowerAndJob(_tokenId);
        if (_job == Job1Hash) {
            if (_power <= 50) {
                return 101;
            } else if (50 < _power && _power <= 100) {
                return 102;
            } else if (100 < _power && _power <= 150) {
                return 103;
            } else if (150 < _power && _power <= 200) {
                return 104;
            } else {
                return 105;
            }
        } else if (_job == Job2Hash) {
            if (_power <= 50) {
                return 201;
            } else if (50 < _power && _power <= 100) {
                return 202;
            } else if (100 < _power && _power <= 150) {
                return 203;
            } else if (150 < _power && _power <= 200) {
                return 204;
            } else {
                return 205;
            }
        } else if (_job == Job3Hash) {
            if (_power <= 50) {
                return 301;
            } else if (50 < _power && _power <= 100) {
                return 302;
            } else if (100 < _power && _power <= 150) {
                return 303;
            } else if (150 < _power && _power <= 200) {
                return 304;
            } else {
                return 305;
            }
        }
    }
}
