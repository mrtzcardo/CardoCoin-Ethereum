// Version of compiler
pragma solidity ^0.4.12;

contract cardocoin_ico {
    
    // Introducing total number of cardocoins for sale
    uint public max_cardocoins = 1000000;
    
    // conversion rate for cardocoin to USD
    uint public usd_to_cardocoins = 1000;
    
    // number of cardocoins bought by investors
    uint public total_cardocoins_bought = 0;
    
     
     // mapping from the investor address to its equity in cardocoins and usd_to_cardocoins
     mapping(address => uint) equity_cardocoins;
     mapping(address => uint) equity_usd;
     
     // checking if an investpr can buy cardocoins
     modifier can_buy_cardocoins(uint usd_invested) {
         require (usd_invested * usd_to_cardocoins + total_cardocoins_bought <= max_cardocoins);
         _;
     }
     
     // getting the equity in cardocoins of an investor
     function equity_in_cardocoins(address investor) external constant returns (uint) {
         return equity_cardocoins[investor];
     }
     
     // getting the equity in USD of an investor
     function equity_in_usd(address investor) external constant returns (uint) {
         return equity_usd[investor];
     }
     
     // buying cardocoins
     function buy_cardocoins(address investor, uint usd_invested) external 
     can_buy_cardocoins(usd_invested) {
         // new variable for amount of cardocoins that are being bought with usd conversion
         uint cardocoins_bought = usd_invested * usd_to_cardocoins;
         
         // updates the amount of cardocoins this investor now has
         equity_cardocoins[investor] += cardocoins_bought;
        
        /// updates the amount of cardocoins in USD this investor now has
         equity_usd[investor] = equity_cardocoins[investor] / 1000;
         
         // update total number of cardocoins bought
         total_cardocoins_bought += cardocoins_bought;

     }
     
     // buying cardocoins
     function sell_cardocoins(address investor, uint cardocoins_sold) external {
         // updates the amount of cardocoins this investor now has
         equity_cardocoins[investor] -= cardocoins_sold;
        
        /// updates the equity of cardocoins in USD this investor now has
         equity_usd[investor] = equity_cardocoins[investor] / 1000;
         
         // update total number of cardocoins bought
         total_cardocoins_bought -= cardocoins_sold;

     }
}