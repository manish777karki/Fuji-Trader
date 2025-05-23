#ifndef __TRADE_EXECUTOR_MQH__
#define __TRADE_EXECUTOR_MQH__

#include <Trade\Trade.mqh>

class TradeExecutor
{
private:
   CTrade trade;
   int magic;
   int slippage;

public:
   void Configure(int magicNumber, int maxSlippage)
   {
      magic = magicNumber;
      slippage = maxSlippage;
      trade.SetExpertMagicNumber(magic);
   }

   bool OpenBuy(string symbol, double lot, double sl, double tp)
   {
      double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
      ask = NormalizeDouble(ask, (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS));
      sl = NormalizeDouble(sl, (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS));
      tp = NormalizeDouble(tp, (int)SymbolInfoInteger(symbol, SYMBOL_DIGITS));

      bool result = trade.Buy(lot, symbol, ask, sl, tp, "FujiBuy");
      if (!result)
         Print("❌ Buy Failed: ", symbol, " | Error: ", GetLastError());
      return result;
   }

   double CalculateLot(string symbol, double riskAmount, double slPips)
   {
      double tickValue = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
      double tickSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
      double contractSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_CONTRACT_SIZE);

      double lot = (riskAmount * tickSize) / (slPips * tickValue);
      return NormalizeDouble(lot, 2);
   }
};

#endif
