import '../base_items/base_model.dart';

class Stock extends BaseModel {
  final String stock;
  final List<dynamic> open;
  final List<dynamic> closed;
  final num profit;
  final num dividends;

  Stock(Json json)
      : stock = json['stock'],
        open = json['open'],
        closed = json['closed'],
        profit = json['profit'],
        dividends = json['dividends'] ?? 0.0,
        super(json);

  String get fDividends => format(dividends);
  String get fProfit => format(profit);
}
