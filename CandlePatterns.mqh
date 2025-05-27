
bool IsBullishEngulfing(string symbol)
  {
   double o1 = iOpen(symbol, PERIOD_CURRENT, 1);
   double c1 = iClose(symbol, PERIOD_CURRENT, 1);
   double o0 = iOpen(symbol, PERIOD_CURRENT, 0);
   double c0 = iClose(symbol, PERIOD_CURRENT, 0);
   return (c1 < o1 && c0 > o0 && c0 > o1 && o0 < c1);
  }

bool IsBearishEngulfing(string symbol)
  {
   double o1 = iOpen(symbol, PERIOD_CURRENT, 1);
   double c1 = iClose(symbol, PERIOD_CURRENT, 1);
   double o0 = iOpen(symbol, PERIOD_CURRENT, 0);
   double c0 = iClose(symbol, PERIOD_CURRENT, 0);
   return (c1 > o1 && c0 < o0 && c0 < o1 && o0 > c1);
  }
