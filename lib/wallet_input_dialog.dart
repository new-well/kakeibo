import 'package:flutter/material.dart';

class WalletInputDialog extends StatefulWidget {
  const WalletInputDialog({Key? key}) : super(key: key);

  @override
  State<WalletInputDialog> createState() => _WalletInputDialogState();
}

class _WalletInputDialogState extends State<WalletInputDialog> {
  String? dropdownValue;
  final _nameEditingController = TextEditingController();
  final _nonFocusNode = FocusNode();
  final _amoutFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _nonFocusNode,
      child: GestureDetector(
        onTap: _nonFocusNode.requestFocus,
        child: AlertDialog(
          title: const Text('作成するおさいふの名前を入力してください'),
          content: Form(
            key: _amoutFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'おさいふの名前を入力',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return '名前を入力してください。';
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                if (_amoutFormKey.currentState!.validate()) {
                  Navigator.pop<String?>(context, _nameEditingController.text);
                }
              },
              child: const Text('作成'),
            ),
          ],
        ),
      ),
    );
  }
}
