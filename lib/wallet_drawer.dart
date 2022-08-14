import 'package:flutter/material.dart';

import 'package:kakeibo/wallet.dart';
import 'package:kakeibo/wallet_drawer_header.dart';
import 'package:kakeibo/wallet_id_input_dialog.dart';
import 'package:kakeibo/wallet_input_dialog.dart';

class WalletDrawer extends StatelessWidget {
  const WalletDrawer(
      {Key? key,
      required this.height,
      required this.wallets,
      required this.onTapFunc,
      required this.addWalletFunc,
      required this.joinWalletFunc,
      required this.removeWalletFunc})
      : super(key: key);

  final double height;
  final List wallets;
  final Function onTapFunc;
  final Function addWalletFunc;
  final Function joinWalletFunc;
  final Function removeWalletFunc;

  @override
  Widget build(BuildContext context) {
    const double drawerHeaderHeight = 70;
    const double drawerMarginHeight = 100;
    const double drawerFooterHeight = 120;

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Drawer(
          child: ListView(
            children: [
              const WalletDrawerHeader(height: drawerHeaderHeight),
              SizedBox(
                height: height -
                    drawerHeaderHeight -
                    drawerMarginHeight -
                    drawerFooterHeight,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: wallets.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: TextButton(
                          child: const Icon(Icons.clear),
                          onPressed: () => removeWalletFunc(index),
                        ),
                        title: TextButton.icon(
                          label: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${wallets[index].name}',
                            ),
                          ),
                          icon: const Icon(Icons.wallet),
                          onPressed: () {
                            onTapFunc(index);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: <Widget>[
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('新しいおさいふの追加'),
                      onTap: () async {
                        String? walletName = await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const WalletInputDialog());
                        if (walletName != null) {
                          addWalletFunc(Wallet(name: walletName));
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text('他の人のおさいふに参加'),
                      onTap: () async {
                        String? walletId = await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const WalletIdInputDialog());
                        if (walletId != null) {
                          joinWalletFunc(walletId);
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
