//+------------------------------------------------------------------+
//|                     FujiUtils.mqh                                |
//|              Logging, math, and misc helper functions            |
//+------------------------------------------------------------------+

#ifndef __FUJI_UTILS__
#define __FUJI_UTILS__

//--- Risk: Convert % to lot size
double CalculateLotSize(double stopLossPips)
{
   double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   double riskAmount = balance * (RiskPercent / 100.0);
   double tickValue = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
   double tickSize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);
   double lotStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   double contractSize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_CONTRACT_SIZE);

   double lotSize = (riskAmount / (stopLossPips * tickValue / tickSize)) / contractSize;
   return NormalizeDouble(lotSize, (int)SymbolInfoInteger(_Symbol, SYMBOL_VOLUME_DIGITS));
}

//--- Slippage in points
int GetSlippage()
{
   return (int)Slippage;
}

//--- Logging
void Log(string msg)
{
   Print("[Fuji] ", msg);
}

//--- Check if current symbol is allowed
bool SymbolAllowed(string symbol)
{
   string list[]; int count = StringSplit(AllowedSymbols, ',', list);
   for (int i = 0; i < count; i++)
   {
      if (StringTrim(StringUpper(list[i])) == StringUpper(symbol))
         return true;
   }
   return false;
}

#endif
