import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/model/history.dart';
import 'package:kakeibo/model/history_category.dart';
import 'package:kakeibo/pages/account_setting_page.dart';
import 'package:kakeibo/repository/history_firestore.dart';
import 'package:kakeibo/widgets/history_input_dialog.dart';

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
      body: StreamBuilder<QuerySnapshot<History>>(
          stream: HistoryFirestore.historySnapshot,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<History> histories =
                  snapshot.data!.docs.map((doc) => doc.data()).toList();
              return Padding(
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
                                subtitle: Text(datetimeFormatter.format(
                                    DateTime.parse(histories[index]
                                        .createdAt
                                        .toString()))),
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
              );
            } else {
              return const Center(
                child: Text(
                  'お買い物の履歴を登録しよう！！',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          History? history = await showDialog(
            context: context,
            builder: (BuildContext context) => const HistoryInputDialog(),
          );
          if (history != null) HistoryFirestore.addHistory(history);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
