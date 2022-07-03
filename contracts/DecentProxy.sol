pragma solidity ^0.5.0;

contract DecentProxy {

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


    function _generateInvestor(uint256 _tokenId) public {
        tokenIdToInvestors[_tokenId].Job = "j" ;
        tokenIdToInvestors[_tokenId].Charactor = "j" ;
        tokenIdToInvestors[_tokenId].Passive1Name = "" ;
        tokenIdToInvestors[_tokenId].Passive2Name = "" ;
        tokenIdToInvestors[_tokenId].Passive3Name = "" ;
        tokenIdToInvestors[_tokenId].Passive1Value = 7 ;
        tokenIdToInvestors[_tokenId].Passive2Value = 0 ;
        tokenIdToInvestors[_tokenId].Passive3Value = 0 ;
        tokenIdToInvestors[_tokenId].AwakeningName = "ggy" ;
        tokenIdToInvestors[_tokenId].AwakeningValue = 7 ;
    }
}