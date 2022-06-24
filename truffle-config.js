const {
  //
  pkey,
} = require("./secret.js");
const HDWalletProvider = require("truffle-hdwallet-provider-klaytn");
const Caver = require("caver-js");

module.exports = {

  networks: {
    baobab: {
      provider: () => {
        return new HDWalletProvider(pkey, "https://api.baobab.klaytn.net:8651");
      },
      network_id: "1001",
      gas: "8500000",
      gasPrice: null,
    },
  },
  compilers: {
    solc: {
      version: "0.5.17", // Fetch exact version from solc-bin (default: truffle's version)
      settings: {
        // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: false,
          runs: 200,
        },
      },
    },
  },
};
