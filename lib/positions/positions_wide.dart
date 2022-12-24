import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base_items/base_route.dart';
import '../trades/trade_provider.dart';
import '../widgets/header.dart';
import '../widgets/cell.dart';
import 'positions_provider.dart';

class PositionsWide extends StatelessWidget {
  const PositionsWide({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PositionProvider>();
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Header('SYMBOL', align: TextAlign.left, sort: state.sortBy),
              Header('DESCRIPTION', align: TextAlign.left, sort: state.sortBy),
              if (!state.hideOpen)
                Header('QTY', align: TextAlign.center, sort: state.sortBy),
              Header('PROCEEDS', sort: state.sortBy),
              Header('COMMISSION', sort: state.sortBy),
              Header('CASH', sort: state.sortBy),
              if (!state.hideOpen) Header('RISK', sort: state.sortBy),
              Header('OPEN', align: TextAlign.center, sort: state.sortBy),
              if (!state.hideClosed)
                Header('CLOSED', align: TextAlign.center, sort: state.sortBy),
              Header('NUM', align: TextAlign.center, sort: state.sortBy),
              if (!state.hideClosed)
                Header('DAYS', align: TextAlign.center, sort: state.sortBy),
              Header('ASSET', align: TextAlign.center, sort: state.sortBy),
            ],
          ),
        ),
        Expanded(
            child: state.positions.isEmpty
                ? const Center(child: Text('No positions found'))
                : ListView(
                    children: state.positions
                        .map((position) => ListTile(
                              title: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Cell(
                                    position.symbol,
                                    align: TextAlign.left,
                                  ),
                                  Cell(position.description,
                                      align: TextAlign.left),
                                  if (!state.hideOpen)
                                    Cell(position.fQuantity,
                                        align: TextAlign.center),
                                  Cell(position.fProceeds),
                                  Cell(position.fCommission),
                                  Cell(position.fCash),
                                  if (!state.hideOpen) Cell(position.fRisk),
                                  Cell(position.fOpen, align: TextAlign.center),
                                  if (!state.hideClosed)
                                    Cell(position.fClosed,
                                        align: TextAlign.center),
                                  Cell('${position.trades.length}',
                                      align: TextAlign.center),
                                  if (!state.hideClosed)
                                    Cell('${position.days ?? ''}',
                                        align: TextAlign.center),
                                  Cell(position.asset, align: TextAlign.center),
                                ],
                              ),
                              onTap: () {
                                final trade = context.read<TradeProvider>();
                                trade.init('symbol=${position.symbol}');
                                trade.message = position.symbol;
                                Navigator.push(context, tradeRoute());
                              },
                            ))
                        .toList(),
                  )),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Cell('${state.positions.length}', align: TextAlign.left),
              const Cell('', align: TextAlign.left),
              if (!state.hideOpen)
                Cell(state.sumQuantity, align: TextAlign.center),
              Cell(state.sumProceeds),
              Cell(state.sumCommission),
              Cell(state.sumCash),
              if (!state.hideOpen) Cell(state.sumRisk),
              Cell('${state.countOpen}', align: TextAlign.center),
              if (!state.hideClosed)
                Cell('${state.positions.length - state.countOpen}',
                    align: TextAlign.center),
              Cell(state.sumTrades, align: TextAlign.center),
              if (!state.hideClosed)
                Cell(state.sumDays, align: TextAlign.center),
              const Cell('', align: TextAlign.center),
            ],
          ),
        )
      ],
    );
  }
}
