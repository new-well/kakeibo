import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountDrawer extends StatelessWidget {
  const AccountDrawer({Key? key, required this.user}) : super(key: key);
  final User? user;

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
                child: Text(
                  '${user?.displayName}',
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
