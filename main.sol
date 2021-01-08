// pragma experimental ABIEncoderV2;
//返却記録
//メッセージ

contract Main{
    // 貸し借りの履歴
    // struct Date{
    //     uint256 Year;
    //     uint256 Month;
    //     uint256 Day;
    // }
    // struct Book{//(本に対しての履歴がいるかも？)(著者)
    //     address User;//借りている人
    //     uint num;//固有番号
    //     string name;//本の名前
    //     uint256 status;//状態(0 : 貸し出し中, 1 : 在庫あり)
    //     uint256 left;//同じ名前の本の在庫冊数
    //     uint256 reserved_num; //予約人数
    //     uint pages;
    //     uint256 borrow_date;//貸出日
    //     uint256 return_date;//返却日
    //     uint256[] friends;//同じ名前の本の固有番号
    //     Date Bdate;
    //     Date Rdate;
    // }

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

//     Book[] booklist;//index:固有番号
//     Student[] studentlist;
//     mapping(address => uint) public students; // 利用者のアドレス -> studentlistのインデックス
//     int256 P = 100;//ポイント初期値
//     address lib = address(0xfbE00a15070cdF61B86098e651f053655292b424);

//     function random(uint256 num, uint seed) private view returns (uint256) {
//         return uint256(keccak256(abi.encodePacked(block.timestamp, seed)))%(num-1) + 1;
//    }



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
            string memory money;
            string memory akane;
            abi.encodePacked(money," ", akane);
            // return subjects[subject[_id]].reviews;
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
