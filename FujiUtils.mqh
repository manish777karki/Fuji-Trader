#ifndef __FUJI_UTILS__
#define __FUJI_UTILS__

//--- Logging
void Log(string msg) {
   Print("[Fuji] ", msg);
}

//--- Convert string to uppercase
string ToUpper(string txt) {
   string result = txt;
   for (int i = 0; i < StringLen(result); i++) {
      ushort ch = StringGetCharacter(result, i);  // fixed
      if (ch >= 'a' && ch <= 'z') {
         StringSetCharacter(result, i, ch - 32);
      }
   }
   return result;
}


//--- Check if symbol is in AllowedSymbols (global string)
bool SymbolAllowed(string symbol) {
   string list[];
   int count = StringSplit(AllowedSymbols, ',', list);
   for (int i = 0; i < count; i++) {
      StringTrimLeft(list[i]);
      StringTrimRight(list[i]);
      if (ToUpper(list[i]) == ToUpper(symbol))
         return true;
   }
   return false;
}

//--- Calculate lot size (uses global double RiskPercent)
double CalculateLotSize(double stopLossPips) {
   double balance      = AccountInfoDouble(ACCOUNT_BALANCE);
   double riskAmount   = balance * (RiskPercent / 100.0);
   double tickValue    = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
   double tickSize     = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);
   double contractSize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_CONTRACT_SIZE);

   long volumeDigits = 2;
   SymbolInfoInteger(_Symbol, (ENUM_SYMBOL_INFO_INTEGER)17, volumeDigits);  // 17 = SYMBOL_VOLUME_DIGITS

   double rawLotSize = (riskAmount / (stopLossPips * tickValue / tickSize)) / contractSize;
   double lotStep    = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   double minLot     = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);

   double finalLot = NormalizeDouble(rawLotSize, (int)volumeDigits);

   // ✅ Enforce minimum lot size
   if (finalLot < minLot)
      finalLot = minLot;

   return finalLot;
}


#endif
