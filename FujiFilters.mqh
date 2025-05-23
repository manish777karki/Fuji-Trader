#ifndef __FUJI_FILTERS__
#define __FUJI_FILTERS__

//--- Check if ATR is above threshold
bool IsATRVolatilitySufficient(string symbol, ENUM_TIMEFRAMES tf, int atrPeriod, double threshold)
{
   int handle = iATR(symbol, tf, atrPeriod);
   if (handle == INVALID_HANDLE) return false;

   double atr[];
   if (CopyBuffer(handle, 0, 0, 1, atr) <= 0) return false;

   return atr[0] >= threshold;
}

//--- Check if RSI is within a range
bool IsRSIWithinRange(string symbol, ENUM_TIMEFRAMES tf, int rsiPeriod, double low, double high)
{
   int handle = iRSI(symbol, tf, rsiPeriod, PRICE_CLOSE);
   if (handle == INVALID_HANDLE) return false;

   double rsi[];
   if (CopyBuffer(handle, 0, 0, 1, rsi) <= 0) return false;

   return (rsi[0] >= low && rsi[0] <= high);
}

//--- Limit to session (default 8–18)
bool CanTradeNow()
{
   MqlDateTime t;
   TimeToStruct(TimeTradeServer(), t);
   return (t.hour >= 8 && t.hour <= 18);
}

#endif
