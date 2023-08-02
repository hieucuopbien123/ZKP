// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // Version mới nhất của hardhat code deploy đã thay đổi
  // Deploy hasher
  const hasherContract = await ethers.deployContract("Hasher", []);
  await hasherContract.waitForDeployment();
  const hasherAddress = await hasherContract.getAddress();
  console.log("Hasher Address::", hasherAddress);

  const verifier = await ethers.deployContract("Groth16Verifier", []);
  await verifier.waitForDeployment();
  const verifierAddress = await verifier.getAddress();
  console.log("Verifier Address::", verifierAddress);

  // Deploy tornado
  const tornadoContract = await ethers.deployContract("Tornado", [hasherAddress, verifierAddress]);
  await tornadoContract.waitForDeployment();
  console.log("Tornado Address::", await tornadoContract.getAddress());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
