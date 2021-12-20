require('dotenv').config({path: './config/config.env'})

const { P_KEY, RINKEBY_ENDPOINT } = process.env
const HDWalletProvider = require('@truffle/hdwallet-provider');


module.exports = {
  networks: {
    dev: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 7545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
    
    rinkeby: {
      provider: () => new HDWalletProvider({
        mnemonic: P_KEY,
        providerOrUrl: RINKEBY_ENDPOINT
      }),
      network_id: 4,   
      networkCheckTimeout: 999999,
    }
  },

  mocha: {
    timeout: 100000
  },
  compilers: {
    solc: {
      version: ">=0.5.0 <0.9.0",    
      settings: {         
       optimizer: {
        enabled: true,
        runs: 200
       }
      }
    }
  }
};
