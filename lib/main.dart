import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakeibo/model/history.dart';
import 'package:kakeibo/pages/top_page.dart';
import 'package:kakeibo/repository/history_firestore.dart';
import 'package:kakeibo/repository/shared_prefs.dart';
import 'package:kakeibo/repository/user_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPrefs.setInstance();
  String? myUid = SharedPrefs.fetchUid();
  if (myUid == null) {
    myUid = await UserFirestore.createUser();
    await SharedPrefs.setUid(myUid!);
  }

  List<History>? histories = await HistoryFirestore.fetchHistories(myUid);
  print(histories);
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
      home: const TopPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
