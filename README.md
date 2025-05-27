# FujiTrader v1.2.2

A MetaTrader 5 Expert Advisor (EA) designed for risk-controlled algorithmic trading using modular filters and candle pattern logic.

## ⚠️ Current Status (v1.2.2)

🚨 **NOT PROFITABLE**  
🔧 Engine is stable, but strategy is broken.  
🔥 High trade volume, high drawdown, and no statistical edge.

---

## ✅ What's Working

- Modular architecture using `.mqh` includes
- Configurable filters: ATR, RSI, Time, Session
- Risk-based lot sizing with leverage support
- Trade execution with logging
- Engulfing pattern detection logic
- Filter diagnostics per trade (via `FilterReport`)
- Clean separation of config, constants, strategy, execution

---

## ❌ What's Broken

| Problem                         | Description                                              |
|----------------------------------|----------------------------------------------------------|
| ❌ Overtrading                   | 40,000+ trades/month due to no bar lock or position check |
| ❌ Poor strategy logic           | Relies only on basic engulfing pattern (low edge)       |
| ❌ No trade tracking             | Trades repeatedly on same candle/tick                   |
| ❌ Static SL/TP                  | Fixed 200 pip SL, not adapted to volatility             |
| ❌ No trend awareness            | Entries made blindly regardless of price context        |
| ❌ High risk/low reward profile  | Net loss, poor expectancy, PF < 1.0                     |

---

## ⚙️ Inputs (From `FujiConfig.mqh`)

```mq5
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
input int      RSILower         = 40;
input int      RSIUpper         = 50;

input int      SessionStartHour = 7;
input int      SessionEndHour   = 20;

input string   AllowedSymbols   = "EURUSD,GBPUSD,USDJPY,AUDUSD";
