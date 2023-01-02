import 'package:flutter/material.dart';

class MobileView extends StatelessWidget {
  const MobileView(this.item, {super.key});
  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 3;
    final List<Widget> rows = [];

    item.forEach((key, value) => rows.add(
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(children: [
              Container(
                  alignment: Alignment.centerLeft,
                  width: width,
                  child: Text(key, textScaleFactor: 1.25)),
              Text(value, textScaleFactor: 1.25)
            ]),
          ),
        ));

    return Padding(
        padding: const EdgeInsets.all(8.0), child: ListView(children: rows));
  }
}
