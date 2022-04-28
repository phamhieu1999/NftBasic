const hre = require("hardhat");

async function main() {
  const CameliaNovel = await hre.ethers.getContractFactory("CameliaNovel");
  const cameliaNovel = await CameliaNovel.deploy("CameliaNovel", "CV");

  await cameliaNovel.deployed();
  console.log("Successfully deployed smart contract to: ", cameliaNovel.address);

  await cameliaNovel.mint("https://ipfs.io/ipfs/QmbC8iauZugEnBgXHJ4SmExjL4yE54EqLje1CPCdtvH6Ab");
  console.log("NFT successfully minted");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

