const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const ONE_GWEI = 1_000_000_000n;

module.exports = buildModule("PetIncLauncher", (m) => {
  const petIncContract = m.contract("PetInc", [], {
    value: ONE_GWEI,
  });

  return { petIncContract };
});
