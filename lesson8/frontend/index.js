import { ethers } from "https://cdnjs.cloudflare.com/ajax/libs/ethers/6.7.0/ethers.min.js";

const petIncAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

const petIncAbi = [
  {
    inputs: [],
    stateMutability: "payable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "_addr",
        type: "address",
      },
    ],
    name: "AccountCreated",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "_addr",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "starsEarned",
        type: "uint256",
      },
    ],
    name: "StarsEarned",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "_addr",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "starsRedeemed",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "string",
        name: "rewardName",
        type: "string",
      },
    ],
    name: "StarsRedeemed",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_rewardName",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "_rewardPrize",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "_rewardStarsNeeded",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "_rewardQuantity",
        type: "uint256",
      },
    ],
    name: "addReward",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_stars",
        type: "uint256",
      },
    ],
    name: "addStars",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "createAccount",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "getStarsBalance",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_rewardName",
        type: "string",
      },
    ],
    name: "redeemStars",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "topup",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    stateMutability: "payable",
    type: "receive",
  },
];

let signer = null;

let provider;
if (window.ethereum == null) {
  // If MetaMask is not installed, we use the default provider,
  // which is backed by a variety of third-party services (such
  // as INFURA). They do not have private keys installed,
  // so they only have read-only access
  console.log("MetaMask not installed; using read-only defaults");
  provider = ethers.getDefaultProvider();
} else {
  // Connect to the MetaMask EIP-1193 object. This is a standard
  // protocol that allows Ethers access to make all read-only
  // requests through MetaMask.
  provider = new ethers.BrowserProvider(window.ethereum);

  // It also provides an opportunity to request access to write
  // operations, which will be performed by the private key
  // that MetaMask manages for the user.
  signer = await provider.getSigner();
}
const petIncContract = new ethers.Contract(petIncAddress, petIncAbi, signer);

petIncContract.on("AccountCreated", (addr) => {
  alert("Account has been created!");
});

petIncContract.on("StarsEarned", (addr, starsEarned) => {
  alert("Stars have been earned!");
});

petIncContract.on("StarsRedeemed", (addr, starsRedeemed, rewardName) => {
  alert("Stars have been redeemed!");
});

async function updateBalance() {
  let signer = null;

  let provider;
  if (window.ethereum == null) {
    // If MetaMask is not installed, we use the default provider,
    // which is backed by a variety of third-party services (such
    // as INFURA). They do not have private keys installed,
    // so they only have read-only access
    console.log("MetaMask not installed; using read-only defaults");
    provider = ethers.getDefaultProvider();
  } else {
    // Connect to the MetaMask EIP-1193 object. This is a standard
    // protocol that allows Ethers access to make all read-only
    // requests through MetaMask.
    provider = new ethers.BrowserProvider(window.ethereum);

    // It also provides an opportunity to request access to write
    // operations, which will be performed by the private key
    // that MetaMask manages for the user.
    signer = await provider.getSigner();
  }
  const petIncContract = new ethers.Contract(petIncAddress, petIncAbi, signer);

  const stars = await petIncContract.getStarsBalance();
  document.getElementById("ttlNumberOfStars").textContent = stars.toString();
}

async function createAccount() {
  let signer = null;

  let provider;
  if (window.ethereum == null) {
    // If MetaMask is not installed, we use the default provider,
    // which is backed by a variety of third-party services (such
    // as INFURA). They do not have private keys installed,
    // so they only have read-only access
    console.log("MetaMask not installed; using read-only defaults");
    provider = ethers.getDefaultProvider();
  } else {
    // Connect to the MetaMask EIP-1193 object. This is a standard
    // protocol that allows Ethers access to make all read-only
    // requests through MetaMask.
    provider = new ethers.BrowserProvider(window.ethereum);

    // It also provides an opportunity to request access to write
    // operations, which will be performed by the private key
    // that MetaMask manages for the user.
    signer = await provider.getSigner();
  }
  const petIncContract = new ethers.Contract(petIncAddress, petIncAbi, signer);
  try {
    return await petIncContract.createAccount();
  } catch (error) {
    console.error("Error:", error);
  }
}

async function addStars(stars) {
  let signer = null;

  let provider;
  if (window.ethereum == null) {
    // If MetaMask is not installed, we use the default provider,
    // which is backed by a variety of third-party services (such
    // as INFURA). They do not have private keys installed,
    // so they only have read-only access
    console.log("MetaMask not installed; using read-only defaults");
    provider = ethers.getDefaultProvider();
  } else {
    // Connect to the MetaMask EIP-1193 object. This is a standard
    // protocol that allows Ethers access to make all read-only
    // requests through MetaMask.
    provider = new ethers.BrowserProvider(window.ethereum);

    // It also provides an opportunity to request access to write
    // operations, which will be performed by the private key
    // that MetaMask manages for the user.
    signer = await provider.getSigner();
  }
  const petIncContract = new ethers.Contract(petIncAddress, petIncAbi, signer);
  return await petIncContract.addStars(stars);
}

async function redeemStars(rewardName) {
  let signer = null;

  let provider;
  if (window.ethereum == null) {
    // If MetaMask is not installed, we use the default provider,
    // which is backed by a variety of third-party services (such
    // as INFURA). They do not have private keys installed,
    // so they only have read-only access
    console.log("MetaMask not installed; using read-only defaults");
    provider = ethers.getDefaultProvider();
  } else {
    // Connect to the MetaMask EIP-1193 object. This is a standard
    // protocol that allows Ethers access to make all read-only
    // requests through MetaMask.
    provider = new ethers.BrowserProvider(window.ethereum);

    // It also provides an opportunity to request access to write
    // operations, which will be performed by the private key
    // that MetaMask manages for the user.
    signer = await provider.getSigner();
  }
  const petIncContract = new ethers.Contract(petIncAddress, petIncAbi, signer);
  return await petIncContract.redeemStars(rewardName);
}

document
  .getElementById("dogFoodBuyNowBtn")
  .addEventListener("click", async function (e) {
    console.log("Buying Dog Food Now");
    await addStars(300);
    await updateBalance();
  });

document
  .getElementById("catFoodBuyNowBtn")
  .addEventListener("click", async function (e) {
    console.log("Buying Cat Food Now");
    await addStars(300);
    await updateBalance();
  });

document
  .getElementById("fishFoodBuyNowBtn")
  .addEventListener("click", async function (e) {
    console.log("Buying Fish Food Now");
    await addStars(100);
    await updateBalance();
  });

document
  .getElementById("createAccountBtn")
  .addEventListener("click", async function (e) {
    console.log("Creating Account Now");
    await createAccount();
    await updateBalance();
  });

document
  .getElementById("redeemSmallPrizeBtn")
  .addEventListener("click", async function (e) {
    console.log("Redeeming Small Prize Now");
    await redeemStars("small");
    await updateBalance();
  });

document
  .getElementById("redeemMediumPrizeBtn")
  .addEventListener("click", async function (e) {
    console.log("Redeeming Medium Prize Now");
    await redeemStars("medium");
    await updateBalance();
  });

document
  .getElementById("redeemBigPrizeBtn")
  .addEventListener("click", async function (e) {
    console.log("Redeeming Big Prize Now");
    await redeemStars("big");
    await updateBalance();
  });

window.onload = updateBalance;
