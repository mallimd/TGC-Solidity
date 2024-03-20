const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const ONE_MILI_ETH = 1_000_000_000_000_000n;
const TWO_MILI_ETH = 2_000_000_000_000_000n;
const THREE_HALF_MILI_ETH = 3_500_000_000_000_000n;
const TEN_ETH = 10_000_000_000_000_000_000n;

module.exports = buildModule("PetIncLauncher", (m) => {
  const petIncContract = m.contract("PetInc", [], {
    value: TEN_ETH,
  });

  // Add default Rewards
  m.call(petIncContract, "addReward", ["small", ONE_MILI_ETH, 100, 10], {id: "addRewardSmall"})
  m.call(petIncContract, "addReward", ["medium", TWO_MILI_ETH, 200, 10], {id: "addRewardMedium"})
  m.call(petIncContract, "addReward", ["big", THREE_HALF_MILI_ETH, 300, 10], {id: "addRewardBig"})

  return { petIncContract };
});
