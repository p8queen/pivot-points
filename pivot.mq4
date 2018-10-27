//+------------------------------------------------------------------+
//|                                                        pivot.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict

double pivot, pivotH, pivotL, pivotC, pivotR, pivotS;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
         
  //iHigh iLow iClose
  pivotH = iHigh(Symbol(),1440,1); 
  pivotL = iLow(Symbol(),1440,1); 
  pivotC = iClose(Symbol(),1440,1); 
  
  pivot = (pivotH + pivotL + pivotC)/3;
  
  pivotS = 2 * pivot - pivotH;
  pivotR = 2 * pivot - pivotL;
  Comment("pivot: ", pivotH, ", ",pivotL, ", ", pivotC, 
            "\n pivotR y pivotS: ", pivotR, ", ", pivotS );
            
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
