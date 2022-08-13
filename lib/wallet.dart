import 'package:cloud_firestore/cloud_firestore.dart';

class Wallet {
  final String? key;
  final String? name;
  List? userUids;
  final Timestamp? createdAt;

  Wallet({this.key, this.name, this.userUids, this.createdAt});

  factory Wallet.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Wallet(
      key: snapshot.id,
      name: data?['name'],
      userUids: data?['nauserUidsme'],
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) 'name': name,
      if (userUids != null) 'userUids': userUids,
      if (createdAt != null)
        'createdAt': createdAt
      else
        'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
