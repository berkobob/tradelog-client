import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../base_items/status_enum.dart';
import '../widgets/popup_menu.dart';
import 'stock_provider.dart';
import 'stocks_wide.dart';

class StockRoute extends StatelessWidget {
  const StockRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StockProvider>();

    return Scaffold(
      appBar: AppBar(
        title: state.status == Status.error
            ? const Text('Error getting stocks')
            : state.message == null
                ? const Text('All Stocks')
                : Text('Stocks for ${state.message}'),
        actions: const <Widget>[MyPopupMenu()],
      ),
      body: ResponsiveBuilder(
        builder: ((context, sizingInformation) {
          switch (state.status) {
            case Status.init:
              state.init();
              return const Center(child: CircularProgressIndicator());
            case Status.busy:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.message ?? 'Error'));
            case Status.ready:
              return sizingInformation.screenSize!.width < 1000
                  ? const Text('mobile city') // Use PageView
                  : const StocksWide();
            default:
              return Center(child: Text(state.message ?? 'Panic!'));
          }
        }),
      ),
    );
  }
}
