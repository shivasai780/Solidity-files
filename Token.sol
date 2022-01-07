pragma solidity >=0.4.22 <0.9.0;
import "../node_modules/openzeppelin-solidity/contracts/token/ERC1155/ERC1155.sol";

contract Token is ERC1155 {  
    address payable public Owner;
    uint public auctionEndTime;
    uint public Highestbid;
    address public Highestbidder;
    mapping(address => uint)pendingreturns;
    bool ended;
    modifier Only_Owner(){
        require(msg.sender == Owner);
        _;
    }
   constructor(string memory _uri,uint bidtime)ERC1155(_uri){
       Owner=payable(msg.sender);
       auctionEndTime=(block.timestamp)+bidtime;
   }
   function mint(address _account, uint256 _id, uint256 _amount, bytes memory _data)public{
       _mint(_account,_id,_amount,_data);
   }
   function mint_batch(address _to, uint256[] memory _ids, uint256[] memory _amounts, bytes memory _data )public {
        _mintBatch(_to,_ids,_amounts,_data);
   }
   function bid()external payable returns(bool){

       //checks
      // require(block.timestamp < auctionEndTime);
       require(msg.value > Highestbid);
       if(Highestbid !=0){
           pendingreturns[Highestbidder]=Highestbid;
       }
       Highestbid=msg.value;
       Highestbidder=msg.sender;
       return true;
   }
   function Withdraw()external returns(bool){
       //checks
       uint amount=pendingreturns[msg.sender];
       if(amount >0){
           pendingreturns[msg.sender]=0;
           payable(msg.sender) .transfer(amount);
       }
       return true;
   }
   function auctionEnd(address from,uint[] calldata _ids,uint[] calldata _amounts,bytes calldata _data) Only_Owner external{
       require(block.timestamp >= auctionEndTime);
       require(!ended);
       ended=true;
       safeBatchTransferFrom(from,Highestbidder,_ids,_amounts,_data);
   }
}
