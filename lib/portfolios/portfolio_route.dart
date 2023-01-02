import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../base_items/base_route.dart';
import '../base_items/status_enum.dart';
import '../stocks/stock_provider.dart';
import '../widgets/mobile_view.dart';
import '../widgets/popup_menu.dart';
import '../widgets/settings_dialog.dart';
import 'portfolio_provider.dart';
import 'portfolios.dart';

class PortfolioRoute extends StatelessWidget {
  const PortfolioRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PortfolioProvider>();
    return Scaffold(
      appBar: AppBar(
        title: state.status == Status.error
            ? const Text('Error getting portfolios')
            : const Text('All Portfolios'),
        leading: const SettingsDialog(),
        actions: const <Widget>[MyPopupMenu()],
      ),
      body: ResponsiveBuilder(
        builder: ((context, sizingInformation) {
          switch (state.status) {
            case Status.busy:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.message ?? 'Error'));
            case Status.ready:
              return sizingInformation.screenSize!.width < 1000
                  ? PageView(
                      children: state.portfolios
                          .map<Widget>((portfolio) => GestureDetector(
                              child: MobileView(portfolio.toMap()),
                              onTap: () {
                                final stock = context.read<StockProvider>();
                                stock.init('portfolio=${portfolio.portfolio}');
                                stock.message = portfolio.portfolio;
                                Navigator.push(context, stockRoute());
                              }))
                          .toList()
                        ..insert(0, MobileView(state.toMap())),
                    )
                  : const Portfolios();
            default:
              return Center(child: Text(state.message ?? 'Panic!'));
          }
        }),
      ),
    );
  }
}
