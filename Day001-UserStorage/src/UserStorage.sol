//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/*This contract allows users store name and age
  Let's them update it, 
  Allow them retrieve it,
  owned by a deployer
*/
contract UserStorage {
    address immutable  i_owner; // owner variable, stores contract deployer's address

    struct UserData {
        //This struct contains users data
        string name;
        uint256 age;
    }

    mapping(address => UserData) private userDetails; //This mapping links users address to their respective details (struct)

    constructor() {
        i_owner = msg.sender; //This ensures the owner is the message sender
    }

    modifier onlyOwner() {
        require(msg.sender == i_owner, "Unauthorized Access");
        _;
    }

    //This function store users data (name, age)
    function store(string memory _name, uint256 _age) external {
        userDetails[msg.sender] = UserData(_name, _age);
    }

    //This function uses an address input to get user details from the struct (which was mapped to the address)
    function getDetails(address user) external view returns (string memory, uint256) {
        UserData memory data = userDetails[user];
        return (data.name, data.age);
    }

    //This function enable user update their own data
    function updateDetail(string memory _name, uint256 _age) external {
        UserData memory updateData = UserData({name: _name, age: _age});

        userDetails[msg.sender] = updateData;
    }

    //  This function enable user to delete data input (name, age)
    function deleteUser() external {
        delete userDetails[msg.sender];
    }

    // This function gets the contraact deployers address
    function getOwner() external view returns (address) {
        return i_owner;
    }
}