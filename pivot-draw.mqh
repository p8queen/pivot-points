//+------------------------------------------------------------------+
//|                                                   pivot-draw.mqh |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property strict


//set initial time
datetime NY_close = D'23:00' - 24*60*60; 

void setInitialTime(){
   if(TimeDayOfWeek(NY_close)==0)
      NY_close -= 48*60*60;
   if(TimeDayOfWeek(NY_close)==6)
      NY_close -= 24*60*60;
   }

void drawPivot(datetime date_close){
   //take close time, and draw pivot 
   //reading PERIOD_H1 candles
   double candle_close, pivot;
   
   //Print("Pivot: ", pivot);
   for(int i=0;i<100;i++){
      candle_close = iBarShift(Symbol(),PERIOD_H1,date_close);
      pivot = getPivot(candle_close);
      drawLineOfPivot("pivot-"+IntegerToString(i), pivot, date_close);
      date_close -= 24*60*60;
      if(TimeDayOfWeek(date_close)==0) //sunday
         date_close -= 48*60*60;
      if(TimeDayOfWeek(date_close)==6) //saturday
         date_close -= 24*60*60;
      
      }

   }

double getPivot(int fromCandle){
   //fromCandle is candle close, last candle of the session
  double dblPivot=0, valClose=0;
  double valHigh=0;
  double valLow = 0;
  int val_index=iHighest(Symbol(),PERIOD_H1,MODE_HIGH,8,fromCandle); //get the highest candle
  if(val_index!=-1) valHigh=iHigh(Symbol(),PERIOD_H1,val_index); //get the highest value
   
   int valLow_index=iLowest(Symbol(),PERIOD_H1,MODE_HIGH,8,fromCandle); //get the lowest candle
   if(valLow_index!=-1) valLow=iLow(Symbol(),PERIOD_H1,valLow_index); //get the low value
   valClose = iClose(Symbol(),PERIOD_H1,fromCandle); //get the close priece
   
   dblPivot = (valHigh+valLow+valClose)/3;
   return dblPivot;
   }
   
void drawLineOfPivot(string name, double price, datetime closeSession){
   //price is Y, candle close session is X
   //draw a line between close and open hours. 
   
   Print(name, " price ", price, "close Session: ", TimeToStr(closeSession)); 
   ObjectDelete(0,name);
   ObjectCreate(0,name, OBJ_TREND, 0, closeSession-8*60*60, price, closeSession, price);
   ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,false);
   ObjectSet(name,OBJPROP_STYLE, STYLE_DASHDOT);
   ObjectSet(name,OBJPROP_COLOR,clrYellow);
   ObjectSet(name,OBJPROP_WIDTH,1);

   }   