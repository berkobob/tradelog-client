import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base_items/base_route.dart';
import '../trades/trade_provider.dart';
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
            children: const [
              Cell('SYMBOL', align: TextAlign.left),
              Cell('DESCRIPTION', align: TextAlign.left),
              Cell('QTY', align: TextAlign.center),
              Cell('PROCEEDS'),
              Cell('COMMISSION'),
              Cell('CASH'),
              Cell('RISK'),
              Cell('OPEN', align: TextAlign.center),
              Cell('CLOSED', align: TextAlign.center),
              Cell('NUM', align: TextAlign.center),
              Cell('DAYS', align: TextAlign.center),
              Cell('ASSET', align: TextAlign.center),
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
                                  Cell(position.fQuantity,
                                      align: TextAlign.center),
                                  Cell(position.fProceeds),
                                  Cell(position.fCommission),
                                  Cell(position.fCash),
                                  Cell(position.fRisk),
                                  Cell(position.fOpen, align: TextAlign.center),
                                  Cell(position.fClosed,
                                      align: TextAlign.center),
                                  Cell('${position.trades.length}',
                                      align: TextAlign.center),
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
              const Cell('', align: TextAlign.left),
              const Cell('', align: TextAlign.left),
              Cell(state.sumQuantity, align: TextAlign.center),
              Cell(state.sumProceeds),
              Cell(state.sumCommission),
              Cell(state.sumCash),
              Cell(state.sumRisk),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              Cell(state.sumTrades, align: TextAlign.center),
              Cell(state.sumDays, align: TextAlign.center),
              const Cell('', align: TextAlign.center),
            ],
          ),
        )
      ],
    );
  }
}
