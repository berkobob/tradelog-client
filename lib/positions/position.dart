import 'package:intl/intl.dart';

import '../base_items/base_model.dart';

class Position extends BaseModel {
  final String stock;
  final String symbol;
  final String description;
  final DateTime open;
  final DateTime? closed;
  final List<dynamic> trades;
  final int? days;
  final String asset;

  Position(Json json)
      : stock = json['stock'],
        symbol = json['symbol'],
        description = json['description'],
        open = DateTime.parse(json['open']),
        closed = json['closed'] != null ? DateTime.parse(json['closed']) : null,
        trades = json['trades'],
        days = json['days'],
        asset = json['asset'],
        super(json);

  String get fOpen => DateFormat('dd/MM/yy').format(open);
  String get fClosed =>
      closed != null ? DateFormat('dd/MM/yy').format(closed!) : '';
  String get fQuantity => largeNum(quantity);

  @override
  Map<String, String> toMap() => {
        'Stock': stock,
        'Symbol': symbol,
        'Description': description,
        ...super.toMap(),
        'Open': fOpen,
        'Closed': fClosed,
        'No. of Trades': '${trades.length}',
        'No of Days': '$days',
        'Asset': asset
      };
}
