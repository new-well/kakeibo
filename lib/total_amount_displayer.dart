import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalAmountDisplayer extends StatelessWidget {
  const TotalAmountDisplayer(
      {Key? key, required this.num, required this.boxHeight})
      : super(key: key);

  final int num;
  final double boxHeight;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat("#,###");
    return SizedBox(
      height: boxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('現在の利用金額'),
          Text(
            '¥${formatter.format(num)}',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
