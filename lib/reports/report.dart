class Report {
  String column;
  double profits;
  double dividend;

  Report({required this.column, this.profits = 0.0, this.dividend = 0.0});

  @override
  String toString() =>
      'column: $column, Profits: $profits, Dividends: $dividend';
}
