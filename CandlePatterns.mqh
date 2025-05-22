#ifndef __CANDLE_PATTERNS_MQH__
#define __CANDLE_PATTERNS_MQH__

class CandlePatterns
{
public:
   static bool IsBullishEngulfing(string symbol, ENUM_TIMEFRAMES tf = PERIOD_H1)
   {
      double open1 = iOpen(symbol, tf, 1);
      double close1 = iClose(symbol, tf, 1);
      double open0 = iOpen(symbol, tf, 0);
      double close0 = iClose(symbol, tf, 0);

      return (close1 < open1 && close0 > open0 && close0 > open1 && open0 < close1);
   }
};

#endif
