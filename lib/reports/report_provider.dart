import 'package:intl/intl.dart';
import 'package:tradelog/base_items/base_provider.dart';

import '../base_items/status_enum.dart';
import '../positions/position.dart';
import 'report.dart';

class ReportProvider extends BaseProvider {
  List<Position> positions = [];
  List<Position> dividends = [];
  String? message;
  List<Report> data = [];
  List<int> years = [];

  @override
  Future<void> init() async {
    status = Status.busy;
    try {
      // Gets all closed positions
      positions = (await get('positions'))
          .map((p) => Position(p))
          .where((p) => p.quantity == 0 ? true : false)
          .toList();
      // Gets all dividends
      dividends = (await get('dividends'))
          .map((p) => Position.fromDividend(p))
          .toList();

      status = Status.ready;
    } catch (e) {
      message = '$e';
      status = Status.error;
    }

    years = Set.of(positions.map<int>((p) => p.closed?.year ?? 0))
        // ..addAll(Set.of(dividends.map((d) => d.closed?.year ?? 0)))
        .toList()
      ..sort();

    data = [];
    for (int year in years) {
      final profit = positions.fold(0.0,
          (value, p) => p.closed?.year == year ? value += p.proceeds : value);
      final dividend = dividends.fold(0.0,
          (value, d) => d.closed?.year == year ? value += d.proceeds : value);
      final report =
          Report(column: '$year', profits: profit, dividend: dividend);
      data.add(report);
    }
  }

  void monthly(int col) {
    status = Status.busy;
    data = [];
    final year = years[col];

    for (int month = 0; month < 12; month++) {
      final profits = positions.fold(
          0.0,
          (value, p) => p.closed?.year == year && p.closed?.month == month
              ? value += p.proceeds
              : value);
      final dividend = dividends.fold(
          0.0,
          (value, d) => d.closed?.year == year && d.closed?.month == month
              ? value += d.proceeds
              : value);

      final monthName = DateFormat('MMM').format(DateTime(0, month + 1));
      data.add(Report(column: monthName, profits: profits, dividend: dividend));
    }
    status = Status.ready;
  }
}
