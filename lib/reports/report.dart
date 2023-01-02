class Report {
  int year;
  double profits;
  double dividend;

  Report({required this.year, this.profits = 0.0, this.dividend = 0.0});

  @override
  String toString() => 'Year: $year, Profits: $profits, Dividends: $dividend';
}
