import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../portfolios/portfolio_provider.dart';
import '../reports/report_provider.dart';
import '../stocks/stock_provider.dart';
import '../positions/positions_provider.dart';
import '../trades/trade_provider.dart';
import '../base_items/base_route.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'name': 'Portfolios',
        'route': portfolioRoute,
        'provider': context.read<PortfolioProvider>(),
      },
      {
        'name': 'Stocks',
        'route': stockRoute,
        'provider': context.read<StockProvider>(),
      },
      {
        'name': 'Positions',
        'route': positionRoute,
        'provider': context.read<PositionProvider>(),
      },
      {
        'name': 'Trades',
        'route': tradeRoute,
        'provider': context.read<TradeProvider>(),
      },
      {
        'name': 'Divider',
        'route': null,
        'provider': null,
      },
      {
        'name': 'Reports',
        'route': reportRoute,
        'provider': context.read<ReportProvider>(),
      },
    ];

    return PopupMenuButton(
        icon: const Icon(Icons.menu),
        color: Theme.of(context).primaryColor,
        onSelected: (choice) {
          choice['provider'].init();
          Navigator.push(context, choice['route']());
        },
        itemBuilder: (context) => items
            .map<PopupMenuEntry>((item) => item['name'] != 'Divider'
                ? PopupMenuItem(
                    value: item,
                    child: Text(item['name'] as String,
                        style: const TextStyle(color: Colors.white)),
                  ) as PopupMenuEntry
                : const PopupMenuDivider())
            .toList());
  }
}
