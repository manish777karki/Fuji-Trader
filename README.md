# FujiTrader v1.1

> Author: Manish Karki (Acosma Solutions)  
> Platform: MetaTrader 5 (MQL5)  
> Status: Finalized and deployed as v1.1 baseline

---

## ✅ What We Built

FujiTrader v1.1 is a clean, modular rebuild of the original EA with improved structure, reliability, and execution control. It includes:

- Modular file structure (Constants, Utils, Risk, Strategy)
- RSI-based trade filtering
- Bullish Engulfing confirmation
- ATR volatility filter
- Trading session filter (Asia, Europe, US)
- Broker-safe SL/TP validation
- Risk-based lot sizing
- Simple logging and error handling

---

## ✅ What We Fixed (from v1.0)

- Replaced broken or outdated logic (no more MarketInfo / invalid includes)
- Eliminated all "Invalid Stops" and SL/TP errors
- Rewrote all indicator and buffer handling using native MQL5 standards
- Removed function duplication and conflicting includes
- Fully separated logic layers for easier testing and upgrades

---

## ⚠️ Known Limitations / Outstanding Issues

- Only supports **Buy** logic (no Sell trades yet)
- No trailing stop or breakeven logic
- No trend filter or market structure validation
- No multi-symbol trading loop (only runs on current chart symbol)
- Strategy signals (RSI 40–50 + Engulfing) may need refinement to improve trade quality

---

## 🛠 Next Version: FujiTrader v1.2 (Planned Enhancements)

- Add Sell logic
- Introduce trend confirmation (e.g. MA filter)
- Improve entry conditions (structure zones, candle context)
- Optional: trailing stop / breakeven
- Optional: multi-symbol loop with risk controls

---

## 🔐 v1.1 Status

This version is now locked and archived. All future updates will build directly on this version — no rewrites, no resets.

