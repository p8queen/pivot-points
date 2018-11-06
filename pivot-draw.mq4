//+------------------------------------------------------------------+
//|                                                   pivot-draw.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict
#include "pivot-draw.mqh"


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   Print("/////////////************** INIT ***********///////////");
   setInitialTime();
   datetime NY_open = NY_close - 8*60*60; 
   Comment(NY_close, ", ", NY_open, ", day: ",TimeDayOfWeek(NY_close), ", ",TimeCurrent() );
   
   drawPivot(NY_close);
   drawWeeklyPivot(NY_close);
   
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
   
  }
//+------------------------------------------------------------------+
