//+------------------------------------------------------------------+
//|                                                         sell.mq4 |
//|                                    Copyright 2018, Jens Hoffmann |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Jens Hoffmann"
#property link      ""
#property version   "1.00"
#property strict

#include <order.mqh>


void OnStart() {
   Order order = get_order(OP_SELL);
   Alert("Order size: ", order.size);
   if (OrderSend(Symbol(), OP_SELL, order.size, Bid, 10, 0, 0) < 0) {
      Alert(GetLastError());
      return;
   }
   ObjectCreate(0, "STOP LOSS SELL", OBJ_HLINE, 0, 0, order.stop);
   ObjectSet("STOP LOSS SELL", OBJPROP_WIDTH, 3);
}