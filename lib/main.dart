import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'portfolios/portfolio_provider.dart';
import 'portfolios/portfolio_route.dart';
import 'positions/positions_provider.dart';
import 'reports/report_provider.dart';
import 'stocks/stock_provider.dart';
import 'trades/trade_provider.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Settings>(
          create: (context) => Settings()..init(),
          lazy: false,
        ),
        ChangeNotifierProvider<PortfolioProvider>(
            create: (BuildContext context) => PortfolioProvider()..init()),
        ChangeNotifierProvider<ReportProvider>(
            create: (BuildContext context) => ReportProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => StockProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => PositionProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TradeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tradelog',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const PortfolioRoute(),
      ),
    );
  }
}
