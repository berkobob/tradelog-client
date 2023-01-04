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

    return SfCartesianChart(
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
      series: <ChartSeries>[
        StackedColumnSeries<Report, String>(
          name: 'Profits',
          onPointTap: (pointInteractionDetails) =>
              state.monthly(pointInteractionDetails.pointIndex ?? 0),
          dataSource: data,
          xValueMapper: (Report data, _) => data.column,
          yValueMapper: (Report data, _) => data.profits,
          isVisibleInLegend: true,
          dataLabelSettings: myDataLabelSettings(),
          dataLabelMapper: (Report report, _) => report.profits != 0.0
              ? NumberFormat.compact().format(report.profits)
              : '',
        ),
        StackedColumnSeries<Report, String>(
          name: 'Dividend',
          onPointTap: (pointInteractionDetails) =>
              state.monthly(pointInteractionDetails.pointIndex ?? 0),
          dataSource: data,
          xValueMapper: (Report data, _) => data.column,
          yValueMapper: (Report data, _) => data.dividend,
          dataLabelSettings: myDataLabelSettings(),
          dataLabelMapper: (Report report, _) => report.dividend != 0.0
              ? NumberFormat.compact().format(report.dividend)
              : '',
        ),
      ],
    );
  }

  DataLabelSettings myDataLabelSettings() {
    return const DataLabelSettings(
      textStyle: TextStyle(color: Colors.white),
      isVisible: true,
      labelAlignment: ChartDataLabelAlignment.middle,
    );
  }
}
