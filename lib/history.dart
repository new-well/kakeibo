import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String? key;
  final String? category;
  final String? name;
  final int? amount;
  final String? walletKey;
  final Timestamp? createdAt;

  History(
      {this.key,
      this.category,
      this.name,
      this.amount,
      this.walletKey,
      this.createdAt});

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
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (category != null) 'category': category,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (walletKey != null) 'walletKey': walletKey,
      if (createdAt != null)
        'createdAt': createdAt
      else
        'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
