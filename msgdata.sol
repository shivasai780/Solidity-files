contract PseudoMinimalProxy{
    address masterCopy;
    constructor(address _masterCopy){
        //notice that constructor of master copy is not called
        masterCopy = _masterCopy;
    }
    function forward() external returns(bytes memory){
        (bool success,bytes memory data)=masterCopy.delegatecall(msg.data);
        require(success);
        return data;
    }
}
//