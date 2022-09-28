#include <Trade/Trade.mqh>
CTrade trade;

void OnTick()
	{
		int ExpOperiod = 1;
		int SMAperiod = 10;
		double StopLoss = 500;
		double TakeProfit = 1500;
		
		double EMAMassiv[];
		double SMAmassiv[];
		
		int HandleExpoMA = iMA(Symbol(),PERIOD_CURRENT,ExpOperiod,0,MODE_EMA,PRICE_CLOSE);
		int SMAHandle    = iMA(Symbol(),PERIOD_CURRENT,SMAperiod,0,MODE_SMA,PRICE_CLOSE);
		
		// kopirujeme do massivu data z hendlu ukazatele
		CopyBuffer(HandleExpoMA,0,1,5,EMAMassiv); // nula je v t omto pripade okynko ukazatele, jednicka je cislo svicko a dvojka je pocet svicek. 
		CopyBuffer(SMAHandle,0,1,5,SMAmassiv);
		
		ArraySetAsSeries(EMAMassiv,true);
		ArraySetAsSeries(SMAmassiv,true);
		
		if(EMAMassiv[1] > SMAmassiv[1] && EMAMassiv[2] < SMAmassiv[2])
			{
				if(PositionsTotal() == 0)
					{
						double ASK = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
						double BID = SymbolInfoDouble(Symbol(),SYMBOL_BID);
						
						double SL = ASK - StopLoss * SymbolInfoDouble(Symbol(),SYMBOL_POINT);
						double TP = ASK + TakeProfit * SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
						
						trade.Buy(0.1,Symbol(),ASK,SL,TP,"No comment");
					}
				Comment(string(EMAMassiv[1]) + " is actually price");
			}
	}