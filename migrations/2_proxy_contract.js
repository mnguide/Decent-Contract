var Mycontract = artifacts.require("DecentProxy");

const seed1 = 1234;
const seed2 = 2345;
module.exports = function (deployer) {
  deployer.deploy(Mycontract, seed1, seed2);
};
