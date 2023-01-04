import 'package:intl/intl.dart';
import 'package:tradelog/base_items/base_provider.dart';

import '../base_items/status_enum.dart';
import '../positions/position.dart';
import 'report.dart';

class ReportProvider extends BaseProvider {
  List<Position> stocks = [];
  List<Position> options = [];
  List<Position> dividends = [];
  String? message = 'All Years';
  List<Report> data = [];
  List<int> years = [];
  int? year;
  bool monthlyData = false;

  @override
  Future<void> init() async {
    status = Status.busy;
    List<Position> positions = [];
    try {
      // Gets all closed positions
      positions = (await get('positions'))
          .map((p) => Position(p))
          .where((p) => p.quantity == 0)
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

    years = Set.of(positions.map<int>((p) => p.closed?.year ?? 0)).toList()
      ..sort();

    stocks = positions.where((p) => p.asset == 'STK').toList();
    options = positions.where((p) => p.asset == 'OPT').toList();

    year = null;
    data = [];

    for (int year in years) {
      final stock = stocks.fold(0.0,
          (value, p) => p.closed?.year == year ? value += p.proceeds : value);
      final option = options.fold(0.0,
          (value, p) => p.closed?.year == year ? value += p.proceeds : value);
      final dividend = dividends.fold(0.0,
          (value, d) => d.closed?.year == year ? value += d.proceeds : value);
      final report = Report(
          column: '$year', stocks: stock, options: option, dividend: dividend);
      data.add(report);
    }
  }

  bool monthly(int col) {
    if (monthlyData) {
      monthlyData = false;
      return true;
    }
    status = Status.busy;
    monthlyData = true;
    data = [];
    year ??= years[col];
    message = '$year';

    for (int month = 1; month < 13; month++) {
      final stock = stocks.fold(
          0.0,
          (value, p) => p.closed?.year == year && p.closed?.month == month
              ? value += p.proceeds
              : value);
      final option = options.fold(
          0.0,
          (value, p) => p.closed?.year == year && p.closed?.month == month
              ? value += p.proceeds
              : value);
      final dividend = dividends.fold(
          0.0,
          (value, d) => d.closed?.year == year && d.closed?.month == month
              ? value += d.proceeds
              : value);

      data.add(Report(
          column: DateFormat('MMM').format(DateTime(0, month)),
          stocks: stock,
          options: option,
          dividend: dividend));
    }
    status = Status.ready;
    return false;
  }
}
