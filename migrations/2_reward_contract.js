var Mycontract = artifacts.require("DecentRewardToken");

const name = "reward test";
const symbol = "rts";
const seed1 = 1234;
const seed2 = 867543;

module.exports = function (deployer) {
  deployer.deploy(Mycontract, name, symbol,seed1,seed2);
};