import 'package:client/base_items/base_provider.dart';
import 'package:intl/intl.dart';

import '../base_items/currency_to_symbol.dart';
import '../base_items/status_enum.dart';
import 'portfolio.dart';

class PortfolioProvider extends BaseProvider {
  List<Portfolio> portfolios = [];
  String? message;
  String sort = '';

  @override
  Future<void> init() async {
    status = Status.busy;
    try {
      portfolios = (await get('portfolios')).map((p) => Portfolio(p)).toList();
      status = Status.ready;
    } catch (e) {
      message = e.toString();
      status = Status.error;
    }
  }

  String get symbol => portfolios.isEmpty ? '' : name(portfolios[0].currency);

  String get sumProceeds => NumberFormat.simpleCurrency(name: symbol)
      .format(portfolios.fold(0.0, (value, item) => value += item.proceeds));

  String get sumCommission => NumberFormat.simpleCurrency(name: symbol)
      .format(portfolios.fold(0.0, (value, item) => value += item.commission));

  String get sumCash => NumberFormat.simpleCurrency(name: symbol)
      .format(portfolios.fold(0.0, (value, item) => value += item.cash));

  String get sumRisk => NumberFormat.simpleCurrency(name: symbol)
      .format(portfolios.fold(0.0, (value, item) => value += item.risk));

  String get sumProfit => NumberFormat.simpleCurrency(name: symbol)
      .format(portfolios.fold(0.0, (value, item) => value += item.profit));

  String get sumDividends => NumberFormat.simpleCurrency(name: symbol)
      .format(portfolios.fold(0.0, (value, item) => value += item.dividends));

  String get sumQuantity => portfolios
      .fold<num>(0, (value, item) => value += item.quantity)
      .toString();

  void sortBy(String by) {
    switch (by) {
      case "PORTFOLIO":
        portfolios.sort((a, b) => a.portfolio.compareTo(b.portfolio));
        break;
      case "STOCKS":
        portfolios.sort((a, b) => a.stocks.length.compareTo(b.stocks.length));
        break;
      case "PROCEEDS":
        portfolios.sort((a, b) => a.proceeds.compareTo(b.proceeds));
        break;
      case "COMMISSION":
        portfolios.sort((a, b) => a.commission.compareTo(b.commission));
        break;
      case "CASH":
        portfolios.sort((a, b) => a.cash.compareTo(b.cash));
        break;
      case "RISK":
        portfolios.sort((a, b) => a.risk.compareTo(b.risk));
        break;
      case "PROFIT":
        portfolios.sort((a, b) => a.profit.compareTo(b.profit));
        break;
      case "DIVIDENDS":
        portfolios.sort((a, b) => a.dividends.compareTo(b.dividends));
        break;
    }

    if (sort == by) {
      portfolios = portfolios.reversed.toList();
      sort = "";
    } else {
      sort = by;
    }

    notifyListeners();
  }
}
