import 'package:client/base_items/base_model.dart';
import 'package:intl/intl.dart';

class Trade extends BaseModel {
  final DateTime date;
  final String bos;
  final String symbol;
  final String stock;
  final DateTime? expiry;
  final double? strike;
  final String? poc;
  final double price;
  final String asset;
  final String ooc;
  final int multiplier;
  final String? notes;
  final String? tradeid;
  final double? fx;
  final String description;

  Trade(Map<String, dynamic> json)
      : date = DateTime.parse(json['date']),
        bos = json['bos'],
        symbol = json['symbol'],
        stock = json['stock'],
        expiry = DateTime.tryParse(json['expiry'] ?? ''),
        strike = json['strike'],
        poc = json['poc'],
        price = json['price'],
        asset = json['asset'],
        ooc = json['ooc'],
        multiplier = json['multiplier'],
        notes = json['notes'],
        tradeid = json['tradeid'],
        fx = json['fx'],
        description = json['description'],
        super(json);

  String get fPrice => format(price);
  String get fStrike => strike == null ? '' : format(strike as num);
  String get fDate => DateFormat('dd/MM/yy').format(date);
  String get fExpiry =>
      expiry != null ? DateFormat('dd/MM/yy').format(expiry!) : '';
  String get fQuantity => largeNum(quantity);
  String get fMultiplier => largeNum(multiplier);
  String get fFx => fx != null ? NumberFormat('#.##').format(fx) : '';
}
