pragma solidity ^0.4.0;
// Custom Library file
library IntExtended {
    
    function increment(uint _base) pure public returns(uint){
        return _base+1;
    }
    
    function decrement(uint _base) pure public returns(uint){
        return _base-1;
    }
    
}
