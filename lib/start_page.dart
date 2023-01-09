import 'package:flutter/material.dart';
import 'package:kakeibo/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kakeibo/home_page.dart';
import 'package:kakeibo/signin_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String uid = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid') ?? 'user_id_is_undefined';
    });
  }

  Future<String> _futureLoadedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid') ?? 'user_id_is_undefind';
  }

  void _writeUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  @override
  Widget build(BuildContext context) {
    final futureLoadedValue = _futureLoadedValue();

    return FutureBuilder(
        future: futureLoadedValue,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: const Text('シェアする家計簿')),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text('シェアする家計簿')),
              body: Center(child: Text(snapshot.error.toString())),
            );
          } else {
            if (snapshot.data == 'user_id_is_undefind') {
              return SigninPage(
                writeFunc: _writeUid,
              );
            } else {
              return HomePage(
                title: 'シェアする家計簿',
                user: User(name: 'aaa'),
              );
            }
          }
        });
  }
}
