class Report {
  String column;
  double dividend;
  double options;
  double stocks;

  Report(
      {required this.column,
      this.options = 0.0,
      this.stocks = 1234.0,
      this.dividend = 0.0});

  @override
  String toString() =>
      'column: $column, Options: $options, Stocks: $stocks, Dividends: $dividend';
}
