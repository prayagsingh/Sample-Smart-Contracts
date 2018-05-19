pragma solidity ^0.4.0;
import "browser/import_lib.sol";

contract TestLibrary{
    using IntExtended for uint;
    
    function test(uint _val) public pure returns (uint){
        return _val.increment();
    }
    
    function test_dec(uint _val) public pure returns (uint){
        return _val.decrement();
    }
}
