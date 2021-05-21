pragma solidity ^0.4.17;
contract Mycontract{
    //Declare enum
    //Use enum
    //Accept enum as argument
    enum STATE {ACTIVE,INACTIVE}//0,1
    STATE public state;
    struct User{
        STATE state;
    }
    STATE constant defaultstate=STATE.INACTIVE;
    function setstate()public{
        state=STATE.ACTIVE;
    }
    //function getstate()external{
    //    if(state == STATE.ACTIVE){
            //do something
    //    }
        
    //}
    function bar(STATE _state)public returns(STATE){
        state=_state;
        return state;
    
    }
}