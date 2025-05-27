#ifndef __FUJI_FILTERS__
#define __FUJI_FILTERS__

bool IsATRVolatilitySufficient(string symbol, FilterReport &report)
{
   if(!UseATRFilter)
   {
      report.atrValid = true;
      return true;
   }

   int handle = iATR(symbol, PERIOD_CURRENT, ATRPeriod);
   if(handle == INVALID_HANDLE)
   {
      report.atrValid = false;
      report.reason = "ATR handle failed";
      return false;
   }

   double buffer[];
   if(CopyBuffer(handle, 0, 0, 1, buffer) <= 0)
   {
      report.atrValid = false;
      report.reason = "ATR data unavailable";
      return false;
   }

   double atr = buffer[0];
   report.atrValid = (atr >= ATRThreshold);
   if(!report.atrValid)
      report.reason = "ATR too low: " + DoubleToString(atr, 5);

   return report.atrValid;
}


bool IsRSIInRange(string symbol, FilterReport &report)
{
   if(!UseRSIFilter)
   {
      report.rsiValid = true;
      return true;
   }

   int handle = iRSI(symbol, PERIOD_CURRENT, RSIPeriod, PRICE_CLOSE);
   if(handle == INVALID_HANDLE)
   {
      report.rsiValid = false;
      report.reason = "RSI handle failed";
      return false;
   }

   double buffer[];
   if(CopyBuffer(handle, 0, 0, 1, buffer) <= 0)
   {
      report.rsiValid = false;
      report.reason = "RSI data unavailable";
      return false;
   }

   double rsi = buffer[0];
   report.rsiValid = (rsi >= RSILower && rsi <= RSIUpper);

   if(!report.rsiValid)
      report.reason = "RSI out of range: " + DoubleToString(rsi, 2);

   return report.rsiValid;
}

bool HasEngulfingPattern(string symbol, FilterReport &report)
{
   if(!UseEngulfing)
   {
      report.patternValid = true;
      return true;
   }

   MqlRates candles[3];
   if(CopyRates(symbol, PERIOD_CURRENT, 1, 2, candles) != 2)
   {
      report.patternValid = false;
      report.reason = "Candle data unavailable";
      return false;
   }

   MqlRates prev = candles[1];
   MqlRates curr = candles[0];

   bool prevBull = prev.close > prev.open;
   bool prevBear = prev.close < prev.open;
   bool currBull = curr.close > curr.open;
   bool currBear = curr.close < curr.open;

   bool bullishEngulf = prevBear && currBull && curr.open < prev.close && curr.close > prev.open;
   bool bearishEngulf = prevBull && currBear && curr.open > prev.close && curr.close < prev.open;

   report.patternValid = bullishEngulf || bearishEngulf;

   if(!report.patternValid)
      report.reason = "No engulfing pattern on last 2 candles";

   return report.patternValid;
}


#endif
