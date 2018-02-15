pragma solidity ^0.4.11;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";
//import "strings.sol";

contract Weather_Bet is usingOraclize{
    
    struct Bet {
        
        uint amount_put; //amount put on the bet
        address addr; // address of the user
        uint temperature; // temp set by the user for bet
        
    } 
    // static variables
    uint CURRENT_TEMP;  
    address public owner; // owner of the contract
    uint public total_balance; //total amount put on the bet by both users
    bytes8[] private users;
  
    /// Event for debugging
    event Log(string text);
    event check_address(address ADDRESS);
    event BetEvent(uint amount, uint win, address sender, uint temperature);
    
    //mapping
    mapping(bytes8 => Bet) private bets;
    mapping(address => uint) matches_won;
    mapping(address => uint) check_final_amount;
    
    //constructor
    function Weather_Bet(bytes8[] candidates) public{
        users = candidates;
        owner = msg.sender;
        get_temperature_status();
    }
    
    // Getting a temperature from the web
    function get_temperature_status() payable{
        Log("Oraclize query was sent, waiting for the answer.."); 
        oraclize_query("URL","json(http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22).main.temp");
  
    }
    
    //callback function for Oraclize
    function __callback(bytes32 _myid, string _result) {
        require (msg.sender == oraclize_cbAddress());
        Log(_result);
        CURRENT_TEMP = parseInt(_result);
    }
    
    // It will return the CURRENT_TEMPERATURE
    function curr_temp() constant returns(uint){
        return CURRENT_TEMP;
        
    }
    
    /********************************************************************************/
    //          FUNCTION FOR SETTING THE BET
    /********************************************************************************/
    function setBet(bytes8 user, uint8 _amount, uint _temperature) {
        require(msg.sender != owner);
        bets[user].amount_put = _amount;
        bets[user].addr = msg.sender;
        bets[user].temperature = _temperature;
        total_balance += _amount;
        //betSums[_amount] += _amount;
//        BetEvent(b.amount, b.win, b.addr, b.temperature);
    }
    
    function winner(bytes8 userA, bytes8 userB ) constant returns(string){
        require(owner == msg.sender); // only the contract owner cam check the winner
        if (bets[userA].temperature > CURRENT_TEMP){
            matches_won[msg.sender] +=1;
            bets[userA].addr.send(total_balance);
            return ("UserA won the bet");
   
        }
        else if (bets[userB].temperature < CURRENT_TEMP){
            matches_won[msg.sender] +=1;
            bets[userB].addr.send(total_balance);
            return("UserB won the bet");
        }
        
        else if(bets[userA].temperature == CURRENT_TEMP || bets[userB].temperature == CURRENT_TEMP){
            bets[userA].addr.send(bets[userA].amount_put);
            bets[userB].addr.send(bets[userB].amount_put);
            return("Both bet on the same temperature");
        
        }
    }
    
    function check_final_amount_won(bytes8 user) constant returns(uint){
        check_address(msg.sender);
        Log("This block is executed");
        address ADDRESS = bets[user].addr;
        return check_final_amount[ADDRESS];
            
    }
    
//    function winning(){}
    
//    function losing() {}
    
//    function draw() {}
    
}
