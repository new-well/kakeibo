class History {
  final String key;
  final String category;
  final String name;
  final int amount;
  final String walletKey;
  String createdUserUid;
  String createdUserName;
  final DateTime createdAt;

  History({
    required this.key,
    required this.category,
    required this.name,
    required this.amount,
    required this.walletKey,
    required this.createdUserUid,
    required this.createdUserName,
    required this.createdAt,
  });
}
