import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../base_items/status_enum.dart';
import '../trades/trade_wide.dart';
import '../widgets/popup_menu.dart';
import 'trade_narrow.dart';
import 'trade_provider.dart';

class TradeRoute extends StatelessWidget {
  const TradeRoute({this.port, super.key});

  final String? port;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TradeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: state.status == Status.error
            ? const Text('Error getting trades')
            : state.message == null
                ? const Text('All Trades')
                : Text('Trades for ${state.message}'),
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
              return sizingInformation.screenSize!.width < 1300
                  ? PageView(
                      children: state.trades
                          .map((trade) => TradeNarrow(trade.toMap()))
                          .toList()
                        ..insert(0, TradeNarrow(state.toMap())),
                    )
                  : const TradeWide();
            default:
              return Center(child: Text(state.message ?? 'Panic!'));
          }
        }),
      ),
    );
  }
}
