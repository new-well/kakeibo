// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:kakeibo/start_page.dart';
//
// import 'package:kakeibo/user.dart';
//
// class SigninPage extends StatefulWidget {
//   const SigninPage({Key? key, required this.writeFunc}) : super(key: key);
//   final Function writeFunc;
//
//   @override
//   State<SigninPage> createState() => _SigninPageState();
// }
//
// class _SigninPageState extends State<SigninPage> {
//   User user = User(
//     name: '',
//   );
//
//   final _userNameEditingController = TextEditingController();
//   final _nonFocusNode = FocusNode();
//   final _formKey = GlobalKey<FormState>();
//
//   final userCollectionRef =
//       FirebaseFirestore.instance.collection('user').withConverter(
//             fromFirestore: User.fromFirestore,
//             toFirestore: (User wallet, _) => wallet.toFirestore(),
//           );
//
//   void _addUser(User newUser) async {
//     await userCollectionRef
//         .add(newUser)
//         .then((documentSnapshot) => {widget.writeFunc(documentSnapshot.id)});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Focus(
//       focusNode: _nonFocusNode,
//       child: GestureDetector(
//         onTap: _nonFocusNode.requestFocus,
//         child: Center(
//           child: Container(
//             padding: const EdgeInsets.only(right: 20, left: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const Text(
//                   'シェアする家計簿を使ってみよう',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Form(
//                   key: _formKey,
//                   child: TextFormField(
//                     controller: _userNameEditingController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'ユーザ名を入力してください';
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       border: UnderlineInputBorder(),
//                       labelText: 'ユーザ名を入力',
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       String? name = _userNameEditingController.text;
//                       User newUser = User(
//                         name: name,
//                       );
//                       _addUser(newUser);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const StartPage()));
//                     }
//                   },
//                   child: const Text("始める"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
