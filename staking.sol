pragma solidity >=0.4.22 <0.9.0;
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/utils/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/access/Ownable.sol";

contract Staking is ERC20,Ownable{
        using SafeMath for uint256;
        address public Owner;
        constructor(address _owner,uint256 _supply)public{
            _mint(_owner,_supply);
            Owner=_owner;
        }
        //Keeping track of stakeholders
        address[]internal stakeholders;
        mapping(address => uint256)internal stakes;
        mapping(address => uint)internal rewards;
       
        function isStakeholder (address _address)public view returns(bool,uint256)
        {
            for(uint s=0;s <stakeholders.length;s +=1){
                if(_address == stakeholders[s]) return (true,s);

            }
            return(false,0);
        }
        function addStakeholder(address _stakeholder)public
        {
            (bool _isStakeholder,)=isStakeholder(_stakeholder);
            if(!_isStakeholder) stakeholders.push(_stakeholder);
        }
        /*
            A method to remove a stakeholder
        */
        function removeStakeholder(address _stakeholder)public
        {
            (bool _isStakeholder,uint256 s) = isStakeholder(_stakeholder);
            if(_isStakeholder){
                stakeholders[s]=stakeholders[stakeholders.length - 1];
                stakeholders.pop();
            }
        }
        /*function to get the stake of  each stake holder*/
        function  stakeof(address _stakeholder)public view returns(uint256){
          return stakes[_stakeholder];
        }
        function rewardof(address _stakeholder)public view returns(uint256){
            return rewards[_stakeholder];
        }
        /*A method to get aggregated stakes*/
        function totalStakes()public view returns(uint)
        {
            uint _totalStakes =0;
            for(uint s=0;s <stakeholders.length;s +=1){
                _totalStakes=_totalStakes.add(stakes[stakeholders[s]]);
            }
            return _totalStakes;
        }
        function totalRewards()public view returns(uint256)
        {
            uint _totalRewards =0;
            for(uint s=0;s< stakeholders.length ;s +=1){
                _totalRewards =_totalRewards.add(rewards[stakeholders[s]]);
            }
            return _totalRewards;
        }
        /*calcululate reward*/
        function calculateReward(address _stakeholder)public view returns(uint)
        {
            return stakes[_stakeholder] /100;
        }

        function distributeRewards()public onlyOwner{
            for (uint s=0;s<stakeholders.length;s +=1){
                address stakeholder =stakeholders[s];
                uint reward =calculateReward(stakeholder);
                rewards[stakeholder]=rewards[stakeholder].add(reward);
            }
        }
        function withdrawReward()public {
            uint reward =rewards[msg.sender];
            rewards[msg.sender]=0;
            _mint(msg.sender,reward);
            
        }


 }