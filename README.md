# 📈 Fuji Trader v1.1 for MetaTrader 5

**Fuji Trader v1.1** is a fully automated, precision-engineered forex trading Expert Advisor (EA) for MetaTrader 5.  
Designed to be the **cleanest, safest, and smartest algo bot** for live environments, Fuji Trader is built from the ground up with modular, testable components and world-class execution logic.

---

## ⚙️ Version Info

- **EA Name**: Fuji Trader
- **Version**: 1.10
- **Platform**: MetaTrader 5
- **Copyright**: © 2025 Manish Karki (Acosma Solutions)
- **Website**: [https://acosmasolutions.com.au](https://acosmasolutions.com.au)

---

## 🚀 Key Features

- ✅ **Bullish engulfing entry strategy**
- ✅ **RSI momentum filter (40–50 zone)**
- ✅ **ATR volatility breakout filter**
- ✅ **Strict session filter (London/NY)**
- ✅ **Dynamic risk-based lot sizing**
- ✅ **Fixed SL/TP with RR multiplier**
- ✅ **Modular structure: easy to extend**
- ✅ **Symbol whitelist for safety**
- ✅ **Full debug logs for transparency**
- ✅ **Zero martingale, zero grid — clean SL on every trade**

---

## 🎯 Input Parameters

| Name              | Description                            | Default     |
|-------------------|----------------------------------------|-------------|
| `RiskPercent`     | % of balance risked per trade          | 1.0         |
| `RRMultiplier`    | Reward-to-Risk ratio                   | 1.5         |
| `Slippage`        | Max slippage in points                 | 5           |
| `MagicNumber`     | Unique ID for trade tracking           | 202501      |
| `UseATRFilter`    | Require ATR above threshold            | true        |
| `ATRPeriod`       | ATR indicator period                   | 14          |
| `ATRThreshold`    | Minimum ATR to allow trades            | 0.0006      |
| `UseRSIFilter`    | Check RSI zone                         | true        |
| `RSIPeriod`       | RSI period                             | 14          |
| `RSILower`        | Minimum RSI                            | 40          |
| `RSIUpper`        | Maximum RSI                            | 50          |
| `UseSessionFilter`| Restrict trading hours                 | true        |
| `SessionStartHour`| Start hour (broker time)               | 7           |
| `SessionEndHour`  | End hour (broker time)                 | 20          |
| `AllowedSymbols`  | Comma-separated allowed symbols        | EURUSD,GBPUSD,USDJPY,AUDUSD |

---

## 📁 File Structure

