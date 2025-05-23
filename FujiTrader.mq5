//+------------------------------------------------------------------+
//|                        FujiTrader.mq5                            |
//|      Fully working MT5 EA entry file (core execution logic)     |
//+------------------------------------------------------------------+

#property strict

#include <Trade\Trade.mqh>         // ✅ Required for placing trades
CTrade trade;                      // ✅ Global trade object

#include "FujiUtils.mqh"
#include "FujiFilters.mqh"
#include "FujiSetup.mqh"

input double RiskPercent       = 1.0;
input double Slippage          = 5;
input string AllowedSymbols    = "EURUSD,GBPUSD,USDJPY,AUDUSD";

int OnInit()
{
   Print("FujiTrader loaded");
   return INIT_SUCCEEDED;
}

void OnTick()
{
   if (!CanTradeNow())
      return;

   if (!SymbolAllowed(_Symbol))
      return;

   if (!IsATRVolatilitySufficient(_Symbol, PERIOD_H1, 14, 0.0002))
      return;

   if (!SetupConditions(_Symbol))
      return;

   if (PositionSelect(_Symbol))
      return;

   Log("✅ ENTRY signal detected for " + _Symbol);

   // ✅ Place trade
   double lot = CalculateLotSize(50);  // Example: 50-pip stop loss
   double price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double sl = NormalizeDouble(price - 0.0010, _Digits); // SL = 10 pips
   double tp = NormalizeDouble(price + 0.0015, _Digits); // TP = 15 pips

   bool result = trade.Buy(lot, _Symbol, price, sl, tp);

   if (!result)
      Print("❌ Trade failed: ", trade.ResultRetcodeDescription());
   else
      Print("✅ Trade placed: ", lot, " lots at ", price);
}
