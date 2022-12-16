import 'package:client/trades/trade_wide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../base_items/status_enum.dart';
import 'trade_provider.dart';

class TradeRoute extends StatelessWidget {
  const TradeRoute({this.port, super.key});

  final String? port;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TradeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: state.message == ''
            ? const Text('All Trades')
            : Text('Trades for ${state.message}'),
      ),
      body: ResponsiveBuilder(
        builder: ((context, sizingInformation) {
          switch (state.status) {
            case Status.busy:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.message ?? 'Error'));
            case Status.ready:
              return sizingInformation.screenSize!.width < 2200
                  ? const Text('mobile city') // Use PageView
                  : const TradeWide();
            default:
              return Center(child: Text(state.message ?? 'Panic!'));
          }
        }),
      ),
    );
  }
}
