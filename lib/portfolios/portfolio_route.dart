import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../base_items/status_enum.dart';
import '../widgets/popup_menu.dart';
import '../widgets/settings_dialog.dart';
import 'portfolio_provider.dart';
import 'portfolios_wide.dart';

class PortfolioRoute extends StatelessWidget {
  const PortfolioRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PortfolioProvider>();

    return Scaffold(
      appBar: AppBar(
        title: state.status == Status.error
            ? const Text('Error getting portfolios')
            : const Text('Portfolios'),
        leading: const SettingsDialog(),
        actions: <Widget>[MyPopupMenu()],
      ),
      body: ResponsiveBuilder(
        builder: ((context, sizingInformation) {
          switch (state.status) {
            case Status.busy:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.message ?? 'Error'));
            case Status.ready:
              debugPrint('${sizingInformation.screenSize!.width}');
              return sizingInformation.screenSize!.width < 1000
                  ? const Text('mobile city') // Use PageView
                  : const PortfoliosWide();
            default:
              return Center(child: Text(state.message ?? 'Panic!'));
          }
        }),
      ),
    );
  }
}
