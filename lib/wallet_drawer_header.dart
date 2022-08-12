import 'package:flutter/material.dart';

class WalletDrawerHeader extends StatelessWidget {
  const WalletDrawerHeader({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          'おさいふ',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}
