#ifndef __FUJI_CONFIG__
#define __FUJI_CONFIG__

input double   RiskPercent      = 1.0;
input double   RRMultiplier     = 1.5;
input double   Slippage         = 5;
input int      MagicNumber      = 202501;

input bool     UseSessionFilter = true;
input bool     UseATRFilter     = true;
input bool     UseRSIFilter     = true;
input bool     UseEngulfing     = true;

input int      ATRPeriod        = 14;
input double   ATRThreshold     = 0.0006;

input int      RSIPeriod        = 14;
input int RSILower = 35;
input int RSIUpper = 65;


input int SessionStartHour = 6;
input int SessionEndHour = 22;


input string   AllowedSymbols   = "EURUSD,GBPUSD,USDJPY,AUDUSD";

#endif // __FUJI_CONFIG__
