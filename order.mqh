//+------------------------------------------------------------------+
//|                                                        order.mqh |
//|                                    Copyright 2018, Jens Hoffmann |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Jens Hoffmann"
#property link      "https://www.mql5.com"
#property strict

#define BALANCE_OFFSET 3541.47
#define RISK 0.02
#define MAX_SLIPPAGE 2.0

struct Order {
   double size;
   double stop;
   double volatility;
};

Order get_order(int operation) {
   string symbol = Symbol();
   string account_currency = AccountCurrency();
   string symbol_base = StringSubstr(symbol, 3, 3);
   double exchangePrice = 1.0;
   if (symbol_base != account_currency) {
      exchangePrice = MarketInfo(StringConcatenate(account_currency, symbol_base), MODE_ASK);
   }
   double balance = AccountBalance() - BALANCE_OFFSET;
   double risk = balance * RISK * exchangePrice;
   double bollingerLower = iBands(NULL, 0, 20, 2, 0, PRICE_LOW, MODE_LOWER, 0);
   double bollingerUpper = iBands(NULL, 0, 20, 2, 0, PRICE_HIGH, MODE_UPPER, 0);
   double volatility = bollingerUpper - bollingerLower;  // In Zielwährung
   double spread = MarketInfo(symbol, MODE_SPREAD);  // In Punkten
   double slippage = spread + spread / 2;  // In Punkten
   double delta = (volatility / Point) + slippage;  // In Punkten
   double lot_size = MarketInfo(symbol, MODE_LOTSIZE);
   double order_size = risk / (delta * Point * lot_size);
   double stop = 0.0;
   double bid_price = MarketInfo(symbol, MODE_BID);
   double stop_delta = risk / order_size / lot_size - slippage * Point;
   if (operation == OP_BUY) {
      stop = bid_price - stop_delta;
   } else if (operation == OP_SELL) {
      stop = bid_price + stop_delta;
   } else {
      Alert("No such operation: ", operation);
   }

   Order result;
   result.size =  NormalizeDouble(order_size, 2);
   result.stop = stop;
   result.volatility = delta;

   return (result);
}