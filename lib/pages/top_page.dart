import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/model/history.dart';
import 'package:kakeibo/model/history_category.dart';
import 'package:kakeibo/pages/account_setting_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    var numberFormatter = NumberFormat("#,###");
    var datetimeFormatter = DateFormat('yyyy/MM/dd');

    List<History> histories = [
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
      History(
        key: 'abc',
        category: 'food',
        name: '夕ご飯',
        amount: 1000,
        walletKey: 'abc',
        createdUserUid: 'abc',
        createdUserName: 'たろう',
        createdAt: DateTime(2022, 12, 31, 12, 00),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("シェアする家計簿"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountSettingPage()));
            },
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('現在の使用金額'),
            Text(
              '¥${numberFormatter.format(histories.fold(0, (int prev, element) => prev + element.amount))}',
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            const Text('一覧'),
            Expanded(
              child: ListView.builder(
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    child: Card(
                      child: ListTile(
                        leading: Icon(HistoryCategory.values
                            .byName(histories[index].category)
                            .icon),
                        title: Text(histories[index].name),
                        subtitle: Text(datetimeFormatter.format(DateTime.parse(
                            histories[index].createdAt.toString()))),
                        trailing: Text(
                            '¥${numberFormatter.format(histories[index].amount)}'),
                      ),
                    ),
                    onDismissed: (direction) {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
