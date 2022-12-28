import 'package:intl/intl.dart';

import 'currency_to_symbol.dart';

typedef Json = Map<String, dynamic>;

class BaseModel {
  final dynamic id;
  final String portfolio;
  final double proceeds;
  final double commission;
  final double cash;
  final double risk;
  final num quantity;
  final String? currency;

  BaseModel(Json json)
      : id = json['_id'],
        portfolio = json['portfolio'],
        proceeds = json['proceeds'],
        commission = json['commission'],
        cash = json['cash'],
        risk = json['risk'],
        quantity = json['quantity'],
        currency = json['currency'];

  String get fProceeds =>
      NumberFormat.simpleCurrency(name: name(currency), decimalDigits: 0)
          .format(proceeds);

  String get fCommission =>
      NumberFormat.simpleCurrency(name: name(currency)).format(commission);

  String get fCash =>
      NumberFormat.simpleCurrency(name: name(currency), decimalDigits: 0)
          .format(cash);

  String get fRisk =>
      NumberFormat.simpleCurrency(name: name(currency), decimalDigits: 0)
          .format(risk);

  String format(num? x) =>
      NumberFormat.simpleCurrency(name: name(currency)).format(x);

  String largeNum(num q) => NumberFormat('#,###,###').format(q);

  Map<String, String> toMap() => {
        'Portfolio': portfolio,
        'Proceeds': fProceeds,
        'Commission': fCommission,
        'Cash': fCash,
        'Risk': fRisk,
        'Quantity': format(quantity),
        'Currency': currency ?? ''
      };
}
