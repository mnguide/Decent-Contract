const { pkey, addr } = require("./secret.js");
const CONTRACT = require("./build/contracts/DecentToken.json");

const Caver = require("caver-js");
const rpcURL = "https://api.baobab.klaytn.net:8651/";
const caver = new Caver(rpcURL);

const temp = caver.klay.accounts.createWithAccountKey(addr, pkey);
caver.klay.accounts.wallet.add(temp);

const networkID = "1001";
const deployedNetworkAddress = CONTRACT.networks[networkID].address;
const contract = new caver.klay.Contract(CONTRACT.abi, deployedNetworkAddress);

const testProxy_generateInvestor = () => {
  contract.methods
    .generateInvestor(1)
    .call()
    .then(() => {
      contract.methods
        .InvestorInfo(1)
        .call()
        .then((res) => {
          console.log(res);
        })
        .catch((err) => {
          console.log(err);
        });
    })
    .catch((err) => {
      console.log(err);
    });
};
testProxy_generateInvestor();
