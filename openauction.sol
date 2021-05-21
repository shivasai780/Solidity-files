pragma solidity ^0.5.0;
contract openauction{
    address payable public beneficiary;
    uint public auctionEndTime;
    
    //current state
    uint public Highestbid;
    address public Highestbidder;
    
    event Bidincreased(address _bidder,uint _amount);
    event AuctionCompleted(address _winner,uint _amount);
    
    bool ended;
    mapping(address => uint)public pendingreturns;
    constructor(address payable _beneficiary,uint bidtime)public{
        beneficiary =_beneficiary;
        auctionEndTime=now+bidtime;
    }
    function bid()public payable returns(bool) {
        //checks
        require(!ended);
        require(msg.value > Highestbid);
        if(Highestbid !=0){
            pendingreturns[Highestbidder] +=Highestbid;
            
        }
        Highestbidder=msg.sender;
        Highestbid=msg.value;
        return true;
    }
    function Withdraw()public returns(bool){
        //checks
        uint amount=pendingreturns[msg.sender];
        if(amount > 0){
            pendingreturns[msg.sender]=0;
            msg.sender.transfer(amount);
            
        }
        return true;
        
    }
    function auctionEnd()public{
        //checks
        require(now >= auctionEndTime);
        require(!ended);
        ended=true;
        beneficiary.transfer(Highestbid);
    }
}