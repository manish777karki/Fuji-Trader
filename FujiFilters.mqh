//+------------------------------------------------------------------+
//|                     FujiFilters.mqh                              |
//|     Filters: ATR, RSI, Session Time checks                       |
//+------------------------------------------------------------------+

#ifndef __FUJI_FILTERS__
#define __FUJI_FILTERS__

//--- ATR Volatility Check
bool IsATRVolatilitySufficient()
{
   if (!UseATRFilter)
      return true;

   double atr = iATR(_Symbol, _Period, ATRPeriod, 0);
   if (atr >= ATRThreshold)
      return true;

   if (DebugMode)
      Print("[ATR] Skipped: ATR=", atr, " < Threshold=", ATRThreshold);

   return false;
}

//--- RSI Range Check (between 40–50)
bool IsRSIWithinRange()
{
   if (!UseRSIFilter)
      return true;

   double rsi = iRSI(_Symbol, _Period, RSIPeriod, PRICE_CLOSE, 0);
   if (rsi >= RSILower && rsi <= RSIUpper)
      return true;

   if (DebugMode)
      Print("[RSI] Skipped: RSI=", rsi, " not between ", RSILower, "-", RSIUpper);

   return false;
}

//--- Session Filter (broker time)
bool CanTradeNow()
{
   if (!UseSessionFilter)
      return true;

   datetime now = TimeCurrent();
   int hour = TimeHour(now);

   if (hour >= SessionStartHour && hour < SessionEndHour)
      return true;

   if (DebugMode)
      Print("[Session] Skipped: Current hour=", hour, " outside ", SessionStartHour, "-", SessionEndHour);

   return false;
}

#endif
