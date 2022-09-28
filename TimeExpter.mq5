 #include <Trade/Trade.mqh>
 CTrade trade;
 
 input int FastMaPeriod = 36;
 input int SlowMaPeriod = 100;
 
 input int FastMASignale = 5;
 input int MiddleMASignale = 24;
 input int SlowMASignale = 50;
 
 input double Volume = 0.1;
 
 input int TakeProfit = 150;
 input int StopLoss   = 150;
 
 double TP;
 double SL;
 
 int FastMaHendle;
 int SlowMaHendle;
 int FastMASignale_Hendle;
 int MiddleMASignale_Hendle;
 int SlowMASignale_Hendle;
 
 int Smer_trendu;
 
 double Ask;
 double Bid;
 
 void OnInit()
 	{
 		trade.SetExpertMagicNumber(997);
 		FastMaHendle = iMA(Symbol(),PERIOD_H1,FastMaPeriod,0,MODE_EMA,0);
 		SlowMaHendle = iMA(Symbol(),PERIOD_H1,SlowMaPeriod,0,MODE_SMA,0);
 		
 		FastMASignale_Hendle   = iMA(Symbol(),PERIOD_M5,FastMASignale,0,MODE_EMA,0);
 		MiddleMASignale_Hendle = iMA(Symbol(),PERIOD_M5,MiddleMASignale,0,MODE_EMA,0);
 		SlowMASignale_Hendle   = iMA(Symbol(),PERIOD_M5,SlowMASignale,0,MODE_EMA,0);
 	}
 	
 void OnTick()
 	{
 	
 		Ask = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
		Bid = SymbolInfoDouble(Symbol(),SYMBOL_BID);
		 
//==================================================// 		
 		double FastMaMassiv[];
	 	double SlowMaMassiv[];
	 	
	 	double FastMASignaleMassiv[];
	 	double MiddleMASignaleMassiv[];
	 	double SlowMASignaleMassiv[];
//==================================================//	 	
 		CopyBuffer(FastMaHendle,0,0,5,FastMaMassiv);
 		CopyBuffer(SlowMaHendle,0,0,5,SlowMaMassiv);
 		
 		CopyBuffer(FastMASignale_Hendle,0,0,5,FastMASignaleMassiv);
 		CopyBuffer(MiddleMASignale_Hendle,0,0,5,MiddleMASignaleMassiv);
 		CopyBuffer(SlowMASignale_Hendle,0,0,5,SlowMASignaleMassiv);
//==================================================// 		
 		ArraySetAsSeries(FastMaMassiv,true);
 		ArraySetAsSeries(SlowMaMassiv,true);
 		
 		ArraySetAsSeries(FastMASignaleMassiv,true);
 		ArraySetAsSeries(MiddleMASignaleMassiv,true);
 		ArraySetAsSeries(SlowMASignaleMassiv,true);
//==================================================// 		
		Smer_trendu = 0;
		
		if(FastMaMassiv[0] > SlowMaMassiv[0] && Ask > FastMaMassiv[0])
			Smer_trendu = 1;
			
		if(FastMaMassiv[0] < SlowMaMassiv[0] && Ask < FastMaMassiv[0])
			Smer_trendu = -1;
			
		if(Smer_trendu == 1)
			{
				if(FastMASignaleMassiv[0] > MiddleMASignaleMassiv[0] && MiddleMASignaleMassiv[0] > SlowMASignaleMassiv[0])
					{
						if(Ask <= FastMASignaleMassiv[0] && PositionsTotal() == 0)
							{
								TP = Ask + TakeProfit * SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
								SL = Ask - StopLoss   * SymbolInfoDouble(Symbol(),SYMBOL_POINT);
								trade.Buy(Volume,Symbol(),Ask,SL,TP,NULL);
							}
					}
			}
 	 
 	 int positions_count = 0;
 	 for(int i = PositionsTotal(); i >= 0; i--)
 	 	{
 	 		ulong ticket = PositionGetTicket(i);
 	 			if(PositionSelectByTicket(ticket))
 	 				{
 	 					if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == 997)
 	 						{
 	 						positions_count++;
 	 						}
 	 				}
 	 	} 
 	} 