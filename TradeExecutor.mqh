void ExecuteTrade(FujiSignal signal, double lotSize)
{
   double price = (signal == Buy) ? SymbolInfoDouble(_Symbol, SYMBOL_ASK)
                                  : SymbolInfoDouble(_Symbol, SYMBOL_BID);

   double sl = 0, tp = 0, slPoints = 200, point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   double rr = RRMultiplier;

   if(signal == Buy)
   {
      sl = price - slPoints * point;
      tp = price + slPoints * rr * point;
   }
   else if(signal == Sell)
   {
      sl = price + slPoints * point;
      tp = price - slPoints * rr * point;
   }

   MqlTradeRequest req;
   MqlTradeResult res;
   ZeroMemory(req); ZeroMemory(res);

   double lotStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   lotSize = MathFloor(lotSize / lotStep) * lotStep;

   req.volume   = NormalizeDouble(lotSize, 2);
   req.action   = TRADE_ACTION_DEAL;
   req.symbol   = _Symbol;
   req.type     = (signal == Buy) ? ORDER_TYPE_BUY : ORDER_TYPE_SELL;
   req.price    = price;
   req.sl       = sl;
   req.tp       = tp;
   req.magic    = MagicNumber;
   req.deviation = Slippage;
   req.type_filling = ORDER_FILLING_IOC;

   if(!OrderSend(req, res))
      Print("[Fuji] Order failed: ", res.retcode);
   else
      Print("[Fuji] Order sent: ", res.order);
}
