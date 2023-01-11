import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kakeibo/model/user.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstance.collection('user');

  static Future<String?> createUser() async {
    try {
      final newDoc = await _userCollection.add({
        'name': 'takahiro',
        'createdAt': DateTime.now(),
      });
      debugPrint('ユーザ作成完了 ==============');
      return newDoc.id;
    } catch (e) {
      debugPrint('ユーザ作成処理失敗 ==============$e');
      return null;
    }
  }

  static Future<User?> fetchProfile(String uid) async {
    try {
      final myProfile = await _userCollection.doc(uid).get();
      User user = User(
        key: uid,
        name: myProfile.data()!['name'],
        createdAt: myProfile.data()!['createdAt'].toDate(),
      );
      return user;
    } catch (e) {
      debugPrint('プロフィール取得処理失敗 ==============$e');
      return null;
    }
  }
}
