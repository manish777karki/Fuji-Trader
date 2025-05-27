#ifndef __FUJI_CONSTANTS__
#define __FUJI_CONSTANTS__

//--- Signal Types
enum FujiSignal
{
   None = 0,
   Buy,
   Sell
};

//--- Filter Diagnostics
struct FilterReport
{
   bool canTradeTime;
   bool inSession;
   bool atrValid;
   bool rsiValid;
   bool patternValid;
   string reason;
};

#endif // __FUJI_CONSTANTS__
