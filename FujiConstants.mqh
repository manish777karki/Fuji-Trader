#ifndef __FUJI_CONSTANTS_MQH__
#define __FUJI_CONSTANTS_MQH__

input double RiskPercent        = 1.0;
input double RRMultiplier       = 1.5;
input int    Slippage           = 5;
input int    MagicNumber        = 202501;

input bool   UseSessionFilter   = true;
input bool   UseATRFilter       = true;
input int    ATRPeriod          = 14;
input double ATRThreshold       = 0.0006;
input string AllowedSymbols     = "EURUSD,GBPUSD,USDJPY,AUDUSD";

input int    RSI_Period         = 14;
input int    RSI_LowThreshold   = 40;
input int    RSI_HighThreshold  = 50;
input bool   UseEngulfingConfirm = true;

#endif
