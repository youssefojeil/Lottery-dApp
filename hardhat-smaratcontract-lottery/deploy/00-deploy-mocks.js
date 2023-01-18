const { network } = require("hardhat");
const {
  networkConfig,
  developmentChains,
} = require("../helper-hardhat-config");

const BASE_FEE = ethers.utils.parseEther("0.25"); // 0.25 is the premium it costs 0.25 link per request
const GAS_PRICE_LINK = 1e9; //calculated value based off gas price of the chain

module.exports = async function ({ getNamedAccounts, deployments }) {
  const { deploy, log } = deployments;
  const deployer = await getNamedAccounts();
  const chainId = network.name;
  const args = [BASE_FEE, GAS_PRICE_LINK];

  if (developmentChains.includes(network.name)) {
    log("Local network detected! deploying mocks..");

    // deploy a mock vrf coordinator
    await deploy("VRFCoordinatorV2Mock", {
      from: deployer,
      log: true,
      args: args,
    });
    log("Mocks Deployed!");
    log("--------------------------------------------");
  }
};

module.exports.tags = ["all", "mocks"];
