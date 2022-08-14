import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kakeibo/wallet.dart';
import 'package:kakeibo/wallet_drawer_header.dart';
import 'package:kakeibo/wallet_id_input_dialog.dart';
import 'package:kakeibo/wallet_input_dialog.dart';

class WalletDrawer extends StatefulWidget {
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
  State<WalletDrawer> createState() => _WalletDrawerState();
}

class _WalletDrawerState extends State<WalletDrawer> {
  bool isEdit = false;

  void changeIsEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double drawerHeaderHeight = 80;
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
              WalletDrawerHeader(
                height: drawerHeaderHeight,
                onTapFunc: () => changeIsEdit,
              ),
              SizedBox(
                height: widget.height -
                    drawerHeaderHeight -
                    drawerMarginHeight -
                    drawerFooterHeight,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: widget.wallets.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: isEdit
                            ? TextButton(
                                child: const Icon(Icons.clear),
                                onPressed: () async {
                                  bool ok = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text("確認"),
                                      content: const Text("削除します。よろしいですか？"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text("削除")),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text("キャンセル"),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (ok) widget.removeWalletFunc(index);
                                },
                              )
                            : TextButton(
                                child: const Icon(Icons.copy),
                                onPressed: () async {
                                  final data = ClipboardData(
                                      text: widget.wallets[index].key);
                                  Clipboard.setData(data);
                                },
                              ),
                        title: TextButton.icon(
                          label: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${widget.wallets[index].name}',
                            ),
                          ),
                          icon: const Icon(Icons.wallet),
                          onPressed: () {
                            widget.onTapFunc(index);
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
                          widget.addWalletFunc(Wallet(name: walletName));
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
                          widget.joinWalletFunc(walletId);
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
