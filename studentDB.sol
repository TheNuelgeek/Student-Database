// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StudentDataBase{

    //  Only admin can create record for a student
    //  then push the record into an array
    //  generate an id for that student
    //  assign the student ID to their address
    //  assign student record to their ID
    //  student can call a function from thier account to retrive thier ID
    //  External entity can confirm student record using their ID only

    // VARIABLE

    address admin;
    uint ID = 1000;
    mapping(address => uint) private studentToID;
    mapping(uint => StudentRec) internal IdToRecords;
    mapping(uint => StudentRec) internal dropouts;
    StudentRec[] studentRecords;

    struct StudentRec {
        uint ID;
        string fullName;
        uint DOB;
        string gender;
        string state_of_origin;
    }

    // FUNCTION

    constructor(address _admin){
        admin = _admin;
    }

    modifier onlyAdmin{
        require(msg.sender == admin, "only admin can call this function");
        _;
    }

    function addStudent(
        address _address,
        string memory _fullName,
        uint _DOB,
        string memory _gender,
        string memory _state_of_origin
    ) public onlyAdmin returns(bool, uint)
    {
        if(addressExist(_address)){
            return(false, studentToID[_address]);
        }

        ID++;  

        StudentRec memory newStudent = StudentRec(ID, _fullName, _DOB, _gender, _state_of_origin);

        studentRecords.push(newStudent);

        studentToID[_address] = ID;

        IdToRecords[ID] = newStudent;

        return(true, ID);
    }

    // FUNCTION TO ALLOW STUDENT TO RETRIVE ID BY WALLET ADDRESS
    function retriveID() external view returns(bool, uint256){
        uint id = studentToID[msg.sender];
        if(id == 0) return (false,0);
        return(true, id);
    }
    
    // A FUNCTION TO RETURN THE ID OF A STUDENT BY THIER ADDRESSS AND ONLY ADMIN IS PERMITTED TO DO THAT
    function adminRecovery(address _address)onlyAdmin external view returns(bool, uint256){
        uint id = studentToID[ _address];
        if(id == 0) return (false,0);
        
        return(true, id);
    }

    // A FUNCTION TO RETURN THE RECORD OF A STUDENT BY THIER ID
    function confrimRecord(uint _ID )external view returns(StudentRec memory){
        return  IdToRecords[_ID];
    }

    // TO CONFIRM IF AN ADDRESS IS ASSIGNED A RECORD
    function addressExist(address _address) internal view returns(bool){
        return !(studentToID[_address] == 0);
    }

    function dropOut(uint256 _ID) external onlyAdmin returns(bool){
        require(IdToRecords[_ID].ID != 0, "Student does not exist");
        dropouts[_ID] = IdToRecords[_ID];
        delete IdToRecords[_ID];

        //  THIS METHOD IS NOT RECOMMENDED BECAUSE OF THE ARRAY IS LARGE IT CONSUME ALL OUR GAS
        //  for(uint i; i  studentRecords.length; i++){
        //      if(studentRecords[i].ID == _ID){
        //          delete IdToRecords[_ID];
        //      }
        //  }


        //  THIS METHOD IS GAS CONSUMING
        //  uint indexToBeRemove;
        //  for(uint i; i  studentRecords.length; i++){
        //      if(studentRecords[i].ID == _ID){
        //          indexToBeRemove = i;
        //          delete IdToRecords[indexToBeRemove];
        //          break;
        //      }
        //  }

        //  for(uint i = indexToBeRemove; i  studentRecords.length - 1; i++){
        //      studentRecords[i] = studentRecords[i + 1];
        //  }
        //  studentRecords.pop();

        // RECOMMENDED RECORD
        uint indexToBeRemove;
        for(uint i; i  < studentRecords.length; i++){
            if(studentRecords[i].ID == _ID){
                indexToBeRemove = i;
                delete IdToRecords[indexToBeRemove];
                break;
            }
        }
        studentRecords[indexToBeRemove] = studentRecords[studentRecords.length -1];
        studentRecords.pop();
        
        return true;
    }
}   

