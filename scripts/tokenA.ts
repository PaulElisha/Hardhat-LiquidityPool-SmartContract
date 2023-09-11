import { ethers, network } from "hardhat";

const main = async () => {
  const tokenA = await ethers.deployContract("MEME", []);
  await tokenA.waitForDeployment();
  console.log(tokenA.target);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// 0x29a019e61F798b31b05DACbA2E49AC17Dca5eD45 Token A
