//+------------------------------------------------------------------+
//|                                                 pivot-trader.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict

double pivot, pivotAnterior;
int ticket;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   pivotAnterior = iCustom(Symbol(),0,"pivot-by-week",0,1+120);
   pivot = iCustom(Symbol(),0,"pivot-by-week",0,1);
   if(pivot>0 && OrdersTotal()==0 && High[1]>pivot+1000*Point)
      ticket=OrderSend(Symbol(),OP_SELL,0.01,Bid,10,Bid+2000*Point,pivot);
   if(pivotAnterior>0 && OrdersTotal()==0 && High[1]>pivotAnterior+1000*Point)
      ticket=OrderSend(Symbol(),OP_SELL,0.01,Bid,10,Bid+2000*Point,pivotAnterior);
  }
//+------------------------------------------------------------------+
