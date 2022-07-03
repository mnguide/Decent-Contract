var Mycontract = artifacts.require("DecentToken");
const CONTRACT = require("../build/contracts/DecentProxy.json");
const deplyedNetworkAddress = CONTRACT.networks["1001"].address;

const name = "test";
const symbol = "ts";

module.exports = function (deployer) {
  deployer.deploy(Mycontract, name, symbol,deplyedNetworkAddress);
};
