
FujiSignal GetFujiTradeSignal(string symbol)
{
   MqlRates candles[3];
   if(CopyRates(symbol, PERIOD_CURRENT, 1, 2, candles) != 2)
   {
      Print("[Fuji] ❌ Candle data missing for signal");
      return FujiSignal::None;
   }

   MqlRates prev = candles[1];
   MqlRates curr = candles[0];

   bool prevBull = prev.close > prev.open;
   bool prevBear = prev.close < prev.open;
   bool currBull = curr.close > curr.open;
   bool currBear = curr.close < curr.open;

   if(prevBear && currBull && curr.open < prev.close && curr.close > prev.open)
      return FujiSignal::Buy;

   if(prevBull && currBear && curr.open > prev.close && curr.close < prev.open)
      return FujiSignal::Sell;

   return FujiSignal::None;
}
