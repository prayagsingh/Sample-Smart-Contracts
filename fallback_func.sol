pragma solidity ^0.4.1;

contract Transaction {
    
    event SenderLogger(address);
    event ValueLogger(uint);
    
    address private owner;
    
    constructor (){
        owner = msg.sender;
    }
    
    modifier onlyAdmin(){
        require(owner == msg.sender);
        _;
    }
    
    modifier validValue(){
        assert(msg.value >= 1 ether);
        _;
    }
    
    function () private payable onlyAdmin validValue{
        emit SenderLogger(msg.sender);
        emit ValueLogger(msg.value);
    }
}
