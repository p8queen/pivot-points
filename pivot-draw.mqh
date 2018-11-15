//+------------------------------------------------------------------+
//|                                                   pivot-draw.mqh |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property strict


//set initial time
datetime NY_close = D'23:00';


void setInitialTime(){
   if(TimeCurrent()<NY_close) 
      NY_close -= 24*60*60;
   
   if(TimeDayOfWeek(NY_close)==0)
      NY_close -= 48*60*60;
   if(TimeDayOfWeek(NY_close)==6)
      NY_close -= 24*60*60;
      
   //set NY_close to last friday
   if(TimeDayOfWeek(NY_close)>=1 && TimeDayOfWeek(NY_close)<=4)
      NY_close = NY_close-48*60*60-TimeDayOfWeek(NY_close)*24*60*60;
   
   }

 void drawWeeklyPivot(datetime date_close){
 
   int p=0;  
   while(p<30){
         drawLineOfWeeklyPivot("pivotWeekly-"+IntegerToString(p),date_close,getPivot(date_close));
         date_close = date_close - 7*24*60*60;
         p++;
         }
   }
   
   
double getPivot(datetime fromDate){
   //period="day" or "week"
   //fromCandle is candle close, last candle of the session
  int fromCandle = iBarShift(Symbol(),PERIOD_H1,fromDate); 
  int firstCandle = iBarShift(Symbol(),PERIOD_H1,fromDate-23*60*60-4*24*60*60);
  double dblPivot=0, valClose=0;
  double valHigh=0;
  double valLow = 0;
  int val_index=iHighest(Symbol(),PERIOD_H1,MODE_HIGH,firstCandle-fromCandle,fromCandle); //get the highest candle
  if(val_index!=-1) valHigh=iHigh(Symbol(),PERIOD_H1,val_index); //get the highest value
   
   int valLow_index=iLowest(Symbol(),PERIOD_H1,MODE_HIGH,firstCandle-fromCandle,fromCandle); //get the lowest candle
   if(valLow_index!=-1) valLow=iLow(Symbol(),PERIOD_H1,valLow_index); //get the low value
   valClose = iClose(Symbol(),PERIOD_H1,fromCandle); //get the close priece
   
   dblPivot = (valHigh+valLow+valClose)/3;
   return dblPivot;
   }
   
    


   
void drawLineOfWeeklyPivot(string name ,datetime closeWeek,double dblPivotOfTheWeek){

   ObjectDelete(0,name);
   ObjectCreate(0,name, OBJ_TREND, 0, closeWeek-24*4*60*60-23*60*60, dblPivotOfTheWeek,closeWeek , dblPivotOfTheWeek );
   ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,false);
   ObjectSet(name,OBJPROP_STYLE, STYLE_DASHDOT);
   ObjectSet(name,OBJPROP_COLOR,clrWhite);
   ObjectSet(name,OBJPROP_WIDTH,1);




      }
 