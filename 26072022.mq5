
input int CCI_period = 14;

void OnTick()
{
 	double week_1 = iClose(Symbol(),PERIOD_W1,1);
	double week_2 = iClose(Symbol(),PERIOD_W1,2);
	
	int iCCI_Hendle = iCCI(Symbol(),PERIOD_M15,CCI_period,PRICE_CLOSE);
	double iCCI_Buffer[];
	CopyBuffer(iCCI_Hendle,0,1,2,iCCI_Buffer);
	
	string signal;
	double gap = NormalizeDouble((week_1 - week_2)/Point(),5);
	
	if(gap > 500 && iCCI_Buffer[1] > 50)
	signal = "buy";
	if(gap > 500 && iCCI_Buffer[2] > 50)
	signal = "stop";
	
	Comment(signal);
	
}