import '../base_items/base_model.dart';

class Portfolio extends BaseModel {
  final Set<dynamic> stocks;
  final num profit;
  final num dividends;

  Portfolio(Map<String, dynamic> json)
      : stocks = json['stocks'].toSet(),
        profit = json['profit'],
        dividends = json['dividends'] ?? 0.0,
        super(json);

  @override
  String toString() => '$portfolio, $proceeds';

  String get fDividends => format(dividends);
  String get fProfit => format(profit);
}
