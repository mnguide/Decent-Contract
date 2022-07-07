pragma solidity ^0.5.0;

import "./utils/CustomRandom.sol";

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
