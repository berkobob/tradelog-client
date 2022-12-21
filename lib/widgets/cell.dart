import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  const Cell(this.text, {super.key, this.align = TextAlign.right});
  final String text;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    int flex;
    switch (align) {
      case TextAlign.center:
        flex = 2;
        break;
      case TextAlign.left:
        flex = 3;
        break;
      case TextAlign.right:
        flex = 3;
        break;
      default:
        throw ('We have a cell with a strange alignment of $align');
    }
    return Expanded(
      flex: flex,
      child: Text(
        overflow: TextOverflow.fade,
        softWrap: false,
        text,
        textAlign: align,
      ),
    );
  }
}
