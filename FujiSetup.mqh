#ifndef __FUJI_SETUP__
#define __FUJI_SETUP__

#include "FujiFilters.mqh"

//--- Setup logic for RSI pullback entry
bool SetupConditions(string symbol)
{
   ENUM_TIMEFRAMES tf = PERIOD_H1;
   int rsiPeriod = 14;
   double rsiLow = 40;
   double rsiHigh = 50;

   if (!IsRSIWithinRange(symbol, tf, rsiPeriod, rsiLow, rsiHigh))
      return false;

   return true;
}

#endif
