/**
 * @type import('hardhat/config').HardhatUserConfig
 */

// import 'hardhat';
require('@nomicfoundation/hardhat-ethers')
require('@openzeppelin/hardhat-upgrades')
require('@nomicfoundation/hardhat-verify')

require('dotenv/config')

module.exports = {
  solidity: {
    version: '0.8.28',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    hardhat: {},
    amoy: {
      url: process.env.AMOY_RPCURL,
      accounts: [`0x${process.env.SIGNER_TESTNET}`],
    },
    //Use for mainnet deployment
    // polygon: {
    //   url: process.env.MAINNET_RPCURL,
    //   accounts: [`0x${process.env.SIGNER_MAINNET}`],
    // },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.VERIFICATION_KEY,
    },
  },
}
