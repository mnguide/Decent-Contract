var Mycontract = artifacts.require("DecentToken");

const name = "test";
const symbol = "ts";

module.exports = function (deployer) {
  deployer.deploy(Mycontract, name, symbol);
};
