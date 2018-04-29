pragma solidity^0.4.2;

contract A{
    address admin;
    function abstarct_contract(string name) returns(string);

    event Check_opt(string);
}


contract B is A{
    function abstarct_contract(string name) returns(string){
        emit Check_opt(name);
        return name;
   }
}
contract C is B{
  
    function check_condition(string name) returns(string){
        emit Check_opt(name);
        return name;
    }
}
