// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";
import "./School.sol";
// import "./NFT.sol";


contract QTKN is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint 10000 tokens to msg.sender
        _mint(msg.sender, 10000 * 10**uint(decimals()));
    }

    struct student {
        string name;
        uint cid;
        bool status;
    }

    mapping(address => student) public registeredStudents;

    function registerCourse(string memory _name, uint _cid) public {
        registeredStudents[msg.sender] = student(_name, _cid, false);
    }

    function updateStatus() public {
        registeredStudents[msg.sender].status = true;
    }

}
