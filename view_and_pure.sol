pragma solidity^0.4.2;
// In this contract we are checking the difference between the view and pure 
// In case of view ---> it is similar to the constant and didn't alter the storage 
// In case of pure ---> it implements the funtionality of view as well and it won't write anything to the storage as well
// In case of pure  --> all the data the function is concerned with is either passed in or defined in its scope
contract A {
    
    string name;
    // can't set pure or view beacuse of data is get written to storage
    function input_name(string _name) public {
        name = _name;
    }
    // can be mark as view or pure
    // here pure is the best approach as it has the full funtionality of view 
    function check_view_wthout_input() view returns(string){
        return "This is for checking view method";
    }
    
    function check_view_wth_input() view returns(string){
        return name;
    } 
    
    function check_pure_wthout_input() pure returns(string){
        return "This is pure function";
    }
    
    function check_pure_wth_input(string anystirng) pure returns(string){
        return anystirng;
    }
}
