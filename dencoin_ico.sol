// Dencoins ICO

// Version of compiler
pragma solidity >=0.7.0 <0.9.0;

contract dencoin_ico {
    
    // Introducing the maximum number of Dencoins available for sail
    uint public max_dencoins = 1000000;
    
    // Introducing USD to Dencoin conversion rate
    uint public usd_to_dencoins = 1000;
    
    // Introducing total number of Dencoins that have been bought by investors
    uint public total_dencoins_bought = 0;
    
    // Mapping from the investor address to its equity and Dencoins and USD
    mapping(address => uint) equity_dencoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy Dencoins
    modifier can_buy_dencoins(uint usd_invested){
        require (usd_invested * usd_to_dencoins + total_dencoins_bought <= max_dencoins); // double check if should be < or <=
        _;
    }
    
    // Getting the equity in Dencoins of an investor
    function equity_in_dencoins(address investor) external view returns (uint){
        return equity_dencoins[investor];
    }
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns (uint){
        return equity_usd[investor];
    }
    
    // Buying Dencoins
    function buy_dencoins(address investor, uint usd_invested) external 
    can_buy_dencoins(usd_invested) {
        uint dencoins_bought = usd_invested * usd_to_dencoins;
        equity_dencoins[investor] += dencoins_bought;
        equity_usd[investor] = equity_dencoins[investor] / usd_to_dencoins;
        total_dencoins_bought += dencoins_bought;
    }
    
    // Selling dencoins_bought
     function sell_dencoins(address investor, uint dencoins_sold) external {
        equity_dencoins[investor] -= dencoins_sold;
        equity_usd[investor] = equity_dencoins[investor] / usd_to_dencoins;
        total_dencoins_bought -= dencoins_sold;
    }
}