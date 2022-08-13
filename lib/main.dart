import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kakeibo/firebase_options.dart';
import 'package:kakeibo/history.dart';
import 'package:kakeibo/history_input_dialog.dart';
import 'package:kakeibo/history_list.dart';
import 'package:kakeibo/total_amount_displayer.dart';
import 'package:kakeibo/wallet.dart';
import 'package:kakeibo/wallet_drawer.dart';

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
  int sellectedWalletIndex = 0;
  List wallets = [];
  List histories = [];
  final walletCollectionRef =
      FirebaseFirestore.instance.collection('wallet').withConverter(
            fromFirestore: Wallet.fromFirestore,
            toFirestore: (Wallet wallet, _) => wallet.toFirestore(),
          );
  final historyCollectionRef =
      FirebaseFirestore.instance.collection('history').withConverter(
            fromFirestore: History.fromFirestore,
            toFirestore: (History history, _) => history.toFirestore(),
          );

  @override
  void initState() {
    super.initState();
    featchWallets().then((value) {
      if (wallets.isNotEmpty) featchHistories();
    });
  }

  Future<void> featchWallets() async {
    final querySnapshot = await walletCollectionRef.orderBy('createdAt').get();
    setState(() {
      wallets = querySnapshot.docs
          .map(
            (doc) => doc.data(),
          )
          .toList();
    });
  }

  Future<void> featchHistories() async {
    final querySnapshot = await historyCollectionRef
        .where('walletKey', isEqualTo: wallets[sellectedWalletIndex].key)
        .orderBy('createdAt', descending: true)
        .get();
    setState(() {
      histories = querySnapshot.docs
          .map(
            (doc) => doc.data(),
          )
          .toList();
    });
  }

  void _addWallet(Wallet wallet) async {
    await walletCollectionRef.doc().set(wallet);
    featchWallets();
  }

  void _addHistory(History history) async {
    await historyCollectionRef.doc().set(history);
    featchHistories();
  }

  void _removeWallet(int index) async {
    await walletCollectionRef.doc(wallets[index].key).delete();
    featchWallets();
  }

  void _removeHistory(int index) async {
    await historyCollectionRef.doc(histories[index].key).delete();
    featchHistories();
  }

  int _calculateHistory() {
    int totalAmount = 0;
    if (histories.isNotEmpty) {
      for (History history in histories) {
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
        title: wallets.isEmpty
            ? const Text('')
            : Text(wallets[sellectedWalletIndex].name),
      ),
      body: wallets.isEmpty
          ? const Center(
              child: Text(
                '右にスワイプして\n新しいおさいふを作成しよう',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            )
          : Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  TotalAmountDisplayer(
                    num: _calculateHistory(),
                    boxHeight: resultAreaHeight,
                  ),
                  HistoryList(
                    histories: histories,
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
            builder: (BuildContext context) => HistoryInputDialog(
                walletKey: wallets[sellectedWalletIndex].key),
          );
          if (history != null) _addHistory(history);
        },
        child: const Icon(Icons.add),
      ),
      drawer: WalletDrawer(
        height: size.height,
        wallets: wallets,
        onTapFunc: (int index) {
          setState(() {
            sellectedWalletIndex = index;
          });
          featchHistories();
        },
        addWalletFunc: _addWallet,
        removeWalletFunc: _removeWallet,
      ),
    );
  }
}
