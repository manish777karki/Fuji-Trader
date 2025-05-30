bool CanTradeNow(FilterReport &report)
{
   MqlDateTime t;
   TimeToStruct(TimeCurrent(), t);
   int hour = t.hour;

   report.canTradeTime = (hour >= 6 && hour <= 22);
   if(!report.canTradeTime)
      report.reason = "Outside trade time: " + IntegerToString(hour) + "h";

   return report.canTradeTime;
}


bool SymbolAllowed(string symbol)
{
   string tokens[];
   StringSplit(AllowedSymbols, ',', tokens);

   for(int i = 0; i < ArraySize(tokens); i++)
   {
      string token = tokens[i];
      while(StringGetCharacter(token, 0) == ' ') token = StringSubstr(token, 1);
      while(StringLen(token) > 0 && StringGetCharacter(token, StringLen(token)-1) == ' ')
         token = StringSubstr(token, 0, StringLen(token)-1);

      if(token == symbol)
         return true;
   }
   return false;
}
bool IsInTradingSession(FilterReport &report)
{
   if(!UseSessionFilter)
   {
      report.inSession = true;
      return true;
   }

   MqlDateTime t;
   TimeToStruct(TimeCurrent(), t);
   int hour = t.hour;

   report.inSession = (hour >= SessionStartHour && hour <= SessionEndHour);
   if(!report.inSession)
      report.reason = "Outside session hours: " + IntegerToString(hour) + "h";

   return report.inSession;
}

double CalculateRiskLot(string symbol)
{
   double balance     = AccountInfoDouble(ACCOUNT_BALANCE);
   double riskAmount  = balance * (RiskPercent / 100.0);

   double price       = SymbolInfoDouble(symbol, SYMBOL_ASK);
   double tickValue   = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE);
   double tickSize    = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE);
   double lotStep     = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);
   double minLot      = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
   double maxLot      = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);

   if(tickValue == 0 || tickSize == 0 || lotStep == 0)
   {
      Print("[Fuji] ❌ Invalid symbol specs for lot calculation.");
      return 0;
   }

   // Estimate cost per lot
   double slPips     = 200;  // ← use your SL in pips here if needed
   double pipValue   = tickValue / tickSize;
   double costPerLot = slPips * pipValue;

   if(costPerLot == 0)
      return 0;

   double rawLots = riskAmount / costPerLot;

   // Round down to nearest lot step
   double lotSize = MathFloor(rawLots / lotStep) * lotStep;

   // Enforce broker limits
   if(lotSize < minLot)
      lotSize = minLot;

   if(lotSize > maxLot)
      lotSize = maxLot;

   return NormalizeDouble(lotSize, 2);
}
