pragma solidity ^0.6.6;
contract Reciever{
    emit Received(address caller,uint amount,string message )
    function foo(string
     memory _message,uint amount) public payable returns(uint){
        emit Received(msg.sender,msg.value,_message);
        return _x+1;
    }
    function() external payable1{
        emit Received(msg.sender,msg.value,"Fallback was called")
    }
}
contract Caller{
    function testCallFoo(address payable _addr)public payable{
       
        (bool success,bytes memory data)=_addr.call{value:msg.value}(
                    abi.encodeWithSignature("foo(string,uint256)","call foo",123)
            );
        emit Responce(success,data);
    }
    function testCallDoesNotExist(address _addr)public{
        (bool success,bytes memory data)=_addr.call(
            
                abi.encodeWithSignature("doesNotEist()")
            );
        
    }
}