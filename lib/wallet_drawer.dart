import 'package:flutter/material.dart';

class WalletDrawer extends StatelessWidget {
  const WalletDrawer(
      {Key? key,
      required this.height,
      required this.wallets,
      required this.onTapFunc})
      : super(key: key);

  final double height;
  final List wallets;
  final Function onTapFunc;
  static const double drawerHeaderHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: drawerHeaderHeight,
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
          ),
          SizedBox(
            height: height - drawerHeaderHeight,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.wallet),
                    title: Text(
                      '${wallets[index].name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      onTapFunc(index);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
