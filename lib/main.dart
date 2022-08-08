import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'history.dart';
import 'total_amount_displayer.dart';
import 'history_input_dialog.dart';
import 'history_list.dart';

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
  List<dynamic> _histories = [];

  @override
  void initState() {
    super.initState();
    featchHistories();
  }

  Future<void> featchHistories() async {
    await FirebaseFirestore.instance
        .doc('history/sample_data')
        .get()
        .then((DocumentSnapshot snapshot) {
      var amt = snapshot.get('amt');
      setState(() {
        _histories = amt;
      });
    });
  }

  void _addHistory(History history) {
    setState(() {
      _histories.add(history.amount);
    });
    FirebaseFirestore.instance
        .doc('history/sample_data')
        .set({'amt': _histories});
  }

  void _removeHistory(int index) {
    setState(() {
      _histories.removeAt(index);
    });
    FirebaseFirestore.instance
        .doc('history/sample_data')
        .set({'amt': _histories});
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
              num: _histories.isNotEmpty
                  ? _histories.reduce((value, element) => value + element)
                  : 0,
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
