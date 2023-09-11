import { ethers, network } from "hardhat";

const main = async () => {
  const liquidityCon = await ethers.deployContract("LiquidityPool", [
    "0x5FDb0D373488D0871a27C87fFb5Dc9163219D2F3",
    "0x9364870D1cEcDffa5b493363ab62002053748B0D",
  ]);

  await liquidityCon.waitForDeployment();
  console.log(liquidityCon.target);

  const liquidityContrAddress = "0xe379874446dd29178e68852992Daa80be952c0B3";

  const interact = await ethers.getContractAt(
    "ILiquidity",
    liquidityContrAddress
  );
  const liquidityProvider = "0x5FDb0D373488D0871a27C87fFb5Dc9163219D2F3";

  const liquiditySigner = await ethers.getImpersonatedSigner(liquidityProvider);

  await network.provider.send("hardhat_setBalance", [
    liquiditySigner,
    "0x9BCB3A8434E25CFC00",
  ]);

  const amountA = ethers.parseEther("20");
  const amountB = ethers.parseEther("40");

  const pro = await interact
    .connect(liquiditySigner)
    .addLiquidity(amountA, amountB);

  const receipt = pro.wait();
  console.log(receipt);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
