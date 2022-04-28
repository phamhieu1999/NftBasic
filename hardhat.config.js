require("@nomiclabs/hardhat-ethers");
const privateKey = "3826d71483e47402d36bf5ba6e5d3866d86e6166427127fe84a5231e3c9ec8b2";
module.exports = {
  defaultNetwork: "matic",
  networks: {
    hardhat: {
    },
    matic: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [privateKey]
    }
  },
  solidity: {
    version: "0.8.2",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
}
