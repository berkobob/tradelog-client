import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:tradelog/reports/report_provider.dart';
import 'package:tradelog/widgets/popup_menu.dart';

import '../base_items/status_enum.dart';
import 'reports.dart';

class ReportRoute extends StatelessWidget {
  const ReportRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReportProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: const [MyPopupMenu()],
      ),
      body: ResponsiveBuilder(
        builder: ((context, sizingInformation) {
          switch (state.status) {
            case Status.busy:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.message ?? 'Error'));
            case Status.ready:
              return const Reports();
            default:
              return Center(child: Text(state.message ?? 'Panic!'));
          }
        }),
      ),
    );
  }
}
