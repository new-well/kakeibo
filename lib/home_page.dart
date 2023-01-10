// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:kakeibo/accout_drawer.dart';
//
// import 'package:kakeibo/history.dart';
// import 'package:kakeibo/history_input_dialog.dart';
// import 'package:kakeibo/history_list.dart';
// import 'package:kakeibo/signin_page.dart';
// import 'package:kakeibo/total_amount_displayer.dart';
// import 'package:kakeibo/user.dart';
// import 'package:kakeibo/wallet.dart';
// import 'package:kakeibo/wallet_drawer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.user}) : super(key: key);
//   final User user;
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   bool signedIn = false;
//   int sellectedWalletIndex = 0;
//   List wallets = [];
//   List histories = [];
//   final walletCollectionRef =
//       FirebaseFirestore.instance.collection('wallet').withConverter(
//             fromFirestore: Wallet.fromFirestore,
//             toFirestore: (Wallet wallet, _) => wallet.toFirestore(),
//           );
//   final historyCollectionRef =
//       FirebaseFirestore.instance.collection('history').withConverter(
//             fromFirestore: History.fromFirestore,
//             toFirestore: (History history, _) => history.toFirestore(),
//           );
//
//   @override
//   void initState() {
//     super.initState();
//     isSignedIn();
//     fetchWallets().then((value) {
//       if (wallets.isNotEmpty) fetchHistories();
//     });
//   }
//
//   Future<void> isSignedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String uid = prefs.getString('uid') ?? 'user_id_is_undefined';
//
//     if (uid != 'user_id_is_undefined') {
//       setState(() {
//         signedIn = true;
//       });
//     }
//   }
//
//   void _removeAcountInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('uid');
//   }
//
//   Future<void> fetchWallets() async {
//     final querySnapshot = await walletCollectionRef
//         .where('userUids', arrayContains: widget.user.key)
//         .orderBy('createdAt')
//         .get();
//     if (mounted) {
//       setState(() {
//         wallets = querySnapshot.docs.map((doc) => doc.data()).toList();
//       });
//     }
//   }
//
//   Future<void> fetchHistories() async {
//     final querySnapshot = await historyCollectionRef
//         .where('walletKey', isEqualTo: wallets[sellectedWalletIndex].key)
//         .orderBy('createdAt', descending: true)
//         .get();
//     if (mounted) {
//       setState(() {
//         histories = querySnapshot.docs.map((doc) => doc.data()).toList();
//       });
//     }
//   }
//
//   void _addWallet(Wallet wallet) async {
//     wallet.userUids = [widget.user.key];
//     await walletCollectionRef.doc().set(wallet);
//     fetchWallets();
//   }
//
//   void _addHistory(History history) async {
//     history.createdUserUid = widget.user.key;
//     history.createdUserName = widget.user.name;
//     await historyCollectionRef.doc().set(history);
//     fetchHistories();
//   }
//
//   void _removeWallet(int index) async {
//     setState(() {
//       sellectedWalletIndex = 0;
//     });
//     await walletCollectionRef.doc(wallets[index].key).delete();
//     fetchWallets();
//   }
//
//   void _removeHistory(int index) async {
//     await historyCollectionRef.doc(histories[index].key).delete();
//     fetchHistories();
//   }
//
//   void _joinWallet(String walletId) async {
//     await walletCollectionRef.doc(walletId).update({
//       'userUids': FieldValue.arrayUnion([widget.user.key]),
//     });
//     fetchWallets();
//   }
//
//   int _calculateHistory() {
//     int totalAmount = 0;
//     if (histories.isNotEmpty) {
//       for (History history in histories) {
//         totalAmount += history.amount!;
//       }
//     }
//     return totalAmount;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final EdgeInsets padding = MediaQuery.of(context).padding;
//     double maxHeight = size.height - padding.top - padding.bottom - 100;
//
//     final double resultAreaHeight = maxHeight * (20 / 100);
//     final double historyAreaHeight = maxHeight * (80 / 100);
//
//     return Scaffold(
//       key: _scaffoldKey,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//           title: wallets.isEmpty
//               ? const Text('')
//               : Text(wallets[sellectedWalletIndex].name),
//           actions: <Widget>[
//             IconButton(
//               onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
//               icon: const Icon(Icons.account_circle),
//             ),
//           ]),
//       body: !signedIn
//           ? SigninPage()
//           : wallets.isEmpty
//               ? const Center(
//                   child: Text(
//                     '右にスワイプして\n新しいおさいふを作成しよう',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 )
//               : Container(
//                   padding: const EdgeInsets.only(right: 20, left: 20),
//                   child: Column(
//                     children: <Widget>[
//                       TotalAmountDisplayer(
//                         num: _calculateHistory(),
//                         boxHeight: resultAreaHeight,
//                       ),
//                       HistoryList(
//                         histories: histories,
//                         scrollAreaHeight: historyAreaHeight,
//                         dismissibleFunc: _removeHistory,
//                       ),
//                     ],
//                   ),
//                 ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           History? history = await showDialog(
//             context: context,
//             builder: (BuildContext context) => HistoryInputDialog(
//                 walletKey: wallets[sellectedWalletIndex].key),
//           );
//           if (history != null) _addHistory(history);
//         },
//         child: const Icon(Icons.add),
//       ),
//       drawer: WalletDrawer(
//         height: size.height,
//         wallets: wallets,
//         onTapFunc: (int index) {
//           setState(() {
//             sellectedWalletIndex = index;
//           });
//           fetchHistories();
//         },
//         addWalletFunc: _addWallet,
//         joinWalletFunc: _joinWallet,
//         removeWalletFunc: _removeWallet,
//       ),
//       endDrawer: AccountDrawer(
//         user: widget.user,
//         deleteFunc: _removeAcountInfo,
//       ),
//     );
//   }
// }
