import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakeibo/start_page.dart';

import 'package:kakeibo/firebase_options.dart';

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
      home: const StartPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
