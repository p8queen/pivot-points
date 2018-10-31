//+------------------------------------------------------------------+
//|                                                        pivot.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   datetime NY_open = D'15:00'; 
   datetime NY_close = NY_open + 9*60*60; 
  //ObjectCreate("PivotLine", OBJ_HLINE, 0, Time[20], Bid+20*Point,Time[5], Bid);
  ObjectDelete(0,"PivotTrend");
  ObjectCreate(0,"PivotTrend", OBJ_TREND, 0, NY_open, Bid, NY_close, Bid+100*Point);
  ObjectSetInteger(0,"PivotTrend",OBJPROP_RAY_RIGHT,false);
  ObjectSet("PivotTrend",OBJPROP_STYLE, STYLE_DASHDOT);
  ObjectSet("PivotTrend",OBJPROP_COLOR,clrWhite);
  ObjectSet("PivotTrend",OBJPROP_WIDTH,1);
  
  int candle_open = iBarShift(Symbol(),PERIOD_H1,NY_open);
  int candle_close = iBarShift(Symbol(),PERIOD_H1,NY_close);
  
  double valHigh=0;
  double valLow = 0;
  double valClose, pivot;
  int val_index=iHighest(Symbol(),PERIOD_H1,MODE_HIGH,9,candle_close);
   if(val_index!=-1) valHigh=iHigh(Symbol(),PERIOD_H1,val_index);
   
   int valLow_index=iLowest(Symbol(),PERIOD_H1,MODE_HIGH,9,candle_close);
   if(valLow_index!=-1) valLow=iLow(Symbol(),PERIOD_H1,valLow_index);
   valClose = iClose(Symbol(),PERIOD_H1,candle_close);
   
   pivot = (valHigh+valLow+valClose)/3;
  Comment("ibarshift_open and close: ",candle_open, ", ",candle_close,
         ",\n high value: ", valHigh, ", low value: ", valLow, ", close: ", valClose, ", pivot: ",pivot );


   ObjectDelete(0,"PivotTrend");
  ObjectCreate(0,"PivotTrend", OBJ_TREND, 0, NY_open, valHigh+100*Point, NY_close, valHigh+100*Point);
  ObjectSetInteger(0,"PivotTrend",OBJPROP_RAY_RIGHT,false);
  ObjectSet("PivotTrend",OBJPROP_STYLE, STYLE_DASHDOT);
  ObjectSet("PivotTrend",OBJPROP_COLOR,clrWhite);
  ObjectSet("PivotTrend",OBJPROP_WIDTH,1);


   string label = "pivotLine";
  // ObjectDelete(1,label);
  ObjectCreate(0,label, OBJ_TREND, 0, NY_open, pivot, NY_close, pivot);
  ObjectSetInteger(0,label,OBJPROP_RAY_RIGHT,false);
  ObjectSet(label,OBJPROP_STYLE, STYLE_DASHDOT);
  ObjectSet(label,OBJPROP_COLOR,clrYellow);
  ObjectSet(label,OBJPROP_WIDTH,1);              
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

            
  }
//+------------------------------------------------------------------+

