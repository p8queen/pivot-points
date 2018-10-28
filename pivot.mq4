//+------------------------------------------------------------------+
//|                                                        pivot.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict

double pivot, pivotH, pivotL, pivotC, pivotR, pivotS, pivotAnterior;
double stopLoss;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
  stopLoss = 200*Point;       
  pivotAnterior = 0.0;
  
  
            
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
//--
  setPivot();
  setR1();
  setS1();
  Comment("pivot: ", pivotH, ", ",pivotL, ", ", pivotC, 
            "\n pivotR y pivotS: ", pivotR, ", ", pivotS ); 
            
  if(OrdersTotal()<=0 && MathAbs(Bid-pivot)>=200*Point && MathAbs(pivot-pivotAnterior)>30*Point){
      if(Bid>pivot)
         OrderSend(Symbol(),OP_SELL,0.01,Bid,10,Bid+stopLoss,pivot);
      
      if(Bid<pivot)
         OrderSend(Symbol(),OP_BUY,0.01,Ask,10,Ask-stopLoss,pivot);
         
      pivotAnterior = pivot;     
      }          
            
  }
//+------------------------------------------------------------------+

void setPivot(){

   //iHigh iLow iClose
  pivotH = iHigh(Symbol(),1440,1); 
  pivotL = iLow(Symbol(),1440,1); 
  pivotC = iClose(Symbol(),1440,1); 
  
  pivot = (pivotH + pivotL + pivotC)/3;

   
   }

void setR1(){
   pivotR = 2 * pivot - pivotL; 
   }
   
void setS1(){
   pivotS = 2 * pivot - pivotH;
   }