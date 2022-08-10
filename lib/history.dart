import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kakeibo/history_category.dart';

class History {
  final String? key;
  final String? category;
  final String? name;
  final int? amount;

  History({this.key, this.category, this.name, this.amount});

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
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (category != null) 'category': category,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
    };
  }
}
