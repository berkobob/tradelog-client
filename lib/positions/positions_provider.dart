import 'package:intl/intl.dart';

import '../base_items/base_provider.dart';
import '../base_items/currency_to_symbol.dart';
import '../base_items/status_enum.dart';
import 'position.dart';

class PositionProvider extends BaseProvider {
  List<Position> allPositions = [];
  String? message;
  String sort = '';
  bool hideClosed = false;
  bool hideOpen = false;
  bool hideStocks = false;
  bool hideOptions = false;
  bool hideDividends = false;

  List<Position> get positions => allPositions.where((position) {
        if (hideClosed && position.quantity == 0) return false;
        if (hideOpen && position.quantity != 0) return false;
        if (hideStocks && position.asset == 'STK') return false;
        if (hideOptions && position.asset == 'OPT') return false;
        if (hideDividends && position.asset == 'DIV') return false;
        return true;
      }).toList();

  @override
  Future<void> init([String? query]) async {
    status = Status.busy;
    try {
      allPositions =
          (await get('positions', query)).map((s) => Position(s)).toList();
      query = query?.replaceFirst('stock', 'symbol');
      allPositions.addAll((await get('dividends', query))
          .map((d) => Position.fromDividend(d))
          .toList());
      status = Status.ready;
    } catch (e) {
      message = e.toString();
      status = Status.error;
    }
  }

  String get symbol => positions.isEmpty ? '' : name(positions[0].currency);

  String get sumQuantity => NumberFormat('#,###,###')
      .format(positions.fold<num>(0, (value, item) => value += item.quantity));

  int get countOpen => positions.fold<int>(
      0, (value, item) => item.closed == null ? ++value : value);

  String get sumProceeds =>
      NumberFormat.simpleCurrency(name: symbol, decimalDigits: 0)
          .format(positions.fold(0.0, (value, item) => value += item.proceeds));

  String get sumCommission =>
      NumberFormat.simpleCurrency(name: symbol, decimalDigits: 0).format(
          positions.fold(0.0, (value, item) => value += item.commission));

  String get sumCash =>
      NumberFormat.simpleCurrency(name: symbol, decimalDigits: 0)
          .format(positions.fold(0.0, (value, item) => value += item.cash));

  String get sumRisk =>
      NumberFormat.simpleCurrency(name: symbol, decimalDigits: 0)
          .format(positions.fold(0.0, (value, item) => value += item.risk));

  String get sumTrades =>
      '${positions.fold(0, (value, item) => value += item.trades.length)}';

  String get sumDays => NumberFormat('#,###,###')
      .format(positions.fold(0, (value, item) => value += item.days ?? 0));

  void sortBy(String by) {
    switch (by) {
      case "SYMBOL":
        allPositions.sort((a, b) => a.symbol.compareTo(b.symbol));
        break;
      case "DESCRIPTION":
        allPositions.sort((a, b) => a.description.compareTo(b.description));
        break;
      case "QTY":
        allPositions.sort((a, b) => a.quantity.compareTo(b.quantity));
        break;
      case "PROCEEDS":
        allPositions.sort((a, b) => a.proceeds.compareTo(b.proceeds));
        break;
      case "COMMISSION":
        allPositions.sort((a, b) => a.commission.compareTo(b.commission));
        break;
      case "CASH":
        allPositions.sort((a, b) => a.cash.compareTo(b.cash));
        break;
      case "RISK":
        allPositions.sort((a, b) => a.risk.compareTo(b.risk));
        break;
      case "OPEN":
        allPositions.sort((a, b) => a.open.compareTo(b.open));
        break;
      case "CLOSED":
        allPositions.sort((a, b) =>
            (a.closed ?? DateTime.now()).compareTo(b.closed ?? DateTime.now()));
        break;
      case "NUM":
        allPositions.sort((a, b) => a.trades.length.compareTo(b.trades.length));
        break;
      case "DAYS":
        allPositions.sort((a, b) => (a.days ?? 0).compareTo(b.days ?? 0));
        break;
      case "ASSET":
        allPositions.sort((a, b) => a.asset.compareTo(b.asset));
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

  Map<String, String> toMap() => {
        'SUMMARY': 'PAGE',
        '-----------': '-----',
        'No. Positions': '${positions.length}',
        'Quantity': sumQuantity,
        'Proceeds': sumProceeds,
        'Commission': sumCommission,
        'Cash': sumCash,
        'Risk': sumRisk,
        'No. Open': '$countOpen',
        'No. Closed': '${positions.length - countOpen}',
        'No. of Trades': sumTrades,
        'No. of Days': sumDays
      };
}
