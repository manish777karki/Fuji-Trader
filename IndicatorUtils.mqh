
double GetATR(string symbol, ENUM_TIMEFRAMES tf, int period)
  {
   int handle = iATR(symbol, tf, period);
   if(handle == INVALID_HANDLE) return -1;
   double buffer[];
   if(CopyBuffer(handle, 0, 0, 1, buffer) <= 0) return -1;
   return buffer[0];
  }

double GetRSI(string symbol, ENUM_TIMEFRAMES tf, int period)
  {
   int handle = iRSI(symbol, tf, period, PRICE_CLOSE);
   if(handle == INVALID_HANDLE) return -1;
   double buffer[];
   if(CopyBuffer(handle, 0, 0, 1, buffer) <= 0) return -1;
   return buffer[0];
  }
