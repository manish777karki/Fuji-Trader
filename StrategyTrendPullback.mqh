//+------------------------------------------------------------------+
//|     Strategy: Trend Pullback with Confirmation (MT5)            |
//|     Author: Manish Karki (Acosma Solutions)                     |
//|     Website: https://acosmasolutions.com.au                     |
//+------------------------------------------------------------------+
#ifndef __STRATEGY_TREND_PULLBACK_MQH__
#define __STRATEGY_TREND_PULLBACK_MQH__

#include <Trade\Trade.mqh>
#include <Arrays\ArrayString.mqh>
#include "TradeExecutor.mqh"
#include "IndicatorUtils.mqh"
#include "CandlePatterns.mqh"

class StrategyTrendPullback
{
private:
   double riskPercent;
   double rr;
   int slippage;
   int magic;
   bool filterSession;
   bool filterATR;
   int atrPeriod;
   double atrMin;
   string symbols[];
   TradeExecutor executor;

public:
   void Init(double risk, double rrMult, int slip, int magicNum,
             bool useSession, bool useATR, int atrP, double atrT, string allowed)
   {
      riskPercent = risk;
      rr = rrMult;
      slippage = slip;
      magic = magicNum;
      filterSession = useSession;
      filterATR = useATR;
      atrPeriod = atrP;
      atrMin = atrT;
      ushort delim = StringGetCharacter(",", 0);
StringSplit(allowed, delim, symbols);  // ✅

      executor.Configure(magic, slippage);
   }

   void OnTick()
   {
      string symbol = _Symbol;
      if (!IsAllowed(symbol)) return;
      if (filterSession && !IsSessionOpen()) return;
      if (filterATR && !ATR_OK(symbol)) return;
      if (!InUptrend(symbol)) return;
      if (!RSIPullback(symbol)) return;
      if (!CandlePatterns::IsBullishEngulfing(symbol)) return;
      if (PositionSelect(symbol)) return;

      PlaceBuy(symbol);
   }

   void Deinit() {}

private:
   bool IsAllowed(string s)
   {
      for (int i = 0; i < ArraySize(symbols); i++)
      {
         string check = symbols[i];
         StringTrimLeft(check);
         StringTrimRight(check);
         if (s == check) return true;
      }
      return false;
   }
   

bool IsSessionOpen()
{
   MqlDateTime t;
   TimeToStruct(TimeTradeServer(), t); // Use server time, not local
   int hour = t.hour;
   return (hour >= 8 && hour <= 18);
}

   bool ATR_OK(string symbol)
   {
      double atr;
      if (!IndicatorUtils::GetATR(symbol, PERIOD_H1, atrPeriod, atr))
         return false;
      return atr >= atrMin;
   }

   bool InUptrend(string symbol)
   {
      double ema;
      if (!IndicatorUtils::GetEMA(symbol, PERIOD_H1, 100, ema))
         return false;
      double price = SymbolInfoDouble(symbol, SYMBOL_BID);
      return price > ema;
   }

   bool RSIPullback(string symbol)
   {
      double rsi;
      if (!IndicatorUtils::GetRSI(symbol, PERIOD_H1, 14, rsi))
         return false;
      return (rsi > 40 && rsi < 50);
   }

   void PlaceBuy(string symbol)
   {
      double atr;
      if (!IndicatorUtils::GetATR(symbol, PERIOD_H1, atrPeriod, atr))
         return;

      double sl = atr;
      double tp = atr * rr;
      double price = SymbolInfoDouble(symbol, SYMBOL_ASK);
      double stop = NormalizeDouble(price - sl, _Digits);
      double take = NormalizeDouble(price + tp, _Digits);

      double riskAmount = AccountInfoDouble(ACCOUNT_BALANCE) * (riskPercent / 100.0);
      double lot = executor.CalculateLot(symbol, riskAmount, sl);

      executor.OpenBuy(symbol, lot, stop, take);
   }
};

#endif
