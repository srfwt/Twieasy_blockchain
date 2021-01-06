pragma solidity ^0.4.19;

contract Poll{
    event Voted(address _voter, uint _value);
    mapping(address => uint) public votes;
    string pollSubject = "質問";
    
    function getPoll() constant public returns(string){
        return pollSubject;
    }
    
    function vote(uint selection) public {
        Voted(msg.sender, selection);
        require (votes[msg.sender] == 0);
        require (selection > 0 && selection < 3);
        votes[msg.sender] = selection;
    }
}
