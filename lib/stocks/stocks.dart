import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base_items/base_route.dart';
import '../positions/positions_provider.dart';
import '../widgets/cell.dart';
import '../widgets/header.dart';
import 'stock_provider.dart';

class Stocks extends StatelessWidget {
  const Stocks({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StockProvider>();
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Header('STOCK', align: TextAlign.center, sort: state.sortBy),
              Header('OPEN', align: TextAlign.center, sort: state.sortBy),
              Header('CLOSED', align: TextAlign.center, sort: state.sortBy),
              Header('PROCEEDS', sort: state.sortBy),
              Header('COMMISSION', sort: state.sortBy),
              Header('CASH', sort: state.sortBy),
              Header('RISK', sort: state.sortBy),
              Header('QTY', align: TextAlign.center, sort: state.sortBy),
              Header('PROFIT', sort: state.sortBy),
              Header('DIVIDENDS', sort: state.sortBy),
            ],
          ),
        ),
        Expanded(
          child: state.stocks.isEmpty
              ? const Center(child: Text('No stocks found'))
              : ListView(
                  children: state.stocks
                      .map((stock) => ListTile(
                            title: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Cell(stock.stock, align: TextAlign.center),
                                Cell('${stock.open.length}',
                                    align: TextAlign.center),
                                Cell('${stock.closed.length}',
                                    align: TextAlign.center),
                                Cell(stock.fProceeds),
                                Cell(stock.fCommission),
                                Cell(stock.fCash),
                                Cell(stock.fRisk),
                                Cell('${stock.quantity}',
                                    align: TextAlign.center),
                                Cell(stock.fProfit),
                                Cell(stock.fDividends),
                              ],
                            ),
                            onTap: () {
                              final positions =
                                  context.read<PositionProvider>();
                              positions.init('stock=${stock.stock}');
                              positions.message = stock.stock;
                              Navigator.push(context, positionRoute());
                            },
                          ))
                      .toList(),
                ),
        ),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Cell(state.stocks.length.toString(), align: TextAlign.center),
              Cell(state.sumOpen, align: TextAlign.center),
              Cell(state.sumClosed, align: TextAlign.center),
              Cell(state.sumProceeds),
              Cell(state.sumCommission),
              Cell(state.sumCash),
              Cell(state.sumRisk),
              Cell(state.sumQuantity, align: TextAlign.center),
              Cell(state.sumProfit),
              Cell(state.sumDividends),
            ],
          ),
        )
      ],
    );
  }
}
