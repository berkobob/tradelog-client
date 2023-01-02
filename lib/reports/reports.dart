import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tradelog/reports/report_provider.dart';

import 'report.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReportProvider>();
    final data = state.data;

    // return Column(children: data.map((y) => Text('$y')).toList());

    return SfCartesianChart(
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
      series: <ChartSeries>[
        StackedColumnSeries<Report, int>(
          dataSource: data,
          xValueMapper: (Report data, _) => data.year,
          yValueMapper: (Report data, _) => data.profits,
        ),
        StackedColumnSeries<Report, int>(
          dataSource: data,
          xValueMapper: (Report data, _) => data.year,
          yValueMapper: (Report data, _) => data.dividend,
        ),
      ],
    );
  }
}
