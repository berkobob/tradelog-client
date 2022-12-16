import 'package:intl/intl.dart';

import '../base_items/base_provider.dart';
import '../base_items/currency_to_symbol.dart';
import '../base_items/status_enum.dart';
import 'position.dart';

class PositionProvider extends BaseProvider {
  List<Position> positions = [];
  String? message;

  Future<void> init([String? query]) async {
    status = Status.busy;
    try {
      positions =
          (await get('positions', query)).map((s) => Position(s)).toList();
      status = Status.ready;
    } catch (e) {
      message = e.toString();
      status = Status.error;
    }
  }

  String get symbol => positions.isEmpty ? '' : name(positions[0].currency);

  String get sumQuantity => positions
      .fold<num>(0, (value, item) => value += item.quantity)
      .toString();

  String get sumProceeds => NumberFormat.simpleCurrency(name: symbol)
      .format(positions.fold(0.0, (value, item) => value += item.proceeds));

  String get sumCommission => NumberFormat.simpleCurrency(name: symbol)
      .format(positions.fold(0.0, (value, item) => value += item.commission));

  String get sumCash => NumberFormat.simpleCurrency(name: symbol)
      .format(positions.fold(0.0, (value, item) => value += item.cash));

  String get sumRisk => NumberFormat.simpleCurrency(name: symbol)
      .format(positions.fold(0.0, (value, item) => value += item.risk));

  String get sumTrades =>
      '${positions.fold(0, (value, item) => value += item.trades.length)}';

  String get sumDays =>
      '${positions.fold(0, (value, item) => value += item.days ?? 0)}';
}
