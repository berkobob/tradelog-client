import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cell.dart';
import '../widgets/header.dart';
import 'trade_provider.dart';

class TradeWide extends StatelessWidget {
  const TradeWide({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TradeProvider>();
    final bool opt = state.trades[0].asset == 'OPT';
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Header('DATE', align: TextAlign.center, sort: state.sortBy),
              Header('BoS', align: TextAlign.center, sort: state.sortBy),
              Header('QTY', align: TextAlign.center, sort: state.sortBy),
              Header('STOCK', align: TextAlign.center, sort: state.sortBy),
              if (opt)
                Header('EXPIRY', align: TextAlign.center, sort: state.sortBy),
              if (opt)
                Header('STRIKE', align: TextAlign.center, sort: state.sortBy),
              if (opt)
                Header('PoC', align: TextAlign.center, sort: state.sortBy),
              Header('PROCEEDS', sort: state.sortBy),
              Header('COMMISSION', sort: state.sortBy),
              Header('CASH', sort: state.sortBy),
              Header('RISK', sort: state.sortBy),
              Header('ASSET', align: TextAlign.center, sort: state.sortBy),
              Header('OoC', align: TextAlign.center, sort: state.sortBy),
              Header('MULT', align: TextAlign.center, sort: state.sortBy),
              Header('NOTES', align: TextAlign.center, sort: state.sortBy),
              Header('ID', align: TextAlign.center, sort: state.sortBy),
              Header('FX', align: TextAlign.center, sort: state.sortBy),
              Header('DECRIPTION', align: TextAlign.left, sort: state.sortBy),
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
                                  if (opt)
                                    Cell(trade.fExpiry,
                                        align: TextAlign.center),
                                  if (opt)
                                    Cell(trade.fStrike,
                                        align: TextAlign.center),
                                  if (opt)
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
              if (opt) const Cell('', align: TextAlign.center),
              if (opt) const Cell('', align: TextAlign.center),
              if (opt) const Cell('', align: TextAlign.center),
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


// #TODO: Add menu e.g. all trades
// #TODO: Small screen views
// #TODO: Save and retrieve shared preferences i.e. settings


