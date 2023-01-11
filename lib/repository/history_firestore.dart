import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kakeibo/model/history.dart';
import 'package:kakeibo/model/user.dart';
import 'package:kakeibo/repository/shared_prefs.dart';
import 'package:kakeibo/repository/user_firestore.dart';

class HistoryFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _historyCollectionRef =
      _firebaseFirestoreInstance.collection('history').withConverter(
            fromFirestore: History.fromFirestore,
            toFirestore: (History history, _) => history.toFirestore(),
          );

  static final historySnapshot = _historyCollectionRef
      .where('createdUserUid', isEqualTo: SharedPrefs.fetchUid())
      .orderBy('createdAt', descending: true)
      .snapshots();

  static Future<List<History>?> fetchHistories(String uid) async {
    try {
      final snapshot = await _historyCollectionRef
          .where('createdUserUid', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .get();
      List<History> histories = snapshot.docs.map((doc) => doc.data()).toList();
      debugPrint('履歴取得処理終了 ==============');
      return histories;
    } catch (e) {
      debugPrint('履歴取得処理失敗 ==============$e');
      return null;
    }
  }

  static void addHistory(History history) async {
    try {
      String myUid = SharedPrefs.fetchUid()!;
      User? user = await UserFirestore.fetchProfile(myUid);
      if (user != null) {
        history.createdUserUid = myUid;
        history.createdUserName = user.name;
        _historyCollectionRef.add(history);
      } else {
        throw Exception('ユーザ情報の取得失敗: ${StackTrace.current.toString()}');
      }
    } catch (e) {
      debugPrint('履歴追加処理失敗 ==============$e');
    }
  }
}
