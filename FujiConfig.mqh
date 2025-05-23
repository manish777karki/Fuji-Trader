//+------------------------------------------------------------------+
//|                     FujiConfig.mqh                               |
//|           All EA input parameters & global settings              |
//+------------------------------------------------------------------+

#ifndef __FUJI_CONFIG__
#define __FUJI_CONFIG__

//--- Risk Management
input double   RiskPercent      = 1.0;        // % of balance per trade
input double   RRMultiplier     = 1.5;        // Reward-to-Risk ratio
input double   Slippage         = 5;          // Max slippage (points)
input int      MagicNumber      = 202501;     // Unique EA ID

//--- Filters
input bool     UseSessionFilter = true;       // Only trade in session times
input bool     UseATRFilter     = true;       // Require ATR volatility
input bool     UseRSIFilter     = true;       // Enable RSI range check
input bool     UseEngulfing     = true;       // Require engulfing pattern

//--- ATR Filter
input int      ATRPeriod        = 14;         // ATR period
input double   ATRThreshold     = 0.0006;     // Min ATR to allow trade

//--- RSI Filter
input int      RSIPeriod        = 14;
input int      RSILower         = 40;
input int      RSIUpper         = 50;

//--- Session Hours (Broker time)
input int      SessionStartHour = 7;          // e.g., 7 = 7AM
input int      SessionEndHour   = 20;         // e.g., 20 = 8PM

//--- Allowed Symbols (comma separated)
input string   AllowedSymbols   = "EURUSD,GBPUSD,USDJPY,AUDUSD";

#endif
