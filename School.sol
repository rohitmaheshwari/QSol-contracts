// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/e3391cd65f57c6b16c1d1be17e52380d6517ded1/contracts/token/ERC20/ERC20.sol";
// import "./QTKN.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
// import "./nft.sol";


contract School {
    struct course {
        string courseName;
        uint id;
        uint price;
    }

    mapping (address => course) public coursesAssigned;
    mapping (uint => uint) public coursePrice;

    uint public schoolShare;

    course[] public courses;

    function setShare(uint _share) public {
        schoolShare = _share;
    }
 
    function makeCourse(address _teacher, string memory _name, uint _id, uint _price) public {
        uint tax = _price*3/100;
        coursesAssigned[_teacher] = course(_name, _id, _price+tax+schoolShare);
        courses.push(course(_name, _id, _price+tax+schoolShare));
        coursePrice[_id] = _price+tax+schoolShare;
    }

    function allCourses() public view returns(course[] memory) {
        return courses;
    }

    // ------------------------------------------------------------------------------------------

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


// -----------------------------------------------------------

    

}
