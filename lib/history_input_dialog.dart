import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryInputDialog extends StatefulWidget {
  const HistoryInputDialog({Key? key}) : super(key: key);

  @override
  State<HistoryInputDialog> createState() => _HistoryInputDialogState();
}

class _HistoryInputDialogState extends State<HistoryInputDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  final _amoutFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('利用した金額を入力'),
      content: Form(
        key: _amoutFormKey,
        child: TextFormField(
          controller: _textEditingController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '金額を入力',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '金額を入力してください。';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 0);
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            if (_amoutFormKey.currentState!.validate()) {
              int amount = int.parse(_textEditingController.text);
              Navigator.pop<int>(context, amount);
            }
          },
          child: const Text('追加'),
        ),
      ],
    );
  }
}
