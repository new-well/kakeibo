import 'package:flutter/material.dart';
import 'package:kakeibo/wallet.dart';
import 'package:kakeibo/wallet_drawer_header.dart';

class WalletDrawer extends StatefulWidget {
  const WalletDrawer(
      {Key? key,
      required this.height,
      required this.wallets,
      required this.onTapFunc,
      required this.addWalletFunc})
      : super(key: key);

  final double height;
  final List wallets;
  final Function onTapFunc;
  final Function addWalletFunc;

  @override
  State<WalletDrawer> createState() => _WalletDrawerState();
}

class _WalletDrawerState extends State<WalletDrawer> {
  bool isEdit = false;
  final _nameEditingController = TextEditingController();
  final _nonFocusNode = FocusNode();
  static const double drawerHeaderHeight = 70;
  static const double drawerMarginHeight = 100;

  @override
  void dispose() {
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _nonFocusNode,
      child: GestureDetector(
        onTap: _nonFocusNode.requestFocus,
        child: SafeArea(
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
                    height:
                        widget.height - drawerHeaderHeight - drawerMarginHeight,
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: widget.wallets.length + 1,
                        itemBuilder: (context, index) {
                          if (index != widget.wallets.length) {
                            return ListTile(
                              leading: const Icon(Icons.wallet),
                              title: Text(
                                '${widget.wallets[index].name}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              onTap: () {
                                widget.onTapFunc(index);
                                Navigator.pop(context);
                              },
                            );
                          } else if (!isEdit) {
                            return ListTile(
                              leading: const Icon(Icons.add),
                              title: const Text(
                                '新しいおさいふの追加',
                                style: TextStyle(fontSize: 16),
                              ),
                              onTap: () {
                                setState(() {
                                  isEdit = true;
                                });
                              },
                            );
                          } else {
                            return ListTile(
                              leading: const Icon(Icons.wallet),
                              title: TextField(
                                controller: _nameEditingController,
                                autofocus: true,
                                onSubmitted: (value) {
                                  Navigator.pop(context);
                                  widget.addWalletFunc(Wallet(name: value));
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
