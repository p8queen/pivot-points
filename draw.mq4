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
   Print("/////////////************** INIT ***********///////////");
   datetime NY_close = D'23:00'; 
   datetime NY_open = NY_close - 9*60*60; 
    
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



   string output = "ibarshift_open and close: "+IntegerToString(candle_open) + ", "+ IntegerToString(candle_close) + 
         ",\n high value: "+ DoubleToString(valHigh,Digits)+ ", low value: "+DoubleToString(valLow,Digits)+ "\n close: " +
         DoubleToString(valClose,Digits) +"\n pivot: "+ DoubleToString(pivot,Digits) ;
         
   int z =0;
   string upperLine, pivotLine;
  
   datetime time_first_candle = iTime(Symbol(),PERIOD_H1,250);
   Print("time first candle: ",TimeToStr(time_first_candle));
   Print("NY_open: ",TimeToStr(NY_open));
   while(NY_open>=time_first_candle){      
         Sleep(500);
         upperLine = "upperLine-" + IntegerToString(z);
         pivotLine = "pivotLine-" + IntegerToString(z);
         
         setUpperLine(upperLine, valHigh, NY_close);
         setPivotLine(pivotLine,pivot,NY_close);
         PrintFormat("uppeLine: %s. valhigh: %.4f candle_close: '%d'",upperLine,valHigh,candle_close);
         
         
         if(TimeDayOfWeek(NY_close)==1){
            //Monday has check pivot of friday
            NY_close -= 72*60*60 ;
            candle_close += 72;
            }else{                  
            NY_close -= 24*60*60 ;
            candle_close += 24;}
         NY_open = NY_close - 9*60*60;
         Print(TimeToStr(NY_close),", NY_close, open, ", TimeToStr(NY_open));
         
         
         val_index=iHighest(Symbol(),PERIOD_H1,MODE_HIGH,9,candle_close);
         if(val_index!=-1) valHigh=iHigh(Symbol(),PERIOD_H1,val_index);
        
         valLow_index=iLowest(Symbol(),PERIOD_H1,MODE_HIGH,9,candle_close);
         if(valLow_index!=-1) valLow=iLow(Symbol(),PERIOD_H1,valLow_index);
         valClose = iClose(Symbol(),PERIOD_H1,candle_close);
   
         pivot = (valHigh+valLow+valClose)/3;
        
         z++;
         }


              

   setLabel(output);
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


void setUpperLine(string name, double dblValHigh, datetime datetime_candle_close){
      //PrintFormat("//////////////////-------------/////////////////");
      //PrintFormat("name: %s. dblvalhigh: %.4f num_candle_close: '%s'",name,dblValHigh,datetime_candle_close);
      
     ObjectDelete(0,name);
     ObjectCreate(0,name, OBJ_TREND, 0, datetime_candle_close-9*60*60, dblValHigh+100*Point, datetime_candle_close, dblValHigh+100*Point);
     ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,false);
     ObjectSet(name,OBJPROP_STYLE, STYLE_DASHDOT);
     ObjectSet(name,OBJPROP_COLOR,clrWhite);
     ObjectSet(name,OBJPROP_WIDTH,1);
   }
   

void setPivotLine(string name, double dblPivot, datetime datetime_candle_close){
      //PrintFormat("//////////////////-------------/////////////////");
      //PrintFormat("name: %s. dblvalhigh: %.4f num_candle_close: '%s'",name,dblPivot,datetime_candle_close);
      
     ObjectDelete(0,name);
     ObjectCreate(0,name, OBJ_TREND, 0, datetime_candle_close-9*60*60, dblPivot, datetime_candle_close, dblPivot);
     ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,false);
     ObjectSet(name,OBJPROP_STYLE, STYLE_DASHDOT);
     ObjectSet(name,OBJPROP_COLOR,clrYellow);
     ObjectSet(name,OBJPROP_WIDTH,1);
   }


   void setLabel(string strText){
   
      string to_split=strText;   // A string to split into substrings
   string sep="\n";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,result);
   //--- Show a comment 
   PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   for(int i=0;i<k;i++)
        {
         PrintFormat("result[%d]=%s",i,result[i]);
         
         
      ObjectDelete("myLabel-"+IntegerToString(i));
      ObjectCreate("myLabel-"+IntegerToString(i),OBJ_LABEL,0,0,0);
      ObjectSetText("myLabel-"+IntegerToString(i),result[i],14,"Arial Bold",clrWhite);
      ObjectSet("myLabel-"+IntegerToString(i),OBJPROP_CORNER,1);
      ObjectSet("myLabel-"+IntegerToString(i),OBJPROP_XDISTANCE,50);
      ObjectSet("myLabel-"+IntegerToString(i),OBJPROP_YDISTANCE,30+i*20);
        }
     
     
      
      
      }