import 'package:intl/intl.dart';

import '../base_items/base_provider.dart';
import '../base_items/currency_to_symbol.dart';
import '../base_items/status_enum.dart';
import 'stock.dart';

class StockProvider extends BaseProvider {
  List<Stock> stocks = [];
  String? message;

  Future<void> init([String? query]) async {
    status = Status.busy;
    try {
      stocks = (await get('stocks', query)).map((s) => Stock(s)).toList();
      status = Status.ready;
    } catch (e) {
      message = e.toString();
      status = Status.error;
    }
  }

  String get symbol => stocks.isEmpty ? '' : name(stocks[0].currency);

  String get sumOpen =>
      '${stocks.fold(0, (value, item) => value += item.open.length)}';

  String get sumClosed =>
      '${stocks.fold(0, (value, item) => value += item.closed.length)}';

  String get sumProceeds => NumberFormat.simpleCurrency(name: symbol)
      .format(stocks.fold(0.0, (value, item) => value += item.proceeds));

  String get sumCommission => NumberFormat.simpleCurrency(name: symbol)
      .format(stocks.fold(0.0, (value, item) => value += item.commission));

  String get sumCash => NumberFormat.simpleCurrency(name: symbol)
      .format(stocks.fold(0.0, (value, item) => value += item.cash));

  String get sumRisk => NumberFormat.simpleCurrency(name: symbol)
      .format(stocks.fold(0.0, (value, item) => value += item.risk));

  String get sumProfit => NumberFormat.simpleCurrency(name: symbol)
      .format(stocks.fold(0.0, (value, item) => value += item.profit));

  String get sumDividends => NumberFormat.simpleCurrency(name: symbol)
      .format(stocks.fold(0.0, (value, item) => value += item.dividends));

  String get sumQuantity =>
      stocks.fold<num>(0, (value, item) => value += item.quantity).toString();
}
