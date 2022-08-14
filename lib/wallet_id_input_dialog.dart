import 'package:flutter/material.dart';

class WalletIdInputDialog extends StatefulWidget {
  const WalletIdInputDialog({Key? key}) : super(key: key);

  @override
  State<WalletIdInputDialog> createState() => _WalletIdInputDialogState();
}

class _WalletIdInputDialogState extends State<WalletIdInputDialog> {
  final _idEditingController = TextEditingController();
  final _nonFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _idEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _nonFocusNode,
      child: GestureDetector(
        onTap: _nonFocusNode.requestFocus,
        child: AlertDialog(
          title: const Text('参加するおさいふのおさいふIDを入力してください'),
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _idEditingController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'おさいふIDを入力',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'おさいふIDを入力してください。';
                    }
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
                if (_formKey.currentState!.validate()) {
                  Navigator.pop<String?>(context, _idEditingController.text);
                }
              },
              child: const Text('参加'),
            ),
          ],
        ),
      ),
    );
  }
}
