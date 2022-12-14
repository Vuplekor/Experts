#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
CTrade trade;
CPositionInfo posInfo;

double Lots = 0.1;

void OnTick()
	{
		double High = iHigh(Symbol(),PERIOD_H1,1);
		double Low  = iLow(Symbol(),PERIOD_H1,1);
		
		double High_m5 = iHigh(Symbol(),PERIOD_M5,1);
		double Low_m5  = iLow(Symbol(),PERIOD_M5,1);

		int ma_hendle  = iMA(Symbol(),PERIOD_H1,50,0,MODE_EMA,PRICE_CLOSE);
		int rsi_hendle = iRSI(Symbol(),PERIOD_M30,14,PRICE_CLOSE);
		
		double ma[];
		double rsi[];
		CopyBuffer(ma_hendle,0,1,5,ma);
		CopyBuffer(rsi_hendle,0,1,5,rsi);
		ArraySetAsSeries(rsi,true);

	
		double Ask  = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
		double Bid  = SymbolInfoDouble(Symbol(),SYMBOL_BID); 
	
		if(Ask > High && High > ma[1] && rsi[0] < 50  && PositionsTotal() == 0)
			trade.Buy(Lots,Symbol(),Ask,Low,NULL,NULL);
			
		if(Ask < Low && Low < ma[1] && rsi[0] > 50 && PositionsTotal() == 0)
			trade.Sell(Lots,Symbol(),Bid,High,NULL,NULL);
		
		int i = PositionsTotal() - 1;	
			for(i; i >= 0; i--)
				{
					ulong ticket = PositionGetTicket(i);
					if(posInfo.SelectByTicket(ticket))
						{
							if(posInfo.PositionType() == POSITION_TYPE_BUY && Low > posInfo.StopLoss())
									trade.PositionModify(ticket,Low_m5,NULL);
								
							if(posInfo.PositionType() == POSITION_TYPE_SELL && High < posInfo.StopLoss())
									trade.PositionModify(ticket,High_m5,NULL);
						}
				}
		}

	
	
	