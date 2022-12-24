import 'package:flutter/material.dart';
import 'package:tradelog/positions/positions_provider.dart';

import '../base_items/status_enum.dart';

class PopupFilter extends StatelessWidget {
  const PopupFilter({required this.state, super.key});
  final PositionProvider state;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.filter_alt),
      color: Theme.of(context).primaryColor,
      onSelected: (choice) {
        switch (choice) {
          case 'closed':
            state.hideClosed = !state.hideClosed;
            break;
          case 'open':
            state.hideOpen = !state.hideOpen;
            break;
          case 'stocks':
            state.hideStocks = !state.hideStocks;
            break;
          case 'options':
            state.hideOptions = !state.hideOptions;
            break;
          case 'reset':
            state.hideClosed = false;
            state.hideOpen = false;
            state.hideStocks = false;
            state.hideOptions = false;
        }
        state.status = Status.ready;
      },
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: 'closed',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hide closed positions',
                  style: TextStyle(color: Colors.white)),
              state.hideClosed
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'open',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hide open positions',
                  style: TextStyle(color: Colors.white)),
              state.hideOpen
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'stocks',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hide stock positions',
                  style: TextStyle(color: Colors.white)),
              state.hideStocks
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'options',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hide options positions',
                  style: TextStyle(color: Colors.white)),
              state.hideOptions
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'reset',
          child: Text('Reset all', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
