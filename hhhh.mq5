/*
Ордер — это указание брокеру купить или продать финансовый инструмент. Существует 
два основных типа ордеров : рыночные и отложенные. Кроме того, есть специальные уровни Take Profit и Stop Loss.

Сделка – это коммерческий обмен (покупка или продажа) финансовой ценной бумаги. 
Покупка осуществляется по цене спроса (Ask), а продажа осуществляется по цене предложения (Bid).
Сделка может быть открыта в результате исполнения рыночного ордера или срабатывания отложенного ордера. 
Обратите внимание, что в некоторых случаях исполнение ордера может привести к нескольким сделкам.

Позиция – это торговое обязательство, т.е. количество купленных или проданных контрактов
финансового инструмента. Длинная позиция — это финансовая ценная бумага, купленная в ожидании
роста цены ценной бумаги. Короткая позиция — это обязательство предоставить ценную бумагу в
ожидании падения цены в будущем.
*/

void OnTick()
  {
ulong ticket = 26263626;
if(PositionSelectByTicket(ticket))
	{
	double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
	double positionProfit = PositionGet Double(POSITION_PROFIT);
	double pos_SL = PositionGetDouble(POSITION_SL);
	double pos_TP = PositionGetDouble(POSITION_TP);
	double position_SWAP = PositionGetDouble(POSITION_SWAP);
	double position_Volume = PositionGetDouble(POSITION_VOLUME);
	ENUM_POSITION_TYPE posTYPE = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
	datetime posiTIME = (datetime)PositionGetInteger(POSITION_TIME);
	Comment(openPrice, positionProfit);
	}
   
  }

// Твоим заданием будет написать такой скрипт который покажет take профит текущей открытой
// позиции а также покажет своп текущей открытой позиции а также покажет объем текущие открытые позиции
// а также покажет тип открытой текущей позиции. 
