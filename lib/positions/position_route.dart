import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';

import '../base_items/status_enum.dart';
import '../widgets/mobile_view.dart';
import '../widgets/popup_filter.dart';
import '../widgets/popup_menu.dart';
import 'positions_provider.dart';
import 'positions.dart';

class PositionRoute extends StatelessWidget {
  const PositionRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PositionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: state.status == Status.error
            ? const Center(child: Text('Error getting positions'))
            : state.message == null
                ? const Center(child: Text('All Positions'))
                : Center(child: Text('Positions for ${state.message}')),
        actions: <Widget>[
          PopupFilter(state: state),
          const MyPopupMenu(),
        ],
      ),
      body: ResponsiveBuilder(
        builder: ((context, sizingInformation) {
          switch (state.status) {
            case Status.busy:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.message ?? 'Error'));
            case Status.ready:
              return sizingInformation.screenSize!.width < 1000 //1625
                  ? PageView(
                      children: state.positions
                          .map((position) => MobileView(position.toMap()))
                          .toList()
                        ..insert(0, MobileView(state.toMap())))
                  : const Positions();

            default:
              return Center(child: Text(state.message ?? 'Panic!'));
          }
        }),
      ),
    );
  }
}
