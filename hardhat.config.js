require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

const ALCHEMY = process.env.ALCHEMY;
const KEY = process.env.KEY;
const POLYGON_API = process.env.POLYGON_API;


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks:{
    polygon: {
      url: `https://polygon-mainnet.g.alchemy.com/v2/${ALCHEMY}`,
      accounts: [KEY]
    }
  },
  etherscan:{
    apiKey: POLYGON_API
  }
};
