#ifndef __INDICATOR_UTILS_MQH__
#define __INDICATOR_UTILS_MQH__

class IndicatorUtils
{
public:
   static bool GetEMA(string symbol, ENUM_TIMEFRAMES tf, int period, double &value)
   {
      int handle = iMA(symbol, tf, period, 0, MODE_EMA, PRICE_CLOSE);
      if (handle == INVALID_HANDLE) return false;

      double buffer[];
      if (CopyBuffer(handle, 0, 0, 1, buffer) != 1) return false;
      value = buffer[0];
      return true;
   }

   static bool GetATR(string symbol, ENUM_TIMEFRAMES tf, int period, double &value)
   {
      int handle = iATR(symbol, tf, period);
      if (handle == INVALID_HANDLE) return false;

      double buffer[];
      if (CopyBuffer(handle, 0, 0, 1, buffer) != 1) return false;
      value = buffer[0];
      return true;
   }

   static bool GetRSI(string symbol, ENUM_TIMEFRAMES tf, int period, double &value)
   {
      int handle = iRSI(symbol, tf, period, PRICE_CLOSE);
      if (handle == INVALID_HANDLE) return false;

      double buffer[];
      if (CopyBuffer(handle, 0, 0, 1, buffer) != 1) return false;
      value = buffer[0];
      return true;
   }
};

#endif
