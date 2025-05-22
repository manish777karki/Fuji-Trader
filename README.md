Fuji Trader (MT5 Expert Advisor)

Fuji Trader is a fully-automated MetaTrader 5 Expert Advisor built for safe, low-frequency trading using a trend + pullback confirmation strategy. It is designed for real-world deployment with risk controls, multi-symbol support, and no martingale/grid logic.

Strategy:
- EMA100 trend filter
- RSI(14) pullback detection
- Bullish engulfing confirmation
- ATR-based SL/TP
- Session time filter (default 8–18)
- No martingale, no grid

File Structure:
FujiTrader/
├── FujiTrader.mq5
├── StrategyTrendPullback.mqh
├── TradeExecutor.mqh
├── IndicatorUtils.mqh
├── CandlePatterns.mqh
├── README.md

Inputs:
RiskPercent:         % of balance to risk per trade (default: 1.0)
RRMultiplier:        Reward-to-risk ratio (default: 1.5)
Slippage:            Max slippage in points (default: 5)
MagicNumber:         Unique trade identifier (default: 202501)
UseSessionFilter:    Enable/disable session hour restriction (default: true)
UseATRFilter:        Enable/disable low-volatility filter (default: true)
ATRPeriod:           ATR lookback period (default: 14)
ATRThreshold:        Minimum ATR value to allow trades (default: 0.0006)
AllowedSymbols:      List of allowed pairs (default: EURUSD,GBPUSD,USDJPY,AUDUSD)

Author: Manish Karki
Website: https://acosmasolutions.com.au

Disclaimer: This EA is provided for educational use. Trade at your own risk.
