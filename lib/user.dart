import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? key;
  final String? name;
  final Timestamp? createdAt;

  User({this.key, this.name, this.createdAt});

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      key: snapshot.id,
      name: data?['name'],
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) 'name': name,
      if (createdAt != null)
        'createdAt': createdAt
      else
        'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
