import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base_items/base_route.dart';
import '../positions/positions_provider.dart';
import '../widgets/cell.dart';
import 'stock_provider.dart';

class StocksWide extends StatelessWidget {
  const StocksWide({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StockProvider>();
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Cell('STOCK', align: TextAlign.left),
              Cell('OPEN', align: TextAlign.center),
              Cell('CLOSED', align: TextAlign.center),
              Cell('PROCEEDS'),
              Cell('COMMISSION'),
              Cell('CASH'),
              Cell('RISK'),
              Cell('QTY', align: TextAlign.center),
              Cell('PROFIT'),
              Cell('DIVIDENDS'),
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
                                  Cell(
                                    stock.stock,
                                    align: TextAlign.left,
                                  ),
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
                                final position =
                                    context.read<PositionProvider>();
                                position.init('stock=${stock.stock}');
                                position.message = stock.stock;
                                Navigator.push(context, positionRoute());
                              },
                            ))
                        .toList(),
                  )),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Cell(state.stocks.length.toString(), align: TextAlign.left),
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
