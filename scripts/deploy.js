async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Token = await ethers.getContractFactory("SoliditySchool");
  const token = await Token.deploy();
  await token.deployed();
  console.log("SoliditySchool token deployed to:", token.address);

  // Deploy SoliditySchoolNFT contract
  const NFT = await ethers.getContractFactory("SoliditySchoolNFT");
  const nft = await NFT.deploy( ethers.utils.parseEther("2"), token.address);
  await nft.deployed();
  console.log("SoliditySchoolNFT token deployed to:", nft.address);

  // Deploy Faucet contract
  const Faucet = await ethers.getContractFactory("Faucet");
  const faucet = await Faucet.deploy(token.address, ethers.utils.parseEther("1"));
  await faucet.deployed();
  console.log("Faucet deployed to:", faucet.address);

  // Verify contracts on PolygonScan
  await hre.run("verify:verify", {
    address: token.address,
    contract: "contracts/SoliditySchool.sol:SoliditySchool",
    constructorArguments: [],
  });
  await hre.run("verify:verify", {
    address: nft.address,
    contract: "contracts/SoliditySchoolNFT.sol:SoliditySchoolNFT",
    constructorArguments: [ethers.utils.parseEther("2"),token.address],
  });
  await hre.run("verify:verify", {
    address: faucet.address,
    contract: "contracts/Faucet.sol:Faucet",
    constructorArguments: [ token.address, ethers.utils.parseEther("1")],
  });

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });