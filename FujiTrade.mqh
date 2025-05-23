//+------------------------------------------------------------------+
//|                     FujiTrade.mqh                                |
//|       Handles trade execution: SL/TP, lot size, open order       |
//+------------------------------------------------------------------+

#ifndef __FUJI_TRADE__
#define __FUJI_TRADE__

//--- Trade execution function
void ExecuteTrade()
{
   double entryPrice = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double slPrice, tpPrice;
   double slPips;

   // Calculate SL based on candle 2 high/low
   double engulfLow  = MathMin(iLow(_Symbol, _Period, 1), iLow(_Symbol, _Period, 2));
   double engulfHigh = MathMax(iHigh(_Symbol, _Period, 1), iHigh(_Symbol, _Period, 2));

   slPips = entryPrice - engulfLow;
   if (slPips <= 0)
   {
      if (DebugMode) Print("[Trade] Invalid SL Pips: ", slPips);
      return;
   }

   double lotSize = CalculateLotSize(slPips / _Point);

   slPrice = engulfLow;
   tpPrice = entryPrice + slPips * RRMultiplier;

   //--- Submit order
   bool result = Trade.Buy(
      lotSize,
      _Symbol,
      entryPrice,
      slPrice,
      tpPrice,
      "FujiTrader v1.1"
   );

   if (result)
      Print("[Trade] ✅ Order sent: Lot=", lotSize, " SL=", slPrice, " TP=", tpPrice);
   else
      Print("[Trade] ❌ Failed to open order: ", Trade.ResultRetcodeDescription());
}

#endif
