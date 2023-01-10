import 'package:flutter/material.dart';
import 'package:kakeibo/model/user.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User(
      key: 'abc',
      name: 'arai',
      createdAt: DateTime(2022, 12, 31, 12, 00),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント設定'),
      ),
      body: Text(user.name),
    );
  }
}
