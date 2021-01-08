// pragma experimental ABIEncoderV2;
//返却記録
//メッセージ

contract Main{
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
    mapping(string => uint) public subject;
    uint256 subjectNum = 0;

    Subject public temp;


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

    constructor () public {
        temp.easy = 0;
        temp.difficult = 0;
    }
}
