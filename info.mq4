//+------------------------------------------------------------------+
//|                                                         info.mq4 |
//|                                    Copyright 2018, Jens Hoffmann |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Jens Hoffmann"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


#include <order.mqh>

void OnStart() {
   Order order = get_order(OP_BUY);
   Alert("Order size buy: ", order.size, " Volatility: ", order.volatility);
}