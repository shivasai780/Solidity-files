pragma solidity ^0.5.0;
interface InterfaceExample{
    
    function getStr()external view returns (string memory);
    function setValue(uint _num1,uint _num2)external;
    function add()external view returns(uint);
}

contract thisContract is InterfaceExample{
    uint private num1;
    uint private num2;
    function getStr()public view returns(string memory){
        return "Geeks For Geeks";
    }
    function setValue(uint _num1,uint _num2)public{
        num1=_num1;
        num2=_num2;
    }
    function add()public view returns(uint){
        return num1+num2;
    }
}
contract call{
    InterfaceExample obj;
    constructor() public{
        obj =new thisContract();
    }function getValue()public returns(string memory,uint){
        obj.setValue(10,16);
        return (obj.getStr(),obj.add());
    }
}