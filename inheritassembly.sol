pragma solidity ^0.5.11;
contract store{
  address public implement;
  uint public total;
  uint public totalmultiply;
}
contract storageone is  store {
    address public extra1;
    uint public extra2;
}
contract proxy is store{
    
    function Changaimp(address _impl)public returns(bool){
      implement = _impl;
      return true;
  }
  function add(uint _a,uint _b)external{
      address _impl =implement;
      assembly{
          let ptr := mload(0x40)//loading the empty location of 32bytes
          calldatacopy(ptr,0,calldatasize)//copying the calldata to the empty location the first four bytes of data contains the method signature
          let result :=delegatecall(gas,_impl,ptr,calldatasize,0,0)//calling the function with the data ptr
      }
  }
  function mul(uint _a,uint _b)external{
      address _impl = implement;
      assembly{
          let ptr :=mload(0x40)
          calldatacopy(ptr,0,calldatasize)//copying the data to the empty location
          let result := delegatecall(gas,_impl,ptr,calldatasize,0,0)
      }
  }
}
contract implcontract1 is store{
    function add(uint a, uint b) public returns(uint) {
        total = a + b;
        return total;
    }
    function mul(uint _a,uint _b)public returns(uint){
        totalmultiply = _a*_b;
        return total;
    }
}
contract implcontract2 is storageone{
    function add(uint a, uint b) public returns(uint) {
        total = a + b + 2;
        return total;
    }
    function mul(uint _a,uint _b)public returns(uint){
        totalmultiply = _a*_b * 2;
        return total;
    }
}