require("@nomiclabs/hardhat-waffle");

require("dotenv").config();

require("@nomiclabs/hardhat-etherscan");

const projeId=process.env.INFURA_PROJECT_ID
const privateKey = process.env.DEPLOYER_SIGNER_PRIVATE_KEY
const etherscanApi = process.env.ETHERSCAN_API_KEY;

module.exports = {
  solidity: "0.8.4",
  networks:{
    rinkeby:{
      //EndPoints de infura u otro proveedor
      // url:'https://rinkeby.infura.io/v3/${projeId}',
      url: `https://rinkeby.infura.io/v3/${projeId}`,

      accounts:[        //añadir el prefijo 0x
      privateKey
      ]
    }
  },
  etherscan: {
    apiKey: etherscanApi
  }
};
