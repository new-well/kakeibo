import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String? category;
  final int? amount;

  History({this.category, this.amount});

  factory History.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return History(
      category: data?['category'],
      amount: data?['amount'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (category != null) "category": category,
      if (amount != null) "amount": amount,
    };
  }
}
