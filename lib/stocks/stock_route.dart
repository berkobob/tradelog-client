import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../base_items/status_enum.dart';
import 'stock_provider.dart';
import 'stocks_wide.dart';

class StockRoute extends StatelessWidget {
  const StockRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StockProvider>();

    return Scaffold(
      appBar: AppBar(
        title: state.message == ''
            ? const Text('All Stocks')
            : Text('Stocks for ${state.message}'),
      ),
      body: ResponsiveBuilder(
        builder: ((context, sizingInformation) {
          switch (state.status) {
            case Status.busy:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.message ?? 'Error'));
            case Status.ready:
              return sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile
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
