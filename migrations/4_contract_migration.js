var Mycontract = artifacts.require("DecentToken");
const CONTRACT1 = require("../build/contracts/DecentProxy.json");
const CONTRACT2 = require("../build/contracts/DecentRewardToken.json");
const deplyedNetworkAddress1 = CONTRACT1.networks["1001"].address;

const deplyedNetworkAddress2 = CONTRACT2.networks["1001"].address;

const name = "test";
const symbol = "ts";

module.exports = function (deployer) {
  deployer.deploy(Mycontract, name, symbol, deplyedNetworkAddress1,deplyedNetworkAddress2);
};
