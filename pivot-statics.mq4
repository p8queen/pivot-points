//+------------------------------------------------------------------+
//|                                                pivot-statics.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict

double pivot;
int candle;
string touch;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
//---
//   for(candle=3000;candle<7000;candle++){
//      pivot = iCustom(Symbol(),0,"pivot-by-week",0,candle+120);
//      if(High[candle]>pivot && pivot >0){
//         if(High[candle]-pivot>1000*Point){
//            touch = pivotIsTouched(candle,pivot,240);
//            Print("vela: ",candle,", fecha: ", Time[candle], ", pivot was touched?: ",touch);
//            
//            }
//         }
//      }
    
     for(candle=1;candle<3000;candle++){
      pivot = iCustom(Symbol(),0,"pivot-by-week",0,candle+120);
      if(Low[candle]<pivot && pivot >0){
         if(pivot-Low[candle]>1000*Point){
            touch = pivotIsTouched(candle,pivot,240);
            Print("vela: ",candle,", fecha: ", Time[candle], ", pivot was touched?: ",touch);
            
            }
         }
     }
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


string pivotIsTouched(int intCandle,double dblPivot,int deep){
   int lowest;   
   lowest = iHighest(Symbol(),PERIOD_H1,MODE_HIGH,deep,intCandle-deep);
   if(High[lowest]>=dblPivot){
      return "yes";
   }else{
      return "no";
      }
   
   }