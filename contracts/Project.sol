pragma solidity ^0.8.0;

contract ProjectListing{
    constructor(){
        
    }
    
    struct Project{
        string name;
        string symbol;
        string webUrl;
        uint256 FundsToRaise;
        uint256 FundRaised;
        uint256 tokenUnitPrice;
        mapping (address => uint256) addressToAmount;
        mapping(address => uint256) 
       
    };
}