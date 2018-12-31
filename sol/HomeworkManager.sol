pragma solidity ^0.5.0;
import "./Homework.sol";

contract HomeworkManager {
    mapping (address => string) students;
    Homework [] homeworks;
    uint public studentNum;
    uint public homeworkNum;
    
    function isStudentRegister(address stuAddr) public view returns (bool isRegister) {
        isRegister = hashCompareInternal(students[stuAddr], "");
    }
    
    function registerStudent(address stuAddr, string memory name) public {
        require(
            isStudentRegister(stuAddr) == false,
            "This student has registered!"
            );
            
        students[stuAddr] = name;
        studentNum++;
    }
    
    function getAllHomeworks() public view returns (Homework[] memory _homeworks) {
        _homeworks = homeworks;
    }
    
    function addHomework(Homework h) public returns (bool succeed){
        for (uint i = 0; i < homeworks.length; ++i) {
            if (hashCompareInternal(homeworks[i].homeworkName(), h.homeworkName())) {
                succeed = false;    
                break;
            }
        }
        homeworks.push(h);
        homeworkNum++;
        succeed = true;
    }
    
    function deleteHomework(string memory name) public returns (bool succeed){
        succeed = false;
        for (uint i = 0; i < homeworks.length; ++i) {
            
            if (hashCompareInternal(homeworks[i].homeworkName(), name)) {
                delete homeworks[i];
                homeworkNum--;
                succeed = true;
                break;
            }
        }
    }
    
    function hashCompareInternal(string memory a, string memory b) public pure returns (bool isEqual) {
        isEqual = keccak256(bytes(a)) == keccak256(bytes(b));
    }
}