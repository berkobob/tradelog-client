import 'package:flutter/material.dart';

import '../portfolios/portfolio_route.dart';
import '../positions/position_route.dart';
import '../reports/report_route.dart';
import '../stocks/stock_route.dart';
import '../trades/trade_route.dart';

MaterialPageRoute portfolioRoute() =>
    MaterialPageRoute(builder: (context) => const PortfolioRoute());

MaterialPageRoute stockRoute() =>
    MaterialPageRoute(builder: (context) => const StockRoute());

MaterialPageRoute positionRoute() =>
    MaterialPageRoute(builder: (context) => const PositionRoute());

MaterialPageRoute tradeRoute() =>
    MaterialPageRoute(builder: (context) => const TradeRoute());

MaterialPageRoute reportRoute() =>
    MaterialPageRoute(builder: (context) => const ReportRoute());
