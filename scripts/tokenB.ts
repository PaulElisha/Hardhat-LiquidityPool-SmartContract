import { ethers } from "hardhat";

const main = async () => {
  const tokenB = await ethers.deployContract("MEME", []);
  await tokenB.waitForDeployment();
  console.log(tokenB.target);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// 0xa644f0b1cfBcE2EE9016BA8FDB34D39fbbE95120 Token B
