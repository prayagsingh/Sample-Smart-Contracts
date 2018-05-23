pragma solidity ^0.4.1;

library String {
    
    function concat(string _base, string _value) internal returns(string){
        bytes memory _basebytes = bytes(_base);
        bytes memory _valuebytes = bytes(_value);
        
        string memory _tmpValue = new string(_basebytes.length + _valuebytes.length);
        bytes memory _newValue = bytes(_tmpValue);
        
        uint i;
        uint j;
        
        for(i=0;i<_basebytes.length;i++){
            _newValue[j++] = _basebytes[i];
        }
        
        for(i=0;i<_basebytes.length;i++){
            _newValue[j++] = _valuebytes[i];
        } 
        
        return string(_newValue);
    }
    
    function strpos(string _base, string _value) internal returns(int){
        bytes memory _basebytes = bytes(_base);
        bytes memory _valuebytes = bytes(_value);
        
        assert(_valuebytes.length >= 1);
        
        for(uint i=0;i<_basebytes.length;i++){
            if (_basebytes[i] == _valuebytes[0]){
                return int(i);
            }
        }
        
        return -1;
    }
}

contract TestLib{
    using String for string;
    
    function testConcat(string _base) public returns(string){
        return _base.concat("_suffix");    
    }
    
    function testStrpos(string _base, string _value) public returns (int){
        return _base.strpos(_value);
    }
}
