// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0; 

contract SolidityConcepts {

    uint public constant FIXED_VALUE = 100;
    uint public value = 50;
    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }
    
    receive() external payable{}

    function sendEther(address payable _to) public payable{
        require(msg.value > 0, "Must send ether");
        _to.transfer(msg.value);
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function withDraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
  
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function ownerFunction() public onlyOwner view returns(string memory){
        return "Hello, Owner!";
    }


    function setValue(uint _newValue) public onlyOwner{
        uint oldValue = value;
        value = _newValue;
        emit ValueChanged(oldValue, _newValue);
    }


    event ValueChanged(uint oldValue,uint newValue);

   function updateValue(uint _newValue) public{
    uint oldValue = value;
    value = _newValue;
    emit ValueChanged(oldValue, _newValue);
   }

    function checkValue(uint _value) public pure returns(string memory){
        if(_value > FIXED_VALUE){
            return "Value is greater than 100";
        }else if(_value == FIXED_VALUE){
            return "Value is exactly 100";
        }else{
            return "Value is less than 100";
        }
    }

    function sumUpTo(uint _num)public pure returns(uint){
        uint sum = 0;
        for(uint i = 0;i <= _num;){
            sum += i;
            unchecked{
                i++;
            }
        }
        return sum;
    }
   
    

   
}
