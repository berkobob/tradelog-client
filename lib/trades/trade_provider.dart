import 'package:intl/intl.dart';

import '../base_items/base_provider.dart';
import '../base_items/currency_to_symbol.dart';
import '../base_items/status_enum.dart';
import 'trade.dart';

class TradeProvider extends BaseProvider {
  List<Trade> trades = [];
  String? message;

  Future<void> init([String? query]) async {
    status = Status.busy;
    try {
      trades = (await get('trades', query)).map((t) => Trade(t)).toList();
      status = Status.ready;
    } catch (e) {
      message = e.toString();
      status = Status.error;
    }
  }

  String get symbol => trades.isEmpty ? '' : name(trades[0].currency);

  String get sumQuantity =>
      trades.fold<num>(0, (value, item) => value += item.quantity).toString();

  String get sumProceeds => NumberFormat.simpleCurrency(name: symbol)
      .format(trades.fold(0.0, (value, item) => value += item.proceeds));

  String get sumCommission => NumberFormat.simpleCurrency(name: symbol)
      .format(trades.fold(0.0, (value, item) => value += item.commission));

  String get sumCash => NumberFormat.simpleCurrency(name: symbol)
      .format(trades.fold(0.0, (value, item) => value += item.cash));

  String get sumRisk => NumberFormat.simpleCurrency(name: symbol)
      .format(trades.fold(0.0, (value, item) => value += item.risk));
}
