import 'package:intl/intl.dart';

import '../base_items/base_provider.dart';
import '../base_items/currency_to_symbol.dart';
import '../base_items/status_enum.dart';
import 'trade.dart';

class TradeProvider extends BaseProvider {
  List<Trade> trades = [];
  String? message;
  String sort = "DATE";

  @override
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

  void sortBy(String by) {
    switch (by) {
      case "DATE":
        trades.sort((a, b) => a.date.compareTo(b.date));
        break;
      case "BoS":
        trades.sort((a, b) => a.bos.compareTo(b.bos));
        break;
      case "QTY":
        trades.sort((a, b) => a.quantity.compareTo(b.quantity));
        break;
      case "STOCK":
        trades.sort((a, b) => a.stock.compareTo(b.stock));
        break;
      case "PROCEEDS":
        trades.sort((a, b) => a.proceeds.compareTo(b.proceeds));
        break;
      case "COMMISSION":
        trades.sort((a, b) => a.commission.compareTo(b.commission));
        break;
      case "CASH":
        trades.sort((a, b) => a.cash.compareTo(b.cash));
        break;
      case "RISK":
        trades.sort((a, b) => a.risk.compareTo(b.risk));
        break;
      case "ASSET":
        trades.sort((a, b) => a.asset.compareTo(b.asset));
        break;
      case "OOC":
        trades.sort((a, b) => a.ooc.compareTo(b.ooc));
        break;
      case "MULT":
        trades.sort((a, b) => a.multiplier.compareTo(b.multiplier));
        break;
      case "NOTES":
        trades.sort((a, b) => (a.notes ?? '').compareTo(b.notes ?? ''));
        break;
      case "ID":
        trades.sort((a, b) => (a.tradeid ?? '').compareTo(b.tradeid ?? ''));
        break;
      case "FX":
        trades.sort((a, b) => (a.fx ?? 0.0).compareTo(b.fx ?? 0.0));
        break;
      case "DESCRIPTION":
        trades.sort((a, b) => a.description.compareTo(b.description));
        break;
    }

    if (sort == by) {
      trades = trades.reversed.toList();
      sort = "";
    } else {
      sort = by;
    }

    notifyListeners();
  }

  Map<String, String> toMap() => {
        'No. of Trades': '${trades.length}',
        'Quantity': sumQuantity,
        'Proceeds': sumProceeds,
        'Commission': sumCommission,
        'Cash': sumCash,
        'Risk': sumRisk,
      };
}
