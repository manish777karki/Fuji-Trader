//+------------------------------------------------------------------+
//|                     FujiSetup.mqh                                |
//|             Entry condition setup (pattern detection)            |
//+------------------------------------------------------------------+

#ifndef __FUJI_SETUP__
#define __FUJI_SETUP__

//--- Detects a valid bullish engulfing pattern
bool IsBullishEngulfing()
{
   double open1  = iOpen(_Symbol, _Period, 1);
   double close1 = iClose(_Symbol, _Period, 1);
   double open2  = iOpen(_Symbol, _Period, 2);
   double close2 = iClose(_Symbol, _Period, 2);

   // Bar 2 must be bearish, Bar 1 must be bullish
   bool bar2Bearish = close2 < open2;
   bool bar1Bullish = close1 > open1;

   bool engulfed = open1 < close2 && close1 > open2;

   if (bar2Bearish && bar1Bullish && engulfed)
      return true;

   if (DebugMode)
      Print("[Engulfing] No valid bullish engulfing pattern");

   return false;
}

//--- Main signal detector wrapper
bool SignalDetected()
{
   if (!UseEngulfing)
      return false;

   if (!IsBullishEngulfing())
      return false;

   if (!IsRSIWithinRange())
      return false;

   return true;
}

#endif
