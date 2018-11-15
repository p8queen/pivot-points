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
double pivotLastFriday;
double pivots[5]; //price, number of day.
double weeklyPivot[30];

void setInitialTime(){
   if(TimeCurrent()<NY_close) 
      NY_close -= 24*60*60;
   
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
   for(int i=0;i<300;i++){
      candle_close = iBarShift(Symbol(),PERIOD_H1,date_close);
      pivot = getPivot(candle_close);
      //save pivots for weeklypivot
      drawLineOfPivot("pivot-"+IntegerToString(i), pivot, date_close);
      
      
      
      date_close -= 24*60*60;
      if(TimeDayOfWeek(date_close)==0) //sunday
         date_close -= 48*60*60;
      if(TimeDayOfWeek(date_close)==6) //saturday
         date_close -= 24*60*60;
      
      }
 }

double getPivot(int fromCandle){
   //period="day" or "week"
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
   

     
 void drawWeeklyPivot(datetime date_close){
 
   Comment("pivot-1 price: ", ObjectGet("pivot-2",OBJPROP_PRICE1), 
         "\n pivot-1 time: ", TimeToStr(ObjectGet("pivot-2",OBJPROP_TIME2)), 
         "\n pivot-1 day of the week: ",TimeDayOfWeek(ObjectGet("pivot-2",OBJPROP_TIME2))
         );
   datetime dtmClose;
   int p=-1 ; //ObjectGet pivot-0, ..., pivot-n
   bool lastFriday = false;
   double dblWeeklyPivot = 0;
   while(!lastFriday){
         p++;
         dtmClose = ObjectGet("pivot-"+IntegerToString(p),OBJPROP_TIME2);
         if(TimeDayOfWeek(dtmClose)==5)  //friday
            lastFriday = true;
          }
          dblWeeklyPivot += ObjectGet("pivot-"+IntegerToString(p),OBJPROP_PRICE1);
   
   while(p<300){
         p++;
         Comment(dblWeeklyPivot, ", ",p);
         dtmClose = ObjectGet("pivot-"+IntegerToString(p),OBJPROP_TIME2);
         dblWeeklyPivot += ObjectGet("pivot-"+IntegerToString(p),OBJPROP_PRICE1);
         if(TimeDayOfWeek(dtmClose) == 1){ // is monday, draw The Line
               dblWeeklyPivot = dblWeeklyPivot/5;
               drawLineOfWeeklyPivot("pivotWeekly-"+IntegerToString(p),dtmClose,dblWeeklyPivot);
               dblWeeklyPivot = 0 ;
               }
         }

   //Comment("weekly pivot: ",dblWeeklyPivot );
   
   
   
   }
 
void drawLineOfWeeklyPivot(string name ,datetime closeMonday,double dblPivotOfTheWeek){

   ObjectDelete(0,name);
   ObjectCreate(0,name, OBJ_TREND, 0, closeMonday-8*60*60, dblPivotOfTheWeek,closeMonday+24*4*60*60 , dblPivotOfTheWeek );
   ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,false);
   ObjectSet(name,OBJPROP_STYLE, STYLE_DASHDOT);
   ObjectSet(name,OBJPROP_COLOR,clrWhite);
   ObjectSet(name,OBJPROP_WIDTH,1);




      }
 