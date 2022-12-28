import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.text,
      {required this.sort, this.align = TextAlign.right, super.key});

  final TextAlign align;
  final String text;
  final Function sort;

  @override
  Widget build(BuildContext context) {
    int flex;
    switch (align) {
      case TextAlign.center:
        flex = 2;
        break;
      case TextAlign.left:
        flex = 4;
        break;
      case TextAlign.right:
        flex = 3;
        break;
      default:
        throw ('We have a cell with a strange alignment of $align');
    }

    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () => sort(text),
        splashColor: Theme.of(context).primaryColor,
        child: Text(text, textAlign: align, maxLines: 1),
      ),
    );
  }
}
