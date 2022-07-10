var Mycontract = artifacts.require("DecentProxy");


const seed1 = 17546;
const seed2 = 26789687;
module.exports = function (deployer) {
  deployer.deploy(Mycontract, seed1, seed2);
};
