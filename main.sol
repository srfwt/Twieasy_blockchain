pragma experimental ABIEncoderV2;
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
        Review[] reviews;
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
            subjects[subject[_id]].reviews.push(Review(comment));
        }else {
            subjects.push(temp);
            subject[_id] = subjectNum++;
            subjects[subject[_id]].ID = _id;
            subjects[subject[_id]].reviews.push(Review(comment));
        }
    }

    function getSubject(string memory _id) public view returns (Subject memory) {
        if (subject[_id] != 0) {
            return subjects[subject[_id]];
        } else {
            return temp;
        }
    }

    function getReviews(string memory _id) public view returns (Review[] memory) {
        if (subject[_id] != 0) {
            return subjects[subject[_id]].reviews;
        } else {
            return temp.reviews;
        }
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
//     constructor () public {
//             address nouser = address(0x0);
//             string[16] memory book_name = ["BlockChain", "Cooking for Geek","GitHub 入門","Mastering Ethere","TOEIC 公式","Cooking for Geek","徹底演習",
//                                     "ニューラルネットワーク","dapp & ゲーム","画像認識","やさしいC++","機械学習","応用情報","algorithm","ぴえん。","Toefl"];
//             uint256[] memory friend;
//             for (uint i = 0; i < 8; i++) {
//                 Date memory borrow_d = Date(2020, 7, 27);
//                 Date memory return_d = Date(2020, 8, 10);
//                 booklist.push(Book(nouser,i,book_name[i],0,1,random(10,i),random(400,i),block.timestamp - 2 days,block.timestamp + 12 days,friend,borrow_d,return_d));
//                 //title_search[book_name[i]] = i;
//             }//18469(2020/7/26)
//             for (uint i = 8; i < 16; i++) {
//                 Date memory borrow_d = Date(2020, 7, 14);
//                 Date memory return_d = Date(2020, 7, 28);
//                 booklist.push(Book(nouser,i,book_name[i],0,1,random(10,i),random(400,i),block.timestamp - 15 days,block.timestamp - 1 days,friend,borrow_d,return_d));
//                 //title_search[book_name[i]] = i;
//             }
//              /*booklist.push(Book(nouser,0,"BlockChain",0,1,6,100,Date(2020,7,24),friend));
//              booklist.push(Book(nouser,1,"Cooking for Geek",0,1,3,100,Date(2020,6,29),friend));
//              booklist.push(Book(nouser,2,"GitHub 入門",0,1,7,100,Date(2020,6,18),friend));
//              */
             
//         uint256[] memory a;
        
//         address[7] memory member = [lib,//(図書館)
//                             address(0xAbf977caE05A77D85577d58fE03D19639849ea01),//(及川)
//                             address(0x324bAF512Ffc6f37D91F9fE3F3464a7eA792AaeF),//(XU KAIWEN)
//                             address(0xEd8e2574FA50244c5bE1e1b4c58892e3ad0FcBFa),//(菊地)
//                             address(0xc8eDA6054Eb36457dad52C7E734CD282e2a3575A),//金
//                             address(0xaf4a4BA302A069dF4ffDDdEc73A8957580747462),//発表
//                             address(0xf7e2F21898232ebB57F280D31Dc004153f5681EE)];//発表
//         string[7] memory member_name = ["図書館","及川","XU KAIWEN","菊地","金","発表","発表"];
//         //Record[] memory rec;
//         for (uint i = 0; i < member.length; i++) {
//             studentlist.push(Student(member[i], 1111111*(i+1), member_name[i], P, a, a, today()-1));
//             /*
//             for(uint256 j = 8; j < 12; j++){
//                 studentlist[i].borrowed_book.push(j);
//             }
//             */
//             studentlist[i].borrowed_book.push(6);
//             studentlist[i].borrowed_book.push(4);
//             studentlist[i].borrowed_book.push(15);
//             studentlist[i].borrowed_book.push(10);
//             for(uint256 j = 4; j < 8; j++){
//                 studentlist[i].reserved_book.push(j);
//             }
//             //studentlist[i].rec.push(Record(Date(2020, 7, 27), 10, "初期ポイント"));
//             students[member[i]] = i;
//         }
//         // studentlist.push(Student(oikawa, 1111111, "A", P, a, a, today()));
//         // studentlist.push(Student(address(0x321), 2222222, "B", P, a, a, today()));
//     }
    
//     mapping(uint256 => address) public userBook; //本(固有番号)　=> ユーザー
//     //mapping(string => uint256) public title_search;//本のタイトル　=> 本(固有番号)
// /*
//     function returnBook(uint256 num) view public {
//         require(num < booklist.length);
//         if(msg.sender == userBook[num]){ //ユーザが実際に本を借りた
//             userBook[num] = address(0x0);
//             booklist[num].status = 1;
//             booklist[num].left++;
//         }
//     }
// */


//     function borrowBook(uint256 num) public {
//         require(num < booklist.length);

//         if(booklist[num].left != 0){ // 図書館に借りたい本がある
//             booklist[num].status = 0;
//             booklist[num].left--;
//             for (uint256 i = 0; i < booklist[num].friends.length; i++){
//                 booklist[booklist[num].friends[i]].left--;
//             }
//             //booklist[num].return_date =  ;//貸し出し日から計算したい
            
//             //userBook[msg.sender] = bookNum[book];
//         }
//         else{
            
//         }
        
//     }
//     //207
//     function BookInformation(uint256 num) public view returns(Book memory) {
//         return booklist[num];
//     }
    
    
//     function UserInformation() public view returns(Student memory){
//         uint256 num = students[msg.sender];
//         return studentlist[num];
//     }
//     /*
//     function UserInformation() public view returns(uint256[] memory,uint256[] memory){
//         uint256 num = students[msg.sender];    
//         return (studentlist[num].borrowed_book, studentlist[num].reserved_book);
//     }
//     */
    
//     function today() public view returns (uint256) {
//         return block.timestamp / 1 days;
//     }
    
//     function foo(string memory str1, string memory str2) public view returns(string memory){
//         bytes memory strbyte1 = bytes(str1);
//         bytes memory strbyte2 = bytes(str2);

//         bytes memory str = new bytes(strbyte1.length + strbyte2.length);

//         uint8 point = 0;

//         for(uint8 j = 0; j < strbyte1.length;j++){
//             str[point] = strbyte1[j];
//             point++;
//         }
//         for(uint8 k = 0; k < strbyte2.length;k++){
//             str[point] = strbyte2[k];
//             point++;
//         }
//         return string(str);
//     }

//     function update() public {
//         uint256 stu = students[msg.sender];
//         // 日付が変わっていれば、使用値とチェック日付をリセットする
//         uint256 tod = today();
//         if (tod > studentlist[stu].lastDay) { // 更新してるかどうか
//             //ポイント更新　延滞テェック
//             for(uint256 i = 0; i < studentlist[stu].borrowed_book.length; i++){ 
//                 if(booklist[studentlist[stu].borrowed_book[i]].return_date / 1 days < tod){ // 返却日を過ぎてる
//                     //studentlist[stu].point -= (int)(tod - (booklist[studentlist[stu].borrowed_book[i]].return_date / 1 days)) * 10;
//                     int decPoint;
//                     if(booklist[studentlist[stu].borrowed_book[i]].return_date / 1 days < studentlist[stu].lastDay) {
//                         decPoint = (int)(tod - studentlist[stu].lastDay) * 10;
//                     } else{
//                          decPoint = (int)(tod - (booklist[studentlist[stu].borrowed_book[i]].return_date / 1 days)) * 10;
//                     }
//                     studentlist[stu].point -= decPoint;
                    
//                     //studentlist[stu].rec.push(Record(Date(2020, 7,27),-decPoint,foo(foo("「", booklist[studentlist[stu].borrowed_book[i]].name),"」延滞分")));
//                 }
//             }
//             if (studentlist[stu].point > 0) {
//                 studentlist[stu].point++; // ログインボーナス
//                 //studentlist[stu].rec.push(Record(Date(2020, 7,27),1,"ログインボーナス"));
//             }
//             studentlist[stu].lastDay = tod;//最終更新日を更新
//         }
//     }
    


//     function return_point() public view returns (int256 point) {
//         return studentlist[students[msg.sender]].point;
//     }

//     function pay() public payable {//0.0000001ethで1ポイント回復
//         //address payable lib = (address,payable)(0x5718bB3653623219e49609E355F4F60369F73cD3);
//         //uint balance = gotten_point * 0.0000001;
//         require(msg.value >= 1000000000000000);
//         int256 gotten_point = (int)(msg.value / 1000000000000000); // wei

//         uint256 stu = students[msg.sender];
//         studentlist[stu].point += gotten_point;
        
//         //studentlist[stu].rec.push(Record(Date(2020,7,24),gotten_point,"チャージ"));
//     }

//     function withdraw() public {
//         if (msg.sender == lib)
//         msg.sender.transfer(address(this).balance);
//     }

//     function search(string memory title) public view returns (Book[5] memory){
//         Book[5] memory list;
//         uint cnt = 0;
//         for(uint256 i = 0; i < booklist.length && cnt < 5; i++){
//            //if(keccak256(abi.encodePacked(booklist[i].name)) == keccak256(abi.encodePacked((title)))) return booklist[i];
//            if (KMPSearch(booklist[i].name, title)){
//                //list.push(booklist[i]);
//                //list[list.length] = booklist[i];
//                list[cnt] = booklist[i];
//                cnt += 1;
//            }
//         }

//         return list;
//     }

//     function KMPSearch(string memory _target, string memory _pattern) public view returns (bool){
//         bytes memory target = bytes(_target);
//         bytes memory pattern = bytes(_pattern);
        
//         // ずらし表の作成
//         uint[100] memory table = CreateTable(pattern);

//         // 文字列探索
//         uint256 i = 0;
//         uint256 p = 0;
//         while (i < target.length && p < pattern.length) {
//             if (keccak256(abi.encodePacked(target[i])) == keccak256(abi.encodePacked(pattern[p]))) {
//                 // 文字が一致していれば次の文字に進む
//                 i++; p++;
//             }
//             else if (p == 0) { // パターン先頭文字が不一致の場合、次の文字
//                 i++;
//             }
//             else { // 不一致の場合、パターンのどの位置から再開するか設定
//                 p = table[p];
//             }
//         }
//         if (p == pattern.length) {
//             return true;
//         }
//         return false;
//     }

//     // ずらし表の生成
//     function CreateTable(bytes memory pattern) public view returns (uint[100] memory) {
//         uint[100] memory table;
//         table[0] = 0;

//         uint256 j = 0;
//         for (uint256 i = 1; i < pattern.length; i++){
//             if (keccak256(abi.encodePacked(pattern[i])) == keccak256(abi.encodePacked(pattern[j]))){
//                 table[i] = j++;
//             }
//             else{
//                 table[i] = j;
//                 j = 0;
//             }
//         }
//         return table;
//     }
}