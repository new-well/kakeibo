import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String? key;
  final String category;
  final String name;
  final int amount;
  final String walletKey;
  String? createdUserUid;
  String? createdUserName;
  final DateTime createdAt;

  History({
    this.key,
    required this.category,
    required this.name,
    required this.amount,
    required this.walletKey,
    this.createdUserUid,
    this.createdUserName,
    required this.createdAt,
  });

  factory History.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return History(
      key: snapshot.id,
      category: data?['category'],
      name: data?['name'],
      amount: data?['amount'],
      walletKey: data?['walletKey'],
      createdUserUid: data?['createdUserUid'],
      createdUserName: data?['createdUserName'],
      createdAt: data?['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'category': category,
      'name': name,
      'amount': amount,
      'walletKey': walletKey,
      if (createdUserUid != null) 'createdUserUid': createdUserUid,
      if (createdUserName != null) 'createdUserName': createdUserName,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
