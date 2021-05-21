pragma solidity ^0.4.17;
contract AccountManager{
    
    struct Address{
        string Addressline1;
        string Addressline2;
        string City;
        string State;
        uint Pincode;
    }
    enum Gender{Male,Female,Other}
    struct Account{
        string FirstName;
        string LastName;
        uint Age;
        Gender gen;
        Address AccountAdress;
    }
   
    mapping (address => uint) public balances;//check the balance of an account
    mapping(address=>bool) public  Account_addresses;//Check if account exit or not
    mapping(address=>Account) Accounts;
    modifier CheckAccount(address _Owner,bool _Condition){
       require(Account_addresses[_Owner] == _Condition);
        _;
    }
    function Create_Account(string _FirstName,string _LastName,uint _Age,Gender _Gender,string _Addressline1,string _Addressline2,string _City,string _State,uint _Pincode)public CheckAccount(msg.sender,false) {
        Account_addresses[msg.sender]=true;
        Account storage new_account=Accounts[msg.sender];
        new_account.FirstName=_FirstName;
        new_account.LastName=_LastName;
        new_account.Age=_Age;
        new_account.gen=_Gender;
       /* new_account.AccountAdress=Address({
                                      Addressline1:_Addressline1,
                                      Addressline2:_Addressline2,
                                      City:_City,
                                      State:_State,
                                      Pincode:_Pincode
        });*/
        // other way is create a copy and assign it to the struct variable
          Address memory new_address=Address({
                                        Addressline1:_Addressline1,
                                        Addressline2:_Addressline2,
                                        City:_City,
                                        State:_State,
                                        Pincode:_Pincode
                                      });
          new_account.AccountAdress=new_address;
        
    }
    function Edit_Account(string _FirstName,string _LastName,uint _Age,Gender _Gender,string _Addressline1,string _Addressline2,string _City,string _State,uint _Pincode)public CheckAccount(msg.sender,true){
       // require(Account_addresses[msg.sender]==true);
        Account storage new_account=Accounts[msg.sender];
        new_account.FirstName=_FirstName;
        new_account.LastName=_LastName;
        new_account.Age=_Age;
        new_account.gen=_Gender;
        new_account.AccountAdress=Address({
                                      Addressline1:_Addressline1,
                                      Addressline2:_Addressline2,
                                      City:_City,
                                      State:_State,
                                      Pincode:_Pincode
        });
        
    }
    function Deposit_Balance(address _Adresss)public CheckAccount(_Adresss,true) payable{
        /*require(Account_addresses[_Adresss]==true);
          _Adresss.transfer(msg.value);*/
        balances[_Adresss] += msg.value;
    }
    function Withdraw_Balance(uint _balance)public CheckAccount(msg.sender,true) {
     
       require(_balance <= balances[msg.sender]);
       
       balances[msg.sender] -=_balance ;
       msg.sender.transfer(_balance);
       
        
    }
    
    function Get_gender(address _Adress)public view returns(string){
        if (Accounts[_Adress].gen==Gender.Male) return 'Male';
        if (Accounts[_Adress].gen==Gender.Female) return 'Female';
        return "Other";
    }
    
    
}