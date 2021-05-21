pragma solidity ^0.5.11;
contract proxy1{
  mapping(bytes32 => uint256) internal uIntStorage;
  mapping(bytes32 => uint256[]) internal uIntArrayStorage;
  mapping(bytes32 => string) internal stringStorage;
  mapping(bytes32 => address) internal addressStorage;
  mapping(bytes32 => bytes) internal bytesStorage;
  function Changaimp(address _impl)public returns(bool){
      addressStorage[bytes32("implement")] = _impl;
      return true;
  }
  function add(uint _a,uint _b)external returns(uint){
      addressStorage[bytes32("_impl")] = addressStorage[bytes32("implement")];
      assembly{
          let ptr := mload(0x40)//loading the empty location of 32bytes
          calldatacopy(ptr,0,calldatasize)//copying the calldata to the empty location the first four bytes of data contains the method signature
          let result :=delegatecall(gas,addressStorage[bytes32("_impl")],ptr,calldatasize,0,0)//calling the function with the data ptr
          let size := returndatasize
          returndatacopy(ptr, 0, size)             
      }
  }
  function mul(uint _a,uint _b)external returns(uint){
      addressStorage[bytes32("_impl")] = addressStorage[bytes32("implement")];
      assembly{
          let ptr :=mload(0x40)
          calldatacopy(ptr,0,calldatasize)//copying the data to the empty location
          let result := delegatecall(gas,addressStorage[bytes32("_impl")],ptr,calldatasize,0,0)
      }
}
contract implement1{
  mapping(bytes32 => uint256) internal uIntStorage;
  mapping(bytes32 => uint256[]) internal uIntArrayStorage;
  mapping(bytes32 => string) internal stringStorage;
  mapping(bytes32 => address) internal addressStorage;
  mapping(bytes32 => bytes) internal bytesStorage;
  function add(uint a, uint b) public returns(uint) {
        total = a + b;
        return total;
   }
  function mul(uint _a,uint _b)public returns(uint){
        totalmultiply = _a*_b;
        return total;
   }
  
}
