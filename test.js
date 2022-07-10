const { pkey, addr } = require("./secret.js");
const CONTRACT = require("./build/contracts/DecentToken.json");
const CONTRACT2 = require("./build/contracts/DecentProxy.json");

const Caver = require("caver-js");
const rpcURL = "https://api.baobab.klaytn.net:8651/";
const caver = new Caver(rpcURL);

const temp = caver.klay.accounts.createWithAccountKey(addr, pkey);
caver.klay.accounts.wallet.add(temp);

const networkID = "1001";
const deployedNetworkAddress = CONTRACT.networks[networkID].address;
const contract = new caver.klay.Contract(CONTRACT.abi, deployedNetworkAddress);

const deployedNetworkAddress2 = CONTRACT2.networks[networkID].address;
const contract2 = new caver.klay.Contract(
  CONTRACT2.abi,
  deployedNetworkAddress2
);

const generateInvestor = (_count) => {
  contract.methods.airDropMint(addr, _count).send({
    from: addr,
    gas: "8500000",
  });
};

const mintingInformation = async () => {
  const res = await contract.methods.mintingInformation().call();
  console.log(res);
  return res;
};

const _InvestorInfo = (_tokenId) => {
  contract.methods
    .InvestorInfo(_tokenId)
    .call()
    .then((res) => {
      console.log(`${_tokenId}`, res);
    });
};

const InvestorInfo = (_tokenId) => {
  contract.methods
    .InvestorInfo(_tokenId)
    .call()
    .then((res) => {
      console.log(res);
    });
};

const _calculatePower = (
  _job,
  _personality,
  _passive1Name,
  _passive2Name,
  _passive3Name,
  awakeningName,
  _passiveValues
) => {
  contract2.methods
    ._calculatePower(
      _job,
      _personality,
      _passive1Name,
      _passive2Name,
      _passive3Name,
      awakeningName,
      _passiveValues
    )
    .call()
    .then((res) => {
      console.log(res);
    });
};

const calculatePower = (_tokenId) => {
  contract.methods
    .InvestorInfo(_tokenId)
    .call()
    .then((res) => {
      _calculatePower(
        res._Job,
        res._Personality,
        res._Passive1Name,
        res._Passive2Name,
        res._Passive3Name,
        res._AwakeningName,
        res._PassiveValues
      );
    });
};

const _showAllInvestor = (_invocation) => {
  for (let i = 1; i < _invocation; i++) {
    _InvestorInfo(i);
  }
};

const showAllInvestor = async () => {
  const res = await mintingInformation();
  _showAllInvestor(res[[4]]);
};

const setMainAddress = () => {
  contract2.methods.setMainAddress(deployedNetworkAddress).send({
    from: addr,
    gas: "8500000",
  });
};
// setMainAddress();

const getStage = (_tokenId) => {
  contract2.methods
    .getStage(_tokenId)
    .call()
    .then((res) => {
      console.log(res);
    });
};

// getStage(3);
// calculatePower(3);
// showAllInvestor();
// generateInvestor(3);
// InvestorInfo(3);
// mintingInformation();
