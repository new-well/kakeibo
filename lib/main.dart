import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final TextEditingController _textEditingController = TextEditingController();

  int _counter = 0;
  int _addNum = 0;
  List<dynamic> _history = [];

  @override
  void initState() {
    super.initState();
    featchHistory();
  }

  Future<void> featchHistory() async {
    await FirebaseFirestore.instance
        .doc('history/sample_data')
        .get()
        .then((DocumentSnapshot snapshot) {
      var amt = snapshot.get('amt');
      debugPrint(amt.toString());
      setState(() {
        _history = amt;
      });
      _refreshCounter();
    });
  }

  void _refreshCounter() {
    setState(() {
      if (_addNum != 0) {
        _history.add(_addNum);
        _addNum = 0;
      }
      _counter = _history.isNotEmpty
          ? _history.reduce((value, element) => value + element)
          : 0;
      _textEditingController.clear();
      FirebaseFirestore.instance
          .doc('history/sample_data')
          .set({'amt': _history});
    });
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    final size = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    double maxHeight = size.height - padding.top - padding.bottom - 50;

    // 計算結果エリアの高さ
    final double resultAreaHeight = maxHeight * (30 / 100);
    // 履歴表示エリアの高さ
    final double historyAreaHeight = maxHeight * (70 / 100);
    // テキスト履歴の文字エリアの高さ
    const double historyHeaderAreaHeight = 30;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: size.width,
                height: resultAreaHeight,
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('現在の利用金額'),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '金額を入力',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _addNum = value == "" ? 0 : int.parse(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: historyAreaHeight,
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: historyHeaderAreaHeight,
                      width: size.width,
                      child: const Text('一覧'),
                    ),
                    SizedBox(
                      height: historyAreaHeight - historyHeaderAreaHeight,
                      width: size.width,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: _history.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: UniqueKey(),
                              child: Card(
                                child: ListTile(
                                  title: Text('${_history[index]}'),
                                ),
                              ),
                              onDismissed: (direction) {
                                setState(() {
                                  _history.removeAt(index);
                                });
                                _refreshCounter();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _refreshCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
