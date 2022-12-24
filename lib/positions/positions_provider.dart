import 'package:intl/intl.dart';

import '../base_items/base_provider.dart';
import '../base_items/currency_to_symbol.dart';
import '../base_items/status_enum.dart';
import 'position.dart';

class PositionProvider extends BaseProvider {
  // List<Position> positions = [];
  List<Position> allPositions = [];
  String? message;
  String sort = '';
  bool hideClosed = false;
  bool hideOpen = false;
  bool hideStocks = false;
  bool hideOptions = false;

  List<Position> get positions => allPositions.where((position) {
        if (hideClosed && position.quantity == 0) return false;
        if (hideOpen && position.quantity != 0) return false;
        if (hideStocks && position.asset == 'STK') return false;
        if (hideOptions && position.asset == 'OPT') return false;
        return true;
      }).toList();

  @override
  Future<void> init([String? query]) async {
    status = Status.busy;
    try {
      allPositions =
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

  int get countOpen => positions.fold<int>(
      0, (value, item) => item.closed == null ? ++value : value);

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

  void sortBy(String by) {
    switch (by) {
      case "SYMBOL":
        positions.sort((a, b) => a.symbol.compareTo(b.symbol));
        break;
      case "DESCRIPTION":
        positions.sort((a, b) => a.description.compareTo(b.description));
        break;
      case "QTY":
        positions.sort((a, b) => a.quantity.compareTo(b.quantity));
        break;
      case "PROCEEDS":
        positions.sort((a, b) => a.proceeds.compareTo(b.proceeds));
        break;
      case "COMMISSION":
        positions.sort((a, b) => a.commission.compareTo(b.commission));
        break;
      case "CASH":
        positions.sort((a, b) => a.cash.compareTo(b.cash));
        break;
      case "RISK":
        positions.sort((a, b) => a.risk.compareTo(b.risk));
        break;
      case "OPEN":
        positions.sort((a, b) => a.open.compareTo(b.open));
        break;
      case "CLOSED":
        positions.sort((a, b) =>
            (a.closed ?? DateTime.now()).compareTo(b.closed ?? DateTime.now()));
        break;
      case "NUM":
        positions.sort((a, b) => a.trades.length.compareTo(b.trades.length));
        break;
      case "DAYS":
        positions.sort((a, b) => (a.days ?? 0).compareTo(b.days ?? 0));
        break;
      case "ASSET":
        positions.sort((a, b) => a.asset.compareTo(b.asset));
        break;
    }

    if (sort == by) {
      allPositions = allPositions.reversed.toList();
      sort = "";
    } else {
      sort = by;
    }

    notifyListeners();
  }
}
