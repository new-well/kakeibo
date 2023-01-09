import 'package:flutter/material.dart';

import 'package:kakeibo/user.dart';

class AccountDrawer extends StatelessWidget {
  const AccountDrawer({Key? key, required this.user, required this.deleteFunc})
      : super(key: key);
  final User user;
  final Function deleteFunc;

  static const double drawerHeaderHeight = 70;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: drawerHeaderHeight,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'アカウント情報',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Text(
                    '${user.name}',
                    style: const TextStyle(fontSize: 30),
                  ),
                  TextButton(
                    onPressed: () => deleteFunc(),
                    child: const Text('アカウント情報を削除'),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
