//+------------------------------------------------------------------+
//|                  FujiTrader v1.2 - Main EA Entry Update                |
//+------------------------------------------------------------------+

#include "FujiConfig.mqh"
#include "FujiConstants.mqh"
#include "FujiUtils.mqh"
#include "FujiStrategy.mqh"
#include "FujiFilters.mqh"
#include "FujiRisk.mqh"
#include "TradeExecutor.mqh"
#include "IndicatorUtils.mqh"
#include "CandlePatterns.mqh"

int OnInit()
  {
   Print("FujiTrader v1.2 Initialized");
   return INIT_SUCCEEDED;
  }
void OnTick()
{
   FilterReport report;

   // 1. Time filter
   if(!CanTradeNow(report)) {
      Print("[Fuji] ❌ CanTradeNow failed: ", report.reason);
      return;
   }

   // 2. Session filter
   if(!IsInTradingSession(report)) {
      Print("[Fuji] ❌ IsInTradingSession failed: ", report.reason);
      return;
   }

   // 3. ATR filter
   if(!IsATRVolatilitySufficient(_Symbol, report)) {
      Print("[Fuji] ❌ ATR filter failed: ", report.reason);
      return;
   }

   // 4. RSI filter
   if(!IsRSIInRange(_Symbol, report)) {
      Print("[Fuji] ❌ RSI filter failed: ", report.reason);
      return;
   }

   // 5. Engulfing pattern
   if(UseEngulfing && !HasEngulfingPattern(_Symbol, report)) {
      Print("[Fuji] ❌ Engulfing pattern not found: ", report.reason);
      return;
   }

   // 6. Get signal
   FujiSignal signal = GetFujiTradeSignal(_Symbol);
   if(signal == FujiSignal::None) {
      Print("[Fuji] ❌ No signal generated");
      return;
   }

   Print("[Fuji] ✅ Signal: ", EnumToString(signal));

   // 7. Calculate risk-based lot size
   double lotSize = CalculateRiskLot(_Symbol);
   if(lotSize <= 0) {
      Print("[Fuji] ❌ Lot size is 0 or invalid");
      return;
   }

   // 8. Send trade
   ExecuteTrade(signal, lotSize);
}
