//+------------------------------------------------------------------+
//|                                                          buy.mq4 |
//|                                    Copyright 2018, Jens Hoffmann |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Jens Hoffmann"
#property link      ""
#property version   "1.00"
#property strict

#include <order.mqh>

void OnStart() {
   Order order = get_order(OP_BUY);
   Alert("Order size: ", order.size);
   if (OrderSend(Symbol(), OP_BUY, order.size, Ask, 10, 0, 0) < 0) {
      Alert(GetLastError());
      return;
   }
}