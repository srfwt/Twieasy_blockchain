pragma solidity ^0.8.0;
//返却記録
//メッセージ

contract Main{
    struct User {
        string mail;
        string pass;
        string department;
    }
    struct Review {
        //address User;
        string comment;
    }

    // 授業目ごとにレビューと楽単or落単
    struct Subject {
        string ID;
        string reviews;
        uint256 easy;
        uint256 difficult;
    }

    Subject[] public subjects;
    User[] public users;
    mapping(string => uint) public subject;
    mapping(string => uint) public user;
    uint256 subjectNum;
    uint256 userNum;

    Subject public temp;
    User public mike;

    constructor () {
        subjectNum++;
        userNum++;
        temp.easy = 0;
        temp.difficult = 0;
        subjects.push(temp);
        mike.mail = "sample";
        mike.pass = "sample";
        mike.department = "sample";
        users.push(mike);
    }

    function checkRegistered(string memory _mail) public view returns (bool) {
        if (user[_mail] == 0) { // user not exist 
            return false;
        } else { // already exist
            return true;
        }
    }

    function register(string memory _mail, string memory _pass, string memory _dep) public {
        if (user[_mail] == 0) { // not exist the user
            users.push(mike);
            user[_mail] = userNum++;
            users[user[_mail]].mail = _mail;
            users[user[_mail]].pass = _pass;
            users[user[_mail]].department = _dep;
        }
    }

    function getPass(string memory _mail) public view returns (string memory) {
        if (user[_mail] == 0) { // not exist the user
            return "user not exist";
        } else {
            return users[user[_mail]].pass;
        }
    }

    function getDepartment(string memory _mail) public view returns (string memory){
        if (user[_mail] == 0) { // not exist the user
            return "user not exist";
        } else {
            return users[user[_mail]].department;
        }
    }

    function _review(string memory _id, string memory comment) public {
        if (subject[_id] != 0) {
            subjects[subject[_id]].reviews = concate(comment, _id);
        }else {
            subjects.push(temp);
            subject[_id] = subjectNum++;
            subjects[subject[_id]].ID = _id;
            subjects[subject[_id]].reviews = concate(comment, _id);
        }
    }

    // function getSubject(string memory _id) public view returns (Subject memory) {
    //     if (subject[_id] != 0) {
    //         return subjects[subject[_id]];
    //     } else {
    //         return temp;
    //     }
    // }

    function getReviews(string memory _id) public view returns (string memory) {
        if (subject[_id] != 0) {
            return subjects[subject[_id]].reviews;
        } else {
            return temp.reviews;
        }
    }

    function concate(string memory arr, string memory _id) internal view returns(string memory) {
        return string(abi.encodePacked(subjects[subject[_id]].reviews," ",arr));
    }

    function voteEasy(string memory _id) public {
        if (subject[_id] != 0) {
            subjects[subject[_id]].easy++;
        }else {
            subjects.push(temp);
            subject[_id] = subjectNum++;
            subjects[subject[_id]].ID = _id;
            subjects[subject[_id]].easy++;
        }
    }

    function voteDifficult(string memory _id) public {
        if (subject[_id] != 0) {
            subjects[subject[_id]].difficult++;
        }else {
            subjects.push(temp);
            subject[_id] = subjectNum++;
            subjects[subject[_id]].ID = _id;
            subjects[subject[_id]].difficult++;
        }
    }
}
