// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract PetInc {
    // State Variables
    uint256 internal constant INITIAL_STARS = 100;

    address internal owner;
    bool internal lock;

    address[] internal customersAddresses;
    string[] internal rewardNames;

    mapping(address=>uint256) internal stars;
    mapping(string=>Reward) internal rewards;

    struct Reward {
        string name;
        uint256 prize;
        uint256 starsNeeded;
        uint256 quantity;
    }

    // Events
    event AccountCreated(address indexed _addr);
    event StarsEarned(address indexed _addr, uint256 starsEarned);
    event StarsRedeemed(address indexed _addr, uint256 starsRedeemed, string rewardName);

    // Functional Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyCustomer() {
        require(customerExists(msg.sender), "You are not a customer!");
        _;
    }

    modifier onlyNewCustomer() {
        require(!customerExists(msg.sender), "You are already a customer!");
        _;
    }

    modifier reEntrancyGuard() {
        require(!lock, "This smart contract is locked at the moment");
        lock = true;
        _;
        lock = false;
    }

    // Helper Functions
    function customerExists(address _customerAddr) internal view returns (bool) {
        for (uint256 idx = 0; idx < customersAddresses.length; idx++) {
            address curr = customersAddresses[idx];
            if(curr == _customerAddr) {
                return true;
            }
        }
        return false;
    }

    function rewardExists(string memory _rewardName) internal view returns (bool) {
        for (uint256 idx = 0; idx < rewardNames.length; idx++) {
            string memory curr = rewardNames[idx];
            if(stringsEqual(curr, _rewardName)) {
                return true;
            }
        }
        return false;
    }

    function stringsEqual(string memory _s1, string memory _s2) internal pure returns (bool) {
        return keccak256(abi.encodePacked(_s1)) == keccak256(abi.encodePacked(_s2));
    }

    constructor() payable {
        owner = msg.sender;
        lock = false;
    }

    receive() external payable {}

    function topup() external payable onlyOwner() {}

    // Functions
    function createAccount() public onlyNewCustomer {
        address newCustomerAddress = msg.sender;
        customersAddresses.push(newCustomerAddress);
        stars[msg.sender] = INITIAL_STARS;
        emit AccountCreated(newCustomerAddress);
    }

    function getStarsBalance() public view onlyCustomer returns (uint256) {
        return stars[msg.sender];
    }

    function addStars(uint256 _stars) public onlyCustomer {
        uint256 oldNumberOfStars = stars[msg.sender];
        uint256 newNumberOfStars = oldNumberOfStars + _stars;
        stars[msg.sender] = newNumberOfStars;
        emit StarsEarned(msg.sender, _stars);
    }

    function redeemStars(string memory _rewardName) public onlyCustomer reEntrancyGuard {
        require(rewardExists(_rewardName), "This reward does not exist!");

        Reward memory currentReward = rewards[_rewardName];

        uint256 costOfReward = currentReward.starsNeeded;

        uint256 usersCurrentNumberOfStars = stars[msg.sender];

        require(usersCurrentNumberOfStars >= costOfReward, "You do not have enough stars!");

        uint256 usersNewNumberOfStars = usersCurrentNumberOfStars - costOfReward;

        stars[msg.sender] = usersNewNumberOfStars;

        currentReward.quantity -= 1; // currentReward.quantity = currentReward.quantity - 1;

        rewards[currentReward.name] = currentReward;

        (bool success,) = payable(msg.sender).call{value: currentReward.prize}("");
        require(success, "Transferred Failed");
    }

    function addReward(
        string memory _rewardName,
        uint256 _rewardPrize,
        uint256 _rewardStarsNeeded,
        uint256 _rewardQuantity
    ) public onlyOwner {
        require(_rewardPrize > 0, "Reward Prize must be more than 0!");
        require(_rewardStarsNeeded > 0, "Reward Stars Needed must be more than 0!");
        require(_rewardQuantity > 0, "Reward Quantity must be more than 0!");
        require(!rewardExists(_rewardName), "This reward name already exist!");

        Reward memory newReward = Reward(
            _rewardName,
            _rewardPrize,
            _rewardStarsNeeded,
            _rewardQuantity
        );

        rewards[_rewardName] = newReward;
        rewardNames.push(_rewardName);

    }
}