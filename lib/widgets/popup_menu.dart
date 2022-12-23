import 'package:flutter/material.dart';
import 'package:tradelog/positions/position_route.dart';

import '../portfolios/portfolio_route.dart';
import '../stocks/stock_route.dart';
import '../trades/trade_route.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({super.key});

  static final items = {
    'Portfolios': PortfolioRoute(),
    'Stocks': StockRoute(),
    'Positions': PositionRoute(),
    'Trades': TradeRoute()
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.menu),
        color: Theme.of(context).primaryColor,
        onSelected: print,
        itemBuilder: (context) => items.keys
            .map<PopupMenuItem>(
                (item) => PopupMenuItem(value: item, child: Text(item)))
            .toList());

    // const [
    //       PopupMenuItem(
    //           value: 'hi',
    //           child: Text('hi', style: TextStyle(color: Colors.white))),
    //       PopupMenuItem(
    //         value: 'there',
    //         child: Text(
    //           'there',
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ]);
  }
}
