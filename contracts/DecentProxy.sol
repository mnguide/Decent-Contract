pragma solidity ^0.5.0;

import "./utils/CustomRandom.sol";

contract DecentProxy is CustomRandom {

    constructor(uint256 seed1, uint256 seed2)  public CustomRandom(seed1,seed2){
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

    function _AwakenInvestor() public view returns(string memory) {
            return _decideAwakenName();
    }

    function _generateInvestor() public view returns(string memory _Job, string memory _Personality, string memory _Passive1Name, string memory _Passive2Name, string memory _Passive3Name, uint256[3] memory _PassiveValues) {
        _Job = _decideJob();
        _Personality = _decidePersonality();
        _Passive1Name= _decidePassiveName();
      
        uint256[3] memory PassiveValues ;
        uint256 _value1 =_decidePassiveValue();
        PassiveValues[0] = _value1;

        if (NextPassive(2)) {
            _Passive2Name = _decidePassiveName();
            uint256 _value2 =_decidePassiveValue();
            PassiveValues[1] = _value2 ;
        }
        if (NextPassive(3)) {
            _Passive3Name = _decidePassiveName();
            uint256 _value3 =_decidePassiveValue();
            PassiveValues[2] = _value3;
        }
        _PassiveValues = PassiveValues;
    }
    
}
