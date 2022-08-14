import 'package:flutter/material.dart';

class WalletDrawerHeader extends StatelessWidget {
  const WalletDrawerHeader(
      {Key? key, required this.height, required this.onTapFunc})
      : super(key: key);

  final double height;
  final Function onTapFunc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).canvasColor,
            ),
            onPressed: onTapFunc(),
          ),
          title: Text(
            'おさいふ',
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
