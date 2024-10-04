// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentPortal {
    struct Student {
        string name;
        string email;
        string dob;
        string lga;
        string country;
        string state;
    }
    
    address public owner;

    Student[] students;

    // Events to emit for each action
    event CreateStudent();

    event UpdateStudent(
        uint indexed studentId,
        string name,
        string dob
    );

    event DeleteStudent(
        uint indexed studentId
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner!");
        _;
    }

    function checkIndex(uint _index) internal view{
        require(_index < students.length, "Index out of range!");
    }

    function createStudent(
        string memory _name,
        string memory _email,
        string memory _dob,
        string memory _lga,
        string memory _country,
        string memory _state
        ) external onlyOwner {
        Student memory newStudent = Student({
            name : _name,
            email : _email,
            dob : _dob,
            lga : _lga,
            country : _country,
            state : _state
        });
        
        students.push(newStudent);

        emit CreateStudent();
    }

    function getAllStudents() external view returns (Student[] memory) {
        return students;
    }

    function getStudentByIndex(uint _index) external view returns (Student memory) {
        checkIndex(_index);
        return students[_index];
    }

    function updateStudentBio(uint _index, string memory _name, string memory _dob) external onlyOwner {
        checkIndex(_index);

        Student storage updateStudentInfo = students[_index];
        updateStudentInfo.name = _name;
        updateStudentInfo.dob = _dob;

        students.push(updateStudentInfo);

        emit UpdateStudent(_index, _name, _dob);
    }

    function deleteStudentInfo(uint _index) external onlyOwner {
        checkIndex(_index);

        for (uint i = _index; i < students.length - 1; i++) {
            students[i] = students[i + 1];
        }

        students.pop();
        
        emit DeleteStudent(_index);
    }
}