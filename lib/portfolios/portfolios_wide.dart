import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base_items/base_route.dart';
import '../widgets/cell.dart';
import '../stocks/stock_provider.dart';
import 'portfolio_provider.dart';

class PortfoliosWide extends StatelessWidget {
  const PortfoliosWide({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PortfolioProvider>();
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Cell('PORTFOLIO', align: TextAlign.left),
              Cell('STOCKS'),
              Cell('PROCEEDS'),
              Cell('COMMISSION'),
              Cell('CASH'),
              Cell('RISK'),
              Cell('PROFIT'),
              Cell('DIVIDENDS'),
            ],
          ),
        ),
        Expanded(
            child: state.portfolios.isEmpty
                ? const Center(child: Text('You have no portfolios'))
                : ListView(
                    children: state.portfolios
                        .map((port) => ListTile(
                              title: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Cell(port.portfolio, align: TextAlign.left),
                                  Cell('${port.quantity}'),
                                  Cell(port.fProceeds),
                                  Cell(port.fCommission),
                                  Cell(port.fCash),
                                  Cell(port.fRisk),
                                  Cell(port.fProfit),
                                  Cell(port.fDividends),
                                ],
                              ),
                              onTap: () {
                                final stock = context.read<StockProvider>();
                                stock.init('portfolio=${port.portfolio}');
                                stock.message = port.portfolio;
                                Navigator.push(context, stockRoute());
                              },
                            ))
                        .toList(),
                  )),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Cell(state.sumQuantity),
              Cell(state.sumProceeds),
              Cell(state.sumCommission),
              Cell(state.sumCash),
              Cell(state.sumRisk),
              Cell(state.sumProfit),
              Cell(state.sumDividends),
            ],
          ),
        )
      ],
    );
  }
}
