import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cell.dart';
import 'trade_provider.dart';

class TradeWide extends StatelessWidget {
  const TradeWide({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TradeProvider>();
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Cell('DATE', align: TextAlign.center),
              Cell('BoS', align: TextAlign.center),
              Cell('QTY', align: TextAlign.center),
              Cell('STOCK', align: TextAlign.center),
              Cell('EXPIRY', align: TextAlign.center),
              Cell('STRIKE', align: TextAlign.center),
              Cell('PoC', align: TextAlign.center),
              Cell('PROCEEDS'),
              Cell('COMMISSION'),
              Cell('CASH'),
              Cell('RISK'),
              Cell('ASSET', align: TextAlign.center),
              Cell('OoC', align: TextAlign.center),
              Cell('MULT', align: TextAlign.center),
              Cell('NOTES', align: TextAlign.center),
              Cell('ID', align: TextAlign.center),
              Cell('FX', align: TextAlign.center),
              Cell('DECRIPTION', align: TextAlign.left),
            ],
          ),
        ),
        Expanded(
            child: state.trades.isEmpty
                ? const Center(child: Text('No trades found'))
                : ListView(
                    children: state.trades
                        .map((trade) => ListTile(
                              title: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Cell(trade.fDate, align: TextAlign.center),
                                  Cell(trade.bos, align: TextAlign.center),
                                  Cell(trade.fQuantity,
                                      align: TextAlign.center),
                                  Cell(trade.stock, align: TextAlign.center),
                                  Cell(trade.fExpiry, align: TextAlign.center),
                                  Cell(trade.fStrike, align: TextAlign.center),
                                  Cell(trade.poc ?? '',
                                      align: TextAlign.center),
                                  Cell(trade.fProceeds),
                                  Cell(trade.fCommission),
                                  Cell(trade.fCash),
                                  Cell(trade.fRisk),
                                  Cell(trade.asset, align: TextAlign.center),
                                  Cell(trade.ooc, align: TextAlign.center),
                                  Cell(trade.fMultiplier,
                                      align: TextAlign.center),
                                  Cell(trade.notes ?? '',
                                      align: TextAlign.center),
                                  Cell(trade.tradeid ?? '',
                                      align: TextAlign.center),
                                  Cell(trade.fFx, align: TextAlign.center),
                                  Cell(trade.description,
                                      align: TextAlign.left),
                                ],
                              ),
                              // onTap: () => Navigator.push(context, ),
                            ))
                        .toList(),
                  )),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              Cell(state.sumQuantity, align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              Cell(state.sumProceeds),
              Cell(state.sumCommission),
              Cell(state.sumCash),
              Cell(state.sumRisk),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.center),
              const Cell('', align: TextAlign.left),
            ],
          ),
        )
      ],
    );
  }
}

// #TODO: Consider different screens for options and stock trades

