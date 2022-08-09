import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakeibo/dropdown_item.dart';

import 'package:kakeibo/history.dart';

class HistoryInputDialog extends StatefulWidget {
  const HistoryInputDialog({Key? key}) : super(key: key);

  @override
  State<HistoryInputDialog> createState() => _HistoryInputDialogState();
}

class _HistoryInputDialogState extends State<HistoryInputDialog> {
  String? dropdownValue;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _amoutFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: _focusNode.requestFocus,
        child: AlertDialog(
          title: const Text('利用した金額を入力'),
          content: Form(
            key: _amoutFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  hint: const Text('カテゴリ'),
                  icon: const Icon(Icons.expand_more),
                  elevation: 8,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: HistoryCategory.values
                      .map<DropdownMenuItem<String>>((HistoryCategory value) {
                    return DropdownMenuItem<String>(
                      value: value.itemName,
                      child: Text(value.itemName),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'カテゴリを選択してください。';
                  },
                ),
                TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: '金額を入力',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return '金額を入力してください。';
                    if (int.parse(value) == 0) return '0円の金額は入力できません。';
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
                  int amount = int.parse(_textEditingController.text);
                  Navigator.pop<History>(context, History(amount));
                }
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
