import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tradelog/reports/report_provider.dart';

import '../base_items/base_route.dart';
import '../positions/positions_provider.dart';
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
          name: 'Stocks',
          onPointTap: (pointInteractionDetails) {
            int col = pointInteractionDetails.pointIndex!;
            if (state.monthly(col++)) {
              final positions = context.read<PositionProvider>();
              positions.init('closed=${state.year}&month=$col');
              positions.message =
                  '${DateFormat('MMMM').format(DateTime(0, col))} ${state.year}';
              Navigator.push(context, positionRoute());
            }
          },
          dataSource: data,
          xValueMapper: (Report data, _) => data.column,
          yValueMapper: (Report data, _) => data.stocks,
          dataLabelSettings: myDataLabelSettings(),
          dataLabelMapper: (Report report, _) => report.stocks != 0.0
              ? NumberFormat.compact().format(report.stocks)
              : '',
        ),
        StackedColumnSeries<Report, String>(
          name: 'Dividend',
          onPointTap: (pointInteractionDetails) {
            int col = pointInteractionDetails.pointIndex!;
            if (state.monthly(col++)) {
              final positions = context.read<PositionProvider>();
              positions.init('closed=${state.year}&month=$col');
              positions.message =
                  '${DateFormat('MMMM').format(DateTime(0, col))} ${state.year}';
              Navigator.push(context, positionRoute());
            }
          },
          dataSource: data,
          xValueMapper: (Report data, _) => data.column,
          yValueMapper: (Report data, _) => data.dividend,
          dataLabelSettings: myDataLabelSettings(),
          dataLabelMapper: (Report report, _) => report.dividend != 0.0
              ? NumberFormat.compact().format(report.dividend)
              : '',
        ),
        StackedColumnSeries<Report, String>(
          name: 'Options',
          onPointTap: (pointInteractionDetails) {
            int col = pointInteractionDetails.pointIndex!;
            if (state.monthly(col++)) {
              final positions = context.read<PositionProvider>();
              positions.init('closed=${state.year}&month=$col');
              positions.message =
                  '${DateFormat('MMMM').format(DateTime(0, col))} ${state.year}';
              Navigator.push(context, positionRoute());
            }
          },
          dataSource: data,
          xValueMapper: (Report data, _) => data.column,
          yValueMapper: (Report data, _) => data.options,
          isVisibleInLegend: true,
          dataLabelSettings: myDataLabelSettings(),
          dataLabelMapper: (Report report, _) => report.options != 0.0
              ? NumberFormat.compact().format(report.options)
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
