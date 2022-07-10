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

const a = [
  "CRYPTO INVESTOR",
  "LAND INVESTOR",
  "STOCK INVESTOR",

  "judgement",
  "information power",
  "insight",

  "stuffy",
  "foolish",
  "stupid",
  "normal",
  "cautious",
  "exhaustive",
  "intelligent",
  "phenomenal",

  "존버 투자자",
  "익절 투자자",
  "수익 두배 투자자",
  "람보르기니 투자자",
  "상가 한채 투자자",
  "슈퍼 투자자",
];

const testProxy_generateInvestor = () => {
  for(let i of a){
    contract2.methods
    .customHash(i)
    .call()
    .then((res) => {
      console.log(`${i} = ${res}`);
    });
  }
};
testProxy_generateInvestor();
