pragma solidity ^0.4.16;
import "./DateTime.sol";
contract Time is DateTime{
    
    //DateTime datetime;
    _DateTime datetime;
   /* function Time(address _datetime)public{
        datetime=_datetime;
    }
    function(uint timestamp)public returns(uint ){
        
    }*/
    function get(uint timestamp) public returns(uint){
        datetime = parseTimestamp(timestamp);
        return datetime.year;
    }
}