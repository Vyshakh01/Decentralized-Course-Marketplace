const { expect } = require("chai");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
};

describe("Dappazon", () => {
  let dappazon;
  let deployer, buyer;
  beforeEach(async () => {
    //set up accounts
    [deployer, buyer] = await ethers.getSigners();

    //deploy contract
    const Dappazon = await ethers.getContractFactory("Dappazon");
    dappazon = await Dappazon.deploy();
  });

  describe("Deployment", () => {
    it("Sets the owner", async () => {
      expect(await dappazon.owner()).to.equal(deployer.address);
    });
  });

  describe("Listing", () => {
    let transaction;

    beforeEach(async () => {
      transaction = await dappazon
        .connect(deployer)
        .list(1, "React JS", "Angela Yu", "IT", "IMAGE", 2, 4);

      await transaction.wait();
    });

    it("Return item attributes", async () => {
      const item = await dappazon.items(1);
      expect(item.id).to.equal(1);
    });
  });
});
