import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kakeibo/firebase_options.dart';
import 'package:kakeibo/history.dart';
import 'package:kakeibo/history_input_dialog.dart';
import 'package:kakeibo/history_list.dart';
import 'package:kakeibo/total_amount_displayer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakeibo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'チキチキ家計簿'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _histories = [];
  final collectionRef =
      FirebaseFirestore.instance.collection('history').withConverter(
            fromFirestore: History.fromFirestore,
            toFirestore: (History history, _) => history.toFirestore(),
          );

  @override
  void initState() {
    super.initState();
    featchHistories();
  }

  Future<void> featchHistories() async {
    final querySnapshot = await collectionRef.get();
    setState(() {
      _histories = querySnapshot.docs
          .map(
            (doc) => doc.data(),
          )
          .toList();
    });
  }

  void _addHistory(History history) async {
    await collectionRef.doc().set(history);
    featchHistories();
  }

  void _removeHistory(int index) async {
    // todo
    //   FirebaseFirestore.instance
    //       .doc('history/sample_wallet')
    //       .set({'amt': _histories});
  }

  int _calculateHistory() {
    int totalAmount = 0;
    if (_histories.isNotEmpty) {
      for (History history in _histories) {
        totalAmount += history.amount!;
      }
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    double maxHeight = size.height - padding.top - padding.bottom - 50;

    final double resultAreaHeight = maxHeight * (20 / 100);
    final double historyAreaHeight = maxHeight * (80 / 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: <Widget>[
            TotalAmountDisplayer(
              num: _calculateHistory(),
              boxHeight: resultAreaHeight,
            ),
            HistoryList(
              histories: _histories,
              scrollAreaHeight: historyAreaHeight,
              dismissibleFunc: _removeHistory,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          History? history = await showDialog(
            context: context,
            builder: (BuildContext context) => const HistoryInputDialog(),
          );
          if (history != null) _addHistory(history);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
