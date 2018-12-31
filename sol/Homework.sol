pragma solidity ^0.5.0;

contract Homework {
    
    struct Student {
        bool submit;
        uint8 score;
        string url;
        address addr;
        bool isIn;
        uint8 submitTime;
        string name;
    }
    
    address public teacher;
    uint public ddl;
    bool ended;
    
    mapping(address => Student) students;
    
    string public homeworkName;
    string public requirements;
    uint public stuNumber;
    
    constructor(string memory _homeworkName, string memory _requiremwents, uint allowedTime) public {
        teacher = msg.sender;
        homeworkName = _homeworkName;
        requirements = _requiremwents;
        ddl = now + allowedTime * 3600;
    }
    
    function addStudent(string memory stuName, address stuAddr) public {
        require(
            msg.sender == teacher, 
            "Sorry,only teacher can add a student to the homework list."
            );
        
        require(
            now <= ddl,
            "DDL has gone!"
            );
            
        require(
            students[stuAddr].isIn == false, 
            "This student is already in the homework list!"
            );
        
        students[stuAddr] = Student({
            submit: false,
            score: 101,
            url: "",
            addr: stuAddr,
            isIn: true,
            submitTime: 0,
            name: stuName
        });
        
        stuNumber++;
        
    }
    
    function deleteStudent(address stuAddr) public {
        require(
            msg.sender == teacher, 
            "Sorry,only teacher can delete a student from the homework list."
            );
        
        require(
            students[stuAddr].isIn == true, 
            "This student is not in the homework list!"
            );
            
        students[stuAddr].isIn = false;
        stuNumber--;
    }
    
    function submitHomework(address stuAddr, string memory url) public{
        require(
            msg.sender != teacher, 
            "only student need to submit homeworks."
            );
            
        require(
            now <= ddl,
            "DDL has gone!"
            );
            
        require(
            students[stuAddr].isIn == true, 
            "You are not in this student list!"
            );
        
        students[stuAddr].submit = true;
        students[stuAddr].url = url;
        students[stuAddr].submitTime++;
    }
    
    function getStudentScore(address stuAddr) public view returns (uint score) {
        require(
            students[stuAddr].isIn == true,
            "You are not in this student list!"
            );
            
        require(
            students[stuAddr].submit == true,
            "This student has not submited homework."
            );
        
        score = students[stuAddr].score;
    }
    
    function getSubmitTime(address stuAddr) public view returns (uint submitTime) {
        require(
            students[stuAddr].isIn == true,
            "You are not in this student list!"
            );
            
        require(
            students[stuAddr].submit == true,
            "This student has not submited homework."
            );
        
        
        submitTime = students[stuAddr].submitTime;
    }
    
    function isStudentSubmit(address stuAddr) public view returns (bool isSubmit) {
        require(
            students[stuAddr].isIn == true,
            "You are not in this student list!"
            );
        
        isSubmit = students[stuAddr].submit;
    }
    
    function giveScoresTo(address stuAddr, uint8 score) public{
        require(
            msg.sender == teacher, 
            "Sorry,only teacher can give scores to a student."
            );
        
        require(
            students[stuAddr].isIn == true, 
            "This student is not in the homework list!"
            );
            
        require(
            students[stuAddr].submit == true,
            "This student has not submited homework."
            );
        
        require(
            score >=0 && score <= 100,
            "score should be in range 0-100"
            );
            
        students[stuAddr].score = score;
    }
    
    function isStudentIn(address stuAddr) public view returns (bool isIn) {
        isIn = students[stuAddr].isIn;
    }
    /*
    function homeworkEnd() public {
        require(
            now >= ddl,
            "Homework not yet ended."
            );
        require(
            !ended, 
            "HomeworkEnd has already called."
            );
        ended = true;
    }
    */
}