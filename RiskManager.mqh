//+------------------------------------------------------------------+
//|         Risk Manager Module - Fuji Trader for MT5               |
//|         Author: Manish Karki (Acosma Solutions)                 |
//|         Website: https://acosmasolutions.com.au                 |
//+------------------------------------------------------------------+
#ifndef __RISK_MANAGER_MQH__
#define __RISK_MANAGER_MQH__

class RiskManager
{
private:
   datetime lastTradeTime;
   double dailyLossLimitPercent;
   double initialBalance;

public:
   RiskManager()
   {
      lastTradeTime = 0;
      dailyLossLimitPercent = 10.0; // Hardcoded for now (10%)
      initialBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   }

   bool CanTradeToday()
   {
      // Optional: only one trade per day (expand later)
      datetime now = TimeCurrent();
      if (TimeDay(now) == TimeDay(lastTradeTime)) return false;
      return true;
   }

   void MarkTradeExecuted()
   {
      lastTradeTime = TimeCurrent();
   }

   bool IsDrawdownExceeded()
   {
      double currentBalance = AccountInfoDouble(ACCOUNT_BALANCE);
      double maxAllowedLoss = initialBalance * (dailyLossLimitPercent / 100.0);
      double loss = initialBalance - currentBalance;

      return (loss >= maxAllowedLoss);
   }

   void SetInitialBalance(double balance)
   {
      initialBalance = balance;
   }

   void SetDailyLossLimit(double percent)
   {
      dailyLossLimitPercent = percent;
   }
};

#endif // __RISK_MANAGER_MQH__
