//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   
   string symbols = "";

   for(int i = 0; i<= SymbolsTotal(true); i++)
   {
   symbols = symbols + SymbolName(i,true);   }
     
     Comment(symbols); 
     }
     
//+------------------------------------------------------------------+
